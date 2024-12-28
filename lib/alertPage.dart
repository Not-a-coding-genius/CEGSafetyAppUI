import 'package:flutter/material.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  String studentName = "John Doe";
  String studentID = "123456";
  String currentLocation = "Unknown";
  String timestamp = "Unknown";
  Timer? locationUpdateTimer;
  bool isAcknowledged = false;
  bool isSafe = false;
  int elapsedTime = 0;
  LatLng _studentPosition = LatLng(37.7749, -122.4194); // Initial position (San Francisco)
  final locationController = Location();

  @override
  void initState() {
    super.initState();
    startLocationUpdates();
  }

  void startLocationUpdates() {
    locationUpdateTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      if (isAcknowledged || isSafe || elapsedTime >= 1800) {
        timer.cancel();
      } else {
        updateLocation();
        elapsedTime += 30;
      }
    });
  }

  void updateLocation() {
    setState(() {
      // Replace with actual location fetching logic
      _studentPosition = LatLng(
        _studentPosition.latitude + 0.001,
        _studentPosition.longitude + 0.001,
      );
      currentLocation = "${_studentPosition.latitude}, ${_studentPosition.longitude}";
      timestamp = DateTime.now().toString();
    });
  }

  void acknowledgeReceipt() {
    setState(() {
      isAcknowledged = true;
      locationUpdateTimer?.cancel();
    });
  }

  void markSafe() {
    setState(() {
      isSafe = true;
      locationUpdateTimer?.cancel();
    });
    print('Student marked as safe');
  }

  void openInGoogleMaps() async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=${_studentPosition.latitude},${_studentPosition.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    locationUpdateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Student Name: $studentName',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Student ID: $studentID',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Current Location: $currentLocation',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Timestamp: $timestamp',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: openInGoogleMaps,
                  child: Text('Open in Google Maps'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    textStyle: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (isAcknowledged) {
                      markSafe();
                    } else {
                      acknowledgeReceipt();
                    }
                  },
                  child: Text(isAcknowledged ? 'Safe' : 'Acknowledge Receipt'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Transparent button color
                    foregroundColor: Colors.black, // Text color
                    side: BorderSide(color: Colors.black, width: 2.0), // Border color and width
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    textStyle: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);
}