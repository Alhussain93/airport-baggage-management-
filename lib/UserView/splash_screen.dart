import 'dart:async';
import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/UserView/tracking_screen.dart';

import '../constant/colors.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Initstate();
}

class Initstate extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
     startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, loginRoute);
  }

  loginRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TrackingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return initwidget();
  }

  Widget initwidget() {
    return Scaffold(
      backgroundColor: themecolor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/LOGO.png'))),
            ),
          ),
        ],
      ),
    );
  }
}
