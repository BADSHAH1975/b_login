import 'package:b_sell/main.dart';
import 'package:b_sell/screens/login_signup_screens/mobile_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MobileNumber()),
        (route) => false,
      );
    } catch (e) {
      logger.e('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Logout'),
          onTap: () {
            _signOut(context);
          },
        ),
      ],
    );
  }
}
