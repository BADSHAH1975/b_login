import 'package:b_sell/appcolors.dart';
import 'package:b_sell/main.dart';
import 'package:b_sell/screens/login_signup_screens/mobile_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
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

  List<Map<String, dynamic>> stores = [
    {
      'name':
          'Taqwa Luxury Jewellers, Opp. Nihal Corner Restaurant, Naya Nagar, Mira Road East, Mira Bhayander, Maharashtra 401107.',
      'latitude': 19.285174284424624,
      'longitude': 72.85750471272502,
      'phone': '8291509944',
    },
    {
      'name':
          'Shop No. 08, Zarina Society, Next to Lucky Restaurant opp Jama masjid, Swami Vivekananda Rd, Bandra West, W, Maharashtra',
      'latitude': 19.2412303371224,
      'longitude': 72.85872071354214,
      'phone': '8291689944',
    },
    //
    {
      'name':
          '3/524, Abdul Hamid Marg, near Police Station, Malad, BMC Colony, Malvani, Malad W, Mumbai, Maharashtra 400095',
      'latitude': 19.19395520102507,
      'longitude': 72.82188095261048,
      'phone': '7045629944',
    },

    {
      'name': 'Shop No 5/6 Harchu sigh bahar chs, Behram Baug, Jogeshwari West, Mumbai, Maharashtra 400102',
      'latitude': 19.144250518376627,
      'longitude': 72.84160571271903,
      'phone': '97690 59944',
    },

    {
      'name': 'Swami Vivekananda Rd, Madam Wadi, Santosh Nagar, Bandra West, Mumbai, Maharashtra 400051',
      'latitude': 19.052952521716872,
      'longitude': 72.83803026609823,
      'phone': '82916 89944',
    },

    {
      'name': 'Bismillah residency, Sir Jamshedji Jeejeebhoy Rd, Mumbai, 400008',
      'latitude': 18.956700383876978,
      'longitude': 72.83093817211774,
      'phone': '7039159944',
    },

    {
      'name': 'Shop no 9, Mulla Towers, 2nd, Rabodi, Thane West, Thane, Maharashtra 400601',
      'latitude': 19.205140442086307,
      'longitude': 72.983313300041,
      'phone': '8854949944',
    },

    {
      'name': 'Shop No:19/20 Dost Apt, next to Axis Bank Branch, Kausa, Mumbra, Thane, Maharashtra 400612',
      'latitude': 19.169634240208627,
      'longitude': 73.02514370005068,
      'phone': '9833019944',
    },
    {
      'name':
          'Shop no 01/02 Noor Apartment, Mahatma Gandhi Rd, near Suffa masjid, Kacchi Mohalla, Panvel, Mumbai, Maharashtra 410218',
      'latitude': 18.988309102943454,
      'longitude': 73.10575348655921,
      'phone': '70391 39944',
    },
    {
      'name':
          'Shop No1&2 Abdullah sagari Mansion, Mominpura Road, opp. Makkah Masjid, Ganj Peth, Pune, Maharashtra 411042',
      'phone': '81494 29944',
      'latitude': 18.50643436933563,
      'longitude': 73.86255734012946,
    },
    {
      'name':
          'Shop no,112, Konark Shopping Mall, 113, Kondhwa Main Rd, Kausar Baugh, Kondhwa, Pune, Maharashtra 411048',
      'phone': '70391 09944',
      'latitude': 18.47265327007449,
      'longitude': 73.88907902298355,
    }
  ];

  List<Marker> markers = [
    Marker(
      point: LatLng(18.47265327007449, 73.88907902298355),
      builder: (ctx) => Container(
        child: Icon(
          Icons.pin_drop,
          color: Colors.red,
        ),
      ),
    ),
    Marker(
      point: LatLng(
        18.50643436933563,
        73.86255734012946,
      ),
      builder: (ctx) => Container(
        child: Icon(
          Icons.pin_drop,
          color: Colors.red,
        ),
      ),
    ),
    Marker(
      point: LatLng(18.988309102943454, 73.10575348655921),
      builder: (ctx) => Container(
        child: Icon(
          Icons.pin_drop,
          color: Colors.red,
        ),
      ),
    ),
    Marker(
      point: LatLng(19.169634240208627, 73.02514370005068),
      builder: (ctx) => Container(
        child: Icon(
          Icons.pin_drop,
          color: Colors.red,
        ),
      ),
    ),
    Marker(
      point: LatLng(19.205140442086307, 72.983313300041),
      builder: (ctx) => Container(
        child: Icon(
          Icons.pin_drop,
          color: Colors.red,
        ),
      ),
    ),
    Marker(
      point: LatLng(18.956700383876978, 72.83093817211774),
      builder: (ctx) => const Icon(
        Icons.pin_drop,
        color: Colors.red,
      ),
    ),
    Marker(
      point: LatLng(19.052952521716872, 72.83803026609823),
      builder: (ctx) => const Icon(
        Icons.pin_drop,
        color: Colors.red,
      ),
    ),
    Marker(
      point: LatLng(19.144250518376627, 72.84160571271903),
      builder: (ctx) => const Icon(
        Icons.pin_drop,
        color: Colors.red,
      ),
    ),
    Marker(
      point: LatLng(19.19395520102507, 72.82188095261048),
      builder: (ctx) => const Icon(
        Icons.pin_drop,
        color: Colors.red,
      ),
    ),
    Marker(
      point: LatLng(
        19.2412303371224,
        72.85872071354214,
      ),
      builder: (ctx) => const Icon(
        Icons.pin_drop,
        color: Colors.red,
      ),
    ),
    Marker(
      point: LatLng(
        19.285174284424624,
        72.85750471272502,
      ),
      builder: (ctx) => const Icon(
        Icons.pin_drop,
        color: Colors.red,
      ),
    ),
  ];

  String nearestStoreName = '';
  String nearestStorePhone = '';
  double nearestLat = 0.0;
  double nearestLong = 0.0;

  Future<void> _findNearestStore() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double userLatitude = position.latitude;
    double userLongitude = position.longitude;

    double minDistance = double.infinity;
    String nearestName = '';
    String nearestPhone = '';
    double nearestLatitude = 0.0;
    double nearestLongitude = 0.0;

    for (var store in stores) {
      double storeLatitude = store['latitude'];
      double storeLongitude = store['longitude'];
      double distance = Geolocator.distanceBetween(userLatitude, userLongitude, storeLatitude, storeLongitude);

      if (distance < minDistance) {
        minDistance = distance;
        nearestName = store['name'];
        nearestPhone = store['phone'];
        nearestLatitude = store['latitude'];
        nearestLongitude = store['longitude'];
      }
    }

    setState(() {
      nearestStoreName = nearestName;
      nearestStorePhone = nearestPhone;
      nearestLat = nearestLatitude;
      nearestLong = nearestLongitude;
    });
  }

  // Future<double> calculateDistanceBetweenAddresses(String address1, String address2) async {
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //   double latitude = position.latitude;
  //   double longitude = position.longitude;

  //   // final placemarks1 = await placemarkFromCoordinates(
  //   //   Geolocator.latitude,
  //   //   Geolocator.longitude, // Use device location or coordinates
  //   // );

  //   // Position storeLocation = await Geolocator
  //   final placemarks2 = await placemarkFromCoordinates(
  //     // Address 2's latitude and longitude
  //     address2.latitude,
  //     address2.longitude, // Assume valid coordinates or Geocoding
  //   );

  //   // Check if coordinates exist
  //   if (placemarks1.isEmpty ||
  //       placemarks2.isEmpty ||
  //       placemarks1[0].position == null ||
  //       placemarks2[0].position == null) {
  //     return -1.0; // Indicate error or missing data
  //   }

  //   // Calculate distance using LatLng objects
  //   return Geolocator.distanceBetween(
  //     placemarks1[0].position!.latitude,
  //     placemarks1[0].position!.longitude,
  //     placemarks2[0].position!.latitude,
  //     placemarks2[0].position!.longitude,
  //   );
  // }

  // Future<void> _findNearestStore() async {
  //   // Request location permissions (use permission_handler if necessary)
  //   // ...

  //   // Get the device's current location
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );

  //   // Convert coordinates to a human-readable address (optional)
  //   List<Placemark> placemarks = await placemarkFromCoordinates(
  //     position.latitude,
  //     position.longitude,
  //   );
  //   String userAddress = placemarks?.isNotEmpty == true
  //       ? placemarks[0].street! + ', ' + placemarks[0].locality! + ', ' + placemarks[0].country!
  //       : 'Could not retrieve user address';

  //   // Calculate distances and identify nearest store
  //   double minDistance = double.infinity;
  //   String nearestName = '';
  //   String nearestPhone = '';

  //   for (var store in stores) {
  //     try {
  //       // Ensure store address exists
  //       if (store['address'] == null) {
  //         continue; // Skip stores without an address
  //       }

  //       // Calculate distance between user and store
  //       double distance = await Geolocator.distanceBetweenAddresses(
  //         userAddress,
  //         store['address'],
  //       );

  //       // Update nearest store if closer
  //       if (distance < minDistance) {
  //         minDistance = distance;
  //         nearestName = store['name'];
  //         nearestPhone = store['phone'];
  //       }
  //     } catch (error) {
  //       print('Error calculating distance for store ${store['name']}: $error');
  //       // Optionally handle exceptions like invalid addresses or network issues
  //     }
  //   }

  //   // Handle cases where no valid store is found
  //   if (nearestName.isEmpty) {
  //     print('No valid stores found near your location.');
  //     return; // Indicate to the user that no stores were found
  //   }

  //   // Display results (modify to suit your UI implementation)
  //   print('Nearest store: $nearestName at $nearestAddress (distance: $minDistance meters)');
  //   // Optionally show location on a map, navigate to the store, etc.
  // }

  @override
  void initState() {
    super.initState();
    _findNearestStore();

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

  void openGoogleMaps(double lat, double long) async {
    // const double latitude = 40.7128; // Replace with your latitude
    // const double longitude = -74.0060; // Replace with your longitude
    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';

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

  Future<void> _launchCall(String number) async {
    // const phoneNumber = '+917777096028';
    final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: '+91$number');
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
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  // ListTile(
                  //   title: Text('Logout'),
                  //   onTap: () {},
                  // ),

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
                        child: Text(nearestStorePhone),
                      ),
                    ),
                    onTap: () {
                      _launchCall(nearestStorePhone);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.storefront,
                      color: cont,
                    ),
                    title: Container(
                      // width: 100,
                      height: 120,
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
                        child: Text(nearestStoreName),
                      ),
                    ),
                    onTap: () {
                      openGoogleMaps(nearestLat, nearestLong);
                    },
                  ),
                  ListTile(
                    title: Container(
                      // width: 100,
                      height: 300,
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
                          //                         'latitude': 18.988309102943454,
                          // 'longitude': 73.10575348655921,
                          center: LatLng(18.9883091029435, 73.10575348655921),
                          zoom: 8,
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
                                // onTap: () => openGoogleMaps(),
                              ),
                            ],
                          ),
                          MarkerLayer(
                            markers: markers,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 24),
                    child: GestureDetector(
                      onTap: () {
                        _signOut(context);
                      },
                      child: Container(
                        height: 50,
                        // width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            'LOGOUT',
                            style: GoogleFonts.poppins(
                              // fontStyle: FontStyle.,
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(12.0),
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     child: Center(
                  //       child: Text('Logout'),
                  //     ),
                  //     style: ButtonStyle(
                  //       fixedSize: MaterialStateProperty.all<Size>(
                  //         Size(200, 50), // Width and height of the button
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.logout,
                  //     color: cont,
                  //   ),
                  //   title: Container(
                  //     // width: 100,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: secondCont.withOpacity(0.8),
                  //           offset: Offset(-6.0, -6.0),
                  //           blurRadius: 20.0,
                  //         ),
                  //         BoxShadow(
                  //           color: cont.withOpacity(0.3),
                  //           offset: Offset(6.0, 6.0),
                  //           blurRadius: 20.0,
                  //         ),
                  //       ],
                  //       color: Color(0xFFEFEEEE),
                  //       borderRadius: BorderRadius.circular(12.0),
                  //     ),
                  //     padding: EdgeInsets.symmetric(horizontal: 15),
                  //     child: Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Text('Logout'),
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     _signOut(context);
                  //   },
                  // ),
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
