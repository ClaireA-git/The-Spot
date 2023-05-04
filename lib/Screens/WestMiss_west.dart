import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MississippiWScreen extends StatelessWidget {
  const MississippiWScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.inactiveGray,
      appBar: AppBar(
        title: const Text('W Mississippi West Parking'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 2.8, // Set the height to half of the screen
        child: GoogleMap(
          mapType: MapType.satellite,
          initialCameraPosition: const CameraPosition(
            target: LatLng(32.52955, -92.64851),
            zoom: 18.95,
            bearing: 3,
          ),
        ),
      ),
    );
  }
}
