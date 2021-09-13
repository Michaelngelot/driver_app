import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:driver_app/AllScreens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'mainscreen.dart';

class Splash extends StatefulWidget {
  static const String idScreen = "splash";
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {



  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(splash:
            Image(
              alignment: Alignment.center,
              image: AssetImage("images/desticon.png"),
            ),
        duration: 2000,splashTransition:SplashTransition.rotationTransition, nextScreen: MainScreen());
  }
}
