import 'dart:async';

import 'package:flutter/material.dart';
import 'package:global/src/option/choice.dart';




class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {

  double height = 0;
  double width = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    move();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: width,
            height: height,
            child: Image.asset(
              "assets/venice.jpg",
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void move() {

    Timer(Duration(seconds: 2), () async {

      Navigator.pushReplacement(context, MaterialPageRoute(

          builder: (context) => ChoiceScreen()));
//
    });
  }

}

