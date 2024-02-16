import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:b_sell/authentication_wrapper.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.black,
      splash: Image.asset(
        'images/logo.png',
        fit: BoxFit.cover,
      ),
      splashIconSize: 150,
      nextScreen: AuthenticationWrapper(),
      splashTransition: SplashTransition.scaleTransition,
      duration: 400,
    );
  }
}
