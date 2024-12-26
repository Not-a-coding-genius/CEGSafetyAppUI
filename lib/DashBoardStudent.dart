import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DashBoardStudent extends StatefulWidget {
  @override
  _DashBoardStudentState createState() => _DashBoardStudentState();
}

class _DashBoardStudentState extends State<DashBoardStudent> {
  int _selectedIndex = 0;
  bool _isAnimationPlaying = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleAnimation() {
    setState(() {
      _isAnimationPlaying = !_isAnimationPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change background color to a shade of white
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.black, size: 52.0), // Profile icon on the top left
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, somename",
                            style: TextStyle(
                              color: Colors.black,
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
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Text(
                  "Emergency SOS", // Change title to Emergency SOS
                  style: TextStyle(
                    color: Colors.black, // Change SOS text color to black
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _toggleAnimation,
                    child: Lottie.network(
                      'https://lottie.host/76bc963e-0276-43fd-885f-e77748fbbbb8/pM64nDhex4.json', // Lottie animation URL
                      width: 200.0, // Adjust the size as needed
                      height: 200.0,
                      repeat: _isAnimationPlaying,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0), // Add space above the cards
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      _buildCard('Police', Icons.local_police, Colors.blue),
                      _buildCard('Women Helpline', Icons.phone, Colors.pink),
                      _buildCard('Nearby Help', Icons.location_on, Colors.green),
                      _buildCard('Alert Friends', Icons.people, Colors.orange),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          // Handle card tap
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Icon(icon, size: 50.0, color: color),
                  SizedBox(width: 20.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 20.0, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}