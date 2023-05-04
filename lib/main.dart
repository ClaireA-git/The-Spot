import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Screens/CobParkingScreen.dart';
import 'Screens/NethkinParkingWidget.dart';
import 'Screens/StudentCenterParking.dart';
import 'Screens/WylyParking.dart';
import 'Screens/WestMiss_east.dart';
import 'Screens/WestMiss_west.dart';


void main() => runApp(TheSpotApp());

class TheSpotApp extends StatelessWidget {
  const TheSpotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Spot',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}

// Loading screen widget
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for three seconds before navigating to the main screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Text(
          'The Spot',
          style: TextStyle(
            color: Colors.red,
            fontSize: 80.0,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// Main screen widget
class MainScreen extends StatelessWidget {
  // Function to navigate to a new screen with the given name
  void _navigateToScreen(BuildContext context, String screenName) {
    switch (screenName) {
      case 'COB Parking':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CobParkingScreen()),
        );
        break;
      case 'Nethkin Parking':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NethkinParkingScreen()),
        );
        break;
      case 'Student Center Parking':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentCenterScreen()),
        );
        break;
      case 'Wyly Tower Parking':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WylyParkingScreen()),
        );
        break;
      case 'W Mississippi East Parking':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MississippiEScreen()),
        );
        break;
      case 'W Mississippi West Parking':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MississippiWScreen()),
        );
        break;
    // Add other cases for additional screens
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.inactiveGray,
      appBar: AppBar(
        title: Text('Parking Lots'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 80, // Set the height of the button
              child: ElevatedButton(
                onPressed: () {
                  _navigateToScreen(context, 'COB Parking');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                child: Text('COB Parking'),
              ),
            ),
          ),
          SizedBox(height: 16), // Add a gap between the buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 80, // Set the height of the button
              child: ElevatedButton(
                onPressed: () {
                  _navigateToScreen(context, 'Nethkin Parking');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                child: Text('Nethkin Parking'),
              ),
            ),
          ),
          SizedBox(height: 16), // Add a gap between the buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 80, // Set the height of the button
              child: ElevatedButton(
                onPressed: () {
                  _navigateToScreen(context, 'Student Center Parking');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                child: Text('Student Center Parking'),
              ),
            ),
          ),
          SizedBox(height: 16), // Add a gap between the buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 80, // Set the height of the button
              child: ElevatedButton(
                onPressed: () {
                  _navigateToScreen(context, 'Wyly Tower Parking');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                child: Text('Wyly Tower Parking'),
              ),
            ),
          ),
          SizedBox(height: 16), // Add a gap between the buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 80, // Set the height of the button
              child: ElevatedButton(
                onPressed: () {
                  _navigateToScreen(context, 'W Mississippi East Parking');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                child: Text('W Mississippi East Parking'),
              ),
            ),
          ),
          SizedBox(height: 16), // Add a gap between the buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 80, // Set the height of the button
              child: ElevatedButton(
                onPressed: () {
                  _navigateToScreen(context, 'W Mississippi West Parking');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                child: Text('W Mississippi West Parking'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//_navigateToScreen(context, 'Parking Lot 1');