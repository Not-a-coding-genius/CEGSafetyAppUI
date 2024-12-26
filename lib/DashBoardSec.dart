import 'package:flutter/material.dart';
import 'alertPage.dart';
import 'outPage.dart';

class DashBoardSec extends StatefulWidget {
  @override
  _DashBoardSecState createState() => _DashBoardSecState();
}

class _DashBoardSecState extends State<DashBoardSec> {
  String selectedHostel = 'All';
  String selectedStatus = 'All';

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
                      "Hi, someone",
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.location_on, color: Colors.white),
                Text(
                  "Some Location",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDropdown(
                  'Hostel',
                  selectedHostel,
                  ['All', 'Hostel A', 'Hostel B', 'Hostel C'],
                  (String? newValue) {
                    setState(() {
                      selectedHostel = newValue!;
                    });
                  },
                ),
                _buildDropdown(
                  'Status',
                  selectedStatus,
                  ['All', 'Active SOS', 'Out', 'Past Curfew'],
                  (String? newValue) {
                    setState(() {
                      selectedStatus = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildListItem('John Doe', 'Hostel A', 'Active SOS', Colors.red),
                _buildListItem('Jane Smith', 'Hostel B', 'Out', Colors.yellow),
                _buildListItem('Alice Johnson', 'Hostel C', 'Past Curfew', Colors.red),
                _buildListItem('Bob Brown', 'Hostel A', 'In Hostel', Colors.green),
                // Add more list items here
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildListItem(String name, String hostel, String status, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text('$hostel - $status'),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            status,
            style: TextStyle(color: Colors.black),
          ),
        ),
        onTap: () {
          if (status == 'Active SOS') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AlertPage()),
            );
          } else if (status == 'Out') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Outpage()),
            );
          }
        },
      ),
    );
  }
}