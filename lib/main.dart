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
import 'package:b_sell/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
