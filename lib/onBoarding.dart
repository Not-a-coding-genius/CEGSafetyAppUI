import 'package:flutter/material.dart';
import 'package:safetyapp/LoginScreen.dart';
import 'package:safetyapp/intro_screens/intro_page1.dart';
import 'package:safetyapp/intro_screens/intro_page2.dart';
import 'package:safetyapp/intro_screens/intro_page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>{

  PageController _controller = PageController();


  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                isLast = index == 2;
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: Alignment(0,0.75),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    _controller.jumpToPage(2);
                  },

                  child: Text('Skip')),
                SmoothPageIndicator(controller: _controller, count: 3),
                isLast? GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text('Done')):
                GestureDetector(
                  onTap: (){
                    _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  },
                  child: Text('Next'))
              ],
            ))
        ],
      )
    );
  }
}