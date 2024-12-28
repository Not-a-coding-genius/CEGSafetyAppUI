import 'package:flutter/material.dart';

class OutPage extends StatefulWidget {
  const OutPage({super.key});

  @override
  State<OutPage> createState() => _OutPageState();
}

class _OutPageState extends State<OutPage> {
  bool isSafe = false;

  void markSafe() {
    setState(() {
      isSafe = true;
    });
    // Implement logic to notify the guard that the student is safe
    print('Student marked as safe');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Out Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You are out past curfew. Are you okay?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: markSafe,
                child: Text('Yes, I am okay'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  textStyle: TextStyle(fontSize: 16.0),
                ),
              ),
              if (isSafe)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'You have marked yourself as safe.',
                    style: TextStyle(fontSize: 16.0, color: Colors.green),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}