import 'package:flutter/material.dart';
import 'LoginScreen.dart'; // Make sure to import the sign-up screen
import 'package:intl/intl.dart'; // For current year calculation

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SignUp> {
  bool _isPasswordVisible = false;
  bool _isConformPasswordVisible = false;

  // Controllers for TextFields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _universityMailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFFAA00FF),
                  Color(0xff281537),
                ])),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Create Your\nAccount',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Full Name TextField
                      TextField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.check,color: Colors.grey),
                          label: Text('Full Name', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242),
                          )),
                        ),
                      ),
                      // University Mail TextField
                      TextField(
                        controller: _universityMailController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text('University Mail', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242),
                          )),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      // Password TextField
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          label: const Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF424242),
                            ),
                          ),
                        ),
                      ),
                      // Confirm Password TextField
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConformPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConformPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConformPasswordVisible = !_isConformPasswordVisible;
                              });
                            },
                          ),
                          label: const Text(
                            'Confirm Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF424242),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 70),
                      Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                              colors: [Color(0xFFAA00FF), Color(0xff281537)]),
                        ),
                        child: GestureDetector(
                          onTap: _handleSignUp,
                          child: const Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => LoginScreen()));
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  // Function to handle Sign Up
  void _handleSignUp() {
    String fullName = _fullNameController.text;
    String email = _universityMailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Check if email is in the correct format
    if (email.contains('@')) {
      String rollNumber = email.split('@')[0]; // Extract roll number from email
      print('Roll Number: $rollNumber');

      // Extract the first 4 digits (joining year) and calculate the year of study
      String joiningYearStr = rollNumber.substring(0, 4);
      int joiningYear = int.parse(joiningYearStr);
      int currentYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
      int yearOfStudy = currentYear - joiningYear;
      print('Year of Study: $yearOfStudy');
    } else {
      print('Invalid email format');
    }

    // Add validation logic for other fields as needed
  }
}
