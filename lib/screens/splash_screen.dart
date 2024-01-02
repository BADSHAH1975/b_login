import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:b_sell/screens/login_signup_screens/mobile_number.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.black,
      splash: Image.asset(
        'images/blogo1.png',
        fit: BoxFit.cover,
      ),
      splashIconSize: 600,
      nextScreen: const MobileNumber(),
      splashTransition: SplashTransition.scaleTransition,
      duration: 200,
    );
  }
}
