import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:math' as Math;
import 'DashBoardStudent.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final Location location = Location();
  bool isInHostel = false; // Example initial status
  String statusMessage = "";
  String timestamp = "";
  String currentLocation = "";

  // Example hostel geofence coordinates
  final double hostelLatitude = 37.7749;
  final double hostelLongitude = -122.4194;
  final double geofenceRadius = 0.01; // 10 meters

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check In/Check Out System'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoardStudent()),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _checkInOut(context, true),
                child: Text('Check In'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  textStyle: TextStyle(fontSize: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _checkInOut(context, false),
                child: Text('Check Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  textStyle: TextStyle(fontSize: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              if (statusMessage.isNotEmpty)
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          statusMessage,
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        if (timestamp.isNotEmpty)
                          Text(
                            'Timestamp: $timestamp',
                            style: TextStyle(fontSize: 16.0, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        if (currentLocation.isNotEmpty)
                          Text(
                            'Location: $currentLocation',
                            style: TextStyle(fontSize: 16.0, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkInOut(BuildContext context, bool isCheckIn) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if GPS is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        _showMessage(context, "Please enable your location temporarily to verify your position.");
        return;
      }
    }

    // Check for location permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _showMessage(context, "Location permission is required to verify your position.");
        return;
      }
    }

    // Fetch current location
    LocationData locationData = await location.getLocation();
    double latitude = locationData.latitude!;
    double longitude = locationData.longitude!;

    // Verify if the student is near the hostel geofence
    if (_isWithinGeofence(latitude, longitude)) {
      setState(() {
        isInHostel = isCheckIn;
        statusMessage = isCheckIn ? "Checked In Successfully" : "Checked Out Successfully";
        timestamp = DateTime.now().toString();
        currentLocation = "$latitude, $longitude";
      });
      // Log the action (update status, timestamp, and location)
      // Implement your logging logic here
    } else {
      _showMessage(context, "You must be near the hostel to check in/out.");
    }
  }

  bool _isWithinGeofence(double latitude, double longitude) {
    double distance = _calculateDistance(latitude, longitude, hostelLatitude, hostelLongitude);
    return distance <= geofenceRadius;
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double p = 0.017453292519943295; // Pi/180
    double c(double x) => Math.cos(x);
    double a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * Math.asin(Math.sqrt(a)); // 2 * R; R = 6371 km
  }

  void _showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}