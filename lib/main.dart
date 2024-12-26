import 'package:flutter/material.dart';
import 'onBoarding.dart';
import 'DashBoardStudent.dart';
import 'DashBoardSec.dart';
import 'alertPage.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  DashBoardSec(),
    );
  }
}