import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class NethkinParkingScreen extends StatelessWidget {
  const NethkinParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.inactiveGray,
      appBar: AppBar(
        title: const Text('Nethkin Parking'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 2.8, // Set the height to half of the screen
        child: GoogleMap(
          mapType: MapType.satellite,
          initialCameraPosition: const CameraPosition(
            target: LatLng(32.525297, -92.644747),
            zoom: 19.75,
            bearing: 4,
          ),
        ),
      ),
    );
  }
}
