import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class WylyParkingScreen extends StatelessWidget {
  const WylyParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.inactiveGray,
      appBar: AppBar(
        title: const Text('Wyly Tower Parking'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 2.8, // Set the height to half of the screen
        child: GoogleMap(
          mapType: MapType.satellite,
          initialCameraPosition: const CameraPosition(
            target: LatLng(32.5284, -92.64769),
            zoom: 19.6,
            bearing: 106,
          ),
        ),
      ),
    );
  }
}
