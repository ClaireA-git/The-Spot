import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../mysql1.dart';
import '../Coordinates/latlng.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';

class CobParkingScreen extends StatefulWidget {
  @override
  _CobParkingScreenState createState() => _CobParkingScreenState();
}

class _CobParkingScreenState extends State<CobParkingScreen> {
  var db = Mysql();

  List<Map<String, dynamic>> parkingSpots = [];
  Set<Marker> _markers = {};

  Future<BitmapDescriptor> _resizeImage(
      String assetName, int width, int height) async {
    final ByteData byteData = await rootBundle.load(assetName);
    final ui.Codec codec = await ui.instantiateImageCodec(
        byteData.buffer.asUint8List(),
        targetWidth: width,
        targetHeight: height);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? resizedByteData =
    await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    if (resizedByteData == null) {
      throw Exception('Failed to load image');
    }
    final Uint8List resizedBytes = resizedByteData.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedBytes);
  }

  void _addMarkers() async {
    for (int i = 0; i < locations.length; i++) {
      final location = locations[i];
      final imageName =
      isParkingSpotAvailable(i + 1) ? 'green_${i + 1}.png' : 'white_${i + 1}.png';
      final image = await _resizeImage('assets/images/$imageName', 50, 50);
      final marker = Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        icon: image,
      );
      _markers.add(marker);
    }
    setState(() {});
  }

  bool isParkingSpotAvailable(int spotId) {
    final spot =
    parkingSpots.firstWhere((spot) => spot['spotID'] == spotId);
    return spot['isTaken'] == 0;
  }

  @override
  void initState() {
    super.initState();
    getSpots();
  }

  void getSpots() async {
    final conn = await db.getConnection();
    var results = await conn.query('SELECT * FROM cobbLot');
    setState(() {
      parkingSpots = results.map((row) => row.fields).toList();
      _addMarkers();
    });
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.inactiveGray,
      appBar: AppBar(
        title: const Text(
          'COB Parking',
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Refresh the database and spot information here
              getSpots();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.8,
            child: GoogleMap(
              mapType: MapType.satellite,
              initialCameraPosition: CameraPosition(
                target: LatLng(32.527205, -92.643685),
                zoom: 19.75,
                bearing: 4,
              ),
              markers: _markers,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: parkingSpots.length,
              itemBuilder: (context, index) {
                final spot = parkingSpots[index];
                final isTaken = spot['isTaken'] == 0;
                return ListTile(
                  title: Text('Parking Spot ${spot['spotID']}'),
                  subtitle: Text(isTaken ? 'Available' : 'Taken'),
                  tileColor: isTaken
                      ? CupertinoColors.systemGreen
                      : CupertinoColors.inactiveGray,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}