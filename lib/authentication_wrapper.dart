import 'package:b_sell/screens/login_signup_screens/mobile_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/layout.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: Colors.yellow,
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          return Layout();
        } else {
          return MobileNumber();
        }
      },
    );
  }
}
