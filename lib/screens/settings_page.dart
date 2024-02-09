import 'package:b_sell/appcolors.dart';
import 'package:b_sell/main.dart';
import 'package:b_sell/screens/login_signup_screens/mobile_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    Future.delayed(Duration(milliseconds: 0), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void openGoogleMaps() async {
    const double latitude = 40.7128; // Replace with your latitude
    const double longitude = -74.0060; // Replace with your longitude
    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (!await launchUrl(Uri.parse(googleMapsUrl))) {
      throw Exception('Need Permission');
    } else {
      launchUrl(Uri.parse(googleMapsUrl));
    }
  }

  Future<void> _launchfb() async {
    if (!await launchUrl(Uri.parse('https://facebook.com'))) {
      throw Exception('Could not launch ${Uri.parse('https://facebook.com')}');
    } else {
      await launchUrl(Uri.parse('https://facebook.com'));
    }
  }

  Future<void> _launchCall() async {
    const phoneNumber = '+917777096028';
    final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(_phoneLaunchUri)) {
      throw Exception('Need Permission');
    } else {
      launchUrl(_phoneLaunchUri);
    }
  }

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
    // ignore: prefer_const_constructors
    return Container(
      // color: secondCont,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: white,
      ),
      child: AnimatedBuilder(
          animation: _animation,
          builder: (_, child) {
            return Opacity(
              opacity: _animation.value,
              child: ListView(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // ListTile(
                  //   title: Text('Logout'),
                  //   onTap: () {},
                  // ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: cont,
                    ),
                    title: Container(
                      // width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: secondCont.withOpacity(0.8),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: cont.withOpacity(0.3),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        color: Color(0xFFEFEEEE),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Logout'),
                      ),
                    ),
                    onTap: () {
                      _signOut(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.call,
                      color: cont,
                    ),
                    title: Container(
                      // width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: secondCont.withOpacity(0.8),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: cont.withOpacity(0.3),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        color: Color(0xFFEFEEEE),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Call Us!'),
                      ),
                    ),
                    onTap: () {
                      _launchCall();
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.storefront,
                      color: cont,
                    ),
                    title: Container(
                      // width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: secondCont.withOpacity(0.8),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: cont.withOpacity(0.3),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        color: Color(0xFFEFEEEE),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Our Address!'),
                      ),
                    ),
                    onTap: () {
                      openGoogleMaps();
                    },
                  ),
                  ListTile(
                    title: Container(
                      // width: 100,
                      height: 200,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: secondCont.withOpacity(0.8),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: cont.withOpacity(0.3),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        color: Color(0xFFEFEEEE),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(19.0760, 72.8777),
                          zoom: 9.2,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          RichAttributionWidget(
                            attributions: [
                              TextSourceAttribution(
                                'OpenStreetMap contributors',
                                onTap: () => openGoogleMaps(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text('Map'),
                      // ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.facebook,
                      color: cont,
                    ),
                    title: Container(
                      // width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: secondCont.withOpacity(0.8),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: cont.withOpacity(0.3),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        color: Color(0xFFEFEEEE),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Our Facebook!'),
                      ),
                    ),
                    onTap: () {
                      _launchfb();
                    },
                  ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Icon(Icons.facebook,),
                  //     Icon(Icons)
                  //   ],
                  // )
                ],
              ),
            );
          }),
    );
  }
}
