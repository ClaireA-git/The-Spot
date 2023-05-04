import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class StudentCenterScreen extends StatelessWidget {
  const StudentCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.inactiveGray,
      appBar: AppBar(
        title: const Text('Student Center Parking'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 2.8, // Set the height to half of the screen
        child: GoogleMap(
          mapType: MapType.satellite,
          initialCameraPosition: const CameraPosition(
            target: LatLng(32.52638, -92.64960),
            zoom: 19.6,
            bearing: 108,
          ),
        ),
      ),
    );
  }
}
