import 'package:flutter/material.dart';
import 'alertPage.dart';
import 'alertPageAdmin.dart';

class DashBoardAdmin extends StatefulWidget {
  @override
  _DashBoardAdminState createState() => _DashBoardAdminState();
}

class _DashBoardAdminState extends State<DashBoardAdmin> {
  String userName = "Admin"; // Replace with actual user name
  int totalSOSAlerts = 10; // Example data
  int activeSOSAlerts = 3; // Example data
  int resolvedSOSAlerts = 7; // Example data
  int studentsOutside = 5; // Example data
  int studentsPastCurfew = 2; // Example data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person, size: 24.0), // Profile icon
                  radius: 24.0,
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0), // Push the text a bit lower
                    Text(
                      "Hi, $userName",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle view profile tap
                      },
                      child: Text(
                        "View Profile",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Section
              Text(
                'Overview',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildMetricCard('Total SOS Alerts', totalSOSAlerts),
                    _buildMetricCard('Active SOS Alerts', activeSOSAlerts),
                    _buildMetricCard('Resolved SOS Alerts', resolvedSOSAlerts),
                    _buildMetricCard('Students Outside', studentsOutside),
                    _buildMetricCard('Students Past Curfew', studentsPastCurfew),
                  ],
                ),
              ),
              SizedBox(height: 32.0),

              // Active SOS Alerts Section
              Text(
                'Active SOS Alerts',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              _buildSOSAlertList(),
              SizedBox(height: 32.0),

              // Students Out Past Curfew or SOS Alerts Section
              Text(
                'Students Out Past Curfew or SOS Alerts',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              _buildCriticalStatusList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, int value) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.only(right: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              value.toString(),
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSAlertList() {
    // Example data
    List<Map<String, String>> sosAlerts = [
      {
        'name': 'John Doe',
        'id': '123456',
        'location': '37.7749, -122.4194',
        'timestamp': '2023-10-01 12:00:00',
        'status': 'Not Acknowledged'
      },
      {
        'name': 'Jane Smith',
        'id': '654321',
        'location': '37.7749, -122.4194',
        'timestamp': '2023-10-01 12:05:00',
        'status': 'Acknowledged'
      },
    ];

    return Column(
      children: sosAlerts.map((alert) {
        return Card(
          elevation: 4.0,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('${alert['name']} (${alert['id']})'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${alert['location']}'),
                Text('Timestamp: ${alert['timestamp']}'),
                Text('Status: ${alert['status']}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlertPageAdmin()),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCriticalStatusList() {
    // Example data
    List<Map<String, String>> criticalStatus = [
      {'name': 'Alice Johnson', 'status': 'Past Curfew', 'color': 'red'},
      {'name': 'Bob Brown', 'status': 'Active SOS', 'color': 'red'},
    ];

    return Column(
      children: criticalStatus.map((status) {
        return Card(
          elevation: 4.0,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(status['name']!),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: status['color'] == 'red' ? Colors.red : Colors.yellow,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                status['status']!,
                style: TextStyle(color: Colors.black),
              ),
            ),
            onTap: () {
              if (status['status'] == 'Active SOS') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlertPageAdmin()),
                );
              }
            },
          ),
        );
      }).toList(),
    );
  }
}