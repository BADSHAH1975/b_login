import 'package:b_sell/main.dart';
import 'package:b_sell/screens/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_autofill/sms_autofill.dart';

class MobileOtp extends StatefulWidget {
  final String otp;
  const MobileOtp({super.key, required this.otp});

  @override
  State<MobileOtp> createState() => _MobileOtpState();
}

class _MobileOtpState extends State<MobileOtp> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isSignupScreen = false;
  get labelText => null;
  String enteredOTP = '';

  @override
  void initState() {
    // startListeningForSMS();
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  void startListeningForSMS() async {
    try {
      await SmsAutoFill().listenForCode();
    } catch (error) {
      logger.e(error);
    }
  }

  Future<void> _saveUserData(User user) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        logger.i('User added in Firestore');
        await _firestore.collection('users').doc(user.uid).set({
          'phoneNumber': user.phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        logger.i('User already exists in Firestore');
        logger.i(userDoc);
      }
    } catch (e) {
      logger.e('Error saving user data: $e');
    }
  }

  void verifyOTP(String enteredOTP) {
    String verificationId = widget.otp;

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: enteredOTP,
    );

    FirebaseAuth.instance.signInWithCredential(credential).then((userCredential) {
      logger.d('OTP verified successfully');
      _saveUserData(userCredential.user!);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => Layout(),
        ),
        (route) => false,
      );
    }).catchError((error) {
      logger.d('Failed to verify OTP: $error');
      Fluttertoast.showToast(msg: error.msg, backgroundColor: Colors.red, textColor: Colors.white);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: Stack(
        children: [
          // LOGO CONTAINER

          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 350,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    "images/otp.png",
                  ),
                )),
                child: Container(
                  color: Colors.lightBlueAccent.withOpacity(0.05),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.indigo[300],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          buildBottomHalfContainerPositioned(true),
          //LOGIN CONTAINER
          AnimatedPositioned(
            duration: const Duration(microseconds: 700),
            curve: Curves.bounceInOut,
            top: 350,
            child: AnimatedContainer(
              duration: const Duration(microseconds: 700),
              curve: Curves.bounceInOut,
              height: 200,
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                BoxShadow(
                  color: Colors.indigoAccent.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Mobile Number OTP",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              height: 3,
                              width: 150,
                              color: Colors.indigo[300],
                            )
                          ],
                        ),
                      ],
                    ),
                    if (!isSignupScreen) buildSigninSection(),
                  ],
                ),
              ),
            ),
          ),
          //submit button
          buildBottomHalfContainerPositioned(false),
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mobile_friendly, "OTP", true, false),
        ],
      ),
    );
  }

  // SUBMIT BUTTON
  Widget buildBottomHalfContainerPositioned(bool showShadow) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 700),
        curve: Curves.bounceInOut,
        top: 500,
        right: 00,
        left: 0,
        child: Center(
          child: GestureDetector(
            onTap: () {
              verifyOTP(enteredOTP);
            },
            child: Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50), boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.indigoAccent.withOpacity(.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 1),
                  )
              ]),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.indigo[200]!, Colors.indigo[900]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(.6),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 1),
                      ),
                    ]),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildTextField(IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 300,
              child: Column(
                children: [
                  // PinFieldAutoFill(
                  //   decoration:
                  //   BoxLooseDecoration(
                  //     // shape: BoxShape.circle,
                  //     // color: Colors.indigo[100],
                  //     // border: Border.all(color: Colors.blue.withOpacity(0.5), width: 2,
                  //     strokeColorBuilder: PinListenColorBuilder(Colors.black, Colors.black26),
                  //     bgColorBuilder: const FixedColorBuilder(Colors.black),
                  //     strokeWidth: 2,

                  //   ),
                  //   autoFocus: true,
                  //   cursor: Cursor(color: Colors.red, enabled: true, width: 1),
                  //   currentCode: '',
                  //   onCodeSubmitted: (code) {
                  //     verifyOTP(code);
                  //   },
                  //   codeLength: 6,
                  //   onCodeChanged: (code) {
                  //     setState(() {
                  //       enteredOTP = code!;
                  //     });
                  //   },
                  // ),
                  Pinput(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
                    length: 6,
                    autofocus: isPassword,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      setState(() {
                        enteredOTP = value;
                      });
                    },
                    onSubmitted: (pin) {
                      verifyOTP(pin);
                    },
                    defaultPinTheme: PinTheme(
                        height: 40,
                        width: 40,
                        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.indigo[100],
                            border: Border.all(color: Colors.blue.withOpacity(0.5), width: 2))),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
