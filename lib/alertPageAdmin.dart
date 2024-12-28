import 'package:flutter/material.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertPageAdmin extends StatefulWidget {
  const AlertPageAdmin({super.key});

  @override
  State<AlertPageAdmin> createState() => _AlertPageAdminState();
}

class _AlertPageAdminState extends State<AlertPageAdmin> {
  String studentName = "John Doe";
  String studentID = "123456";
  String currentLocation = "37.7749, -122.4194"; // Example location
  String timestamp = "2023-10-01 12:00:00"; // Example timestamp
  bool isAcknowledged = true; // Example case where the alert has been acknowledged
  String securityGuardName = "Jane Doe"; // Example data
  String securityGuardContact = "9876543210"; // Example data
  LatLng _studentPosition = LatLng(37.7749, -122.4194); // Initial position (San Francisco)
  final locationController = Location();

  @override
  void initState() {
    super.initState();
    updateLocation();
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

  void openInGoogleMaps() async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=${_studentPosition.latitude},${_studentPosition.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      SizedBox(height: 8.0),
                      Text(
                        'Status: ${isAcknowledged ? 'Acknowledged' : 'Not Acknowledged'}',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: isAcknowledged ? Colors.green : Colors.red),
                      ),
                      if (isAcknowledged) ...[
                        SizedBox(height: 8.0),
                        Text(
                          'Security Guard: $securityGuardName',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Contact: $securityGuardContact',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
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