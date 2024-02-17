// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: (() {
//     // if (kIsWeb) {
//     //   return const FirebaseOptions(
//     //       apiKey: "AIzaSyDDzWGiK-50tNrwp6b6OsaemXVnYkBeUbw",
//     //       appId: "1:454455685899:web:c25e22222a4e8fab38a80e",
//     //       messagingSenderId: "454455685899",
//     //       projectId: "bpay-3ccdd");
//     // }
//     if (Platform.isIOS) {
//       return const FirebaseOptions(
//         iosClientId:
//             "240044315702-1dkoqchlc85ago4ncqmd7hfc8uqublfa.apps.googleusercontent.com",
//         apiKey: "AIzaSyBhqvEBZ4aB9FNOPJO78i5AWSdwcIpEc-0",
//         appId: "1:240044315702:ios:8abc6c369404b487a53497",
//         iosBundleId:
//             "com.googleusercontent.apps.240044315702-1dkoqchlc85ago4ncqmd7hfc8uqublfa",
//         messagingSenderId: "240044315702",
//         projectId: "com.badshah.bsell",
//       );
//     }
//     if (Platform.isAndroid) {
//       return const FirebaseOptions(
//         apiKey: "AIzaSyAPl2ueZ09sF5YpXhg8oDxTKw8MhJPNpvI",
//         appId: "1:240044315702:android:a36663e03ccb5de0a53497",
//         messagingSenderId: "240044315702",
//         projectId: "bsell-6a6c3",
//       );
//     }
//   }()));

//   //runApp(const MyApp());
// }

// // class MyApp extends StatefulWidget {
// //   static const String title = "BSell";
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }

// // class _MyAppState extends State<MyApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiProvider(
// //       providers: [
// //         ChangeNotifierProvider(create: (_) => UserProvider()),
// //       ],
// //       child: const MaterialApp(
// //         title: "B_Sell",
// //         debugShowCheckedModeBanner: false,
// //         home: SplashScreen(),
// //       ),
// //     );
// //   }
// // }

//---------------------------------------------------------------------------
import 'package:b_sell/appcolors.dart';
import 'package:b_sell/firebase_options.dart';
import 'package:b_sell/screens/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.settings = const Settings(persistenceEnabled: true);
  // await hasLocationPermission();
  if (await hasLocationPermission()) {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(),
      ),
    );
  } else {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    // Fluttertoast.showToast(msg: 'Provide location permission');
  }
}

Future<bool> hasLocationPermission() async {
  var status = await Permission.location.status;
  if (status.isGranted) {
    return true;
  } else if (status.isPermanentlyDenied) {
    await openAppSettings();
    Fluttertoast.showToast(msg: 'Provide location permission');

    return false;
  } else {
    final result = await Permission.location.request();
    if (result.isGranted) {
      return true;
    } else {
      Fluttertoast.showToast(msg: 'Provide location permission');
      return false;
    }
// await Permission.location.request();
    // return await hasLocationPermission(); // Retry
    // return SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    // return false;
  }
}

// Future<bool> hasLocationPermission() async {
//   var status = await Permission.location.status;
//   if (status.isGranted) {
//     return true;
//   } else if (status.isPermanentlyDenied) {
//     // User has permanently denied location permission
//     await openAppSettings(); // Open app settings for user action
//     return false;
//   } else {
//     // Request permission or explain why it's needed
//     final result = await Permission.location.request();
//     if (result.isGranted) {
//       return true;
//     } else {
//       // Provide clear rationale and options
//       showDialog(
//         // context: navigatorKey.currentContext!, // Use your navigator key
//         context: ,
//         builder: (context) => AlertDialog(
//           title: Text('Location Permission Required'),
//           content: Text('This app needs location permission to access features like nearby stores. If you deny, you can still use the app, but some features may be unavailable.'),
//           actions: [
//             TextButton(
//               onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
//               child: Text('Continue without location'),
//             ),
//             TextButton(
//               onPressed: () => openAppSettings(),
//               child: Text('Go to app settings'),
//             ),
//           ],
//         ),
//       );
//       return false; // Keep app open for now
//     }
//   }
// }

final Logger logger = Logger(
  printer: PrettyPrinter(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                // primarySwatch: Colors.blue,
                )
            .copyWith(
          background: white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
