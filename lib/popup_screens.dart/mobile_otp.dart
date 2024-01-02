import 'package:b_sell/screens/login_signup_screens/pan_number.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MobileOtp extends StatefulWidget {
  const MobileOtp({super.key});

  @override
  State<MobileOtp> createState() => _MobileOtpState();
}

class _MobileOtpState extends State<MobileOtp> {
  bool isSignupScreen = false;
  get labelText => null;

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
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
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
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PanNumber()),
                );
              });
            },
            child: Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
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

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            child: Pinput(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              length: 4,
              autofocus: isPassword,
              defaultPinTheme: PinTheme(
                  height: 65,
                  width: 65,
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w900),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.indigo[100],
                      border: Border.all(
                          color: Colors.blue.withOpacity(0.5), width: 2))),
            ),

            // child: TextFormField(
            //   onChanged: (value) {
            //     FocusScope.of(context).nextFocus();
            //   },
            //   style: Theme.of(context).textTheme.headlineLarge,
            //   keyboardType: TextInputType.number,
            //   textAlign: TextAlign.center,
            //   inputFormatters: [
            //     LengthLimitingTextInputFormatter(1),
            //     FilteringTextInputFormatter.digitsOnly,
            //   ],
            // ),
          ),
          // SizedBox(
          //   height: 50,
          //   width: 50,
          //   child: TextFormField(
          //     onChanged: (value) {
          //       FocusScope.of(context).nextFocus();
          //     },
          //     style: Theme.of(context).textTheme.headlineLarge,
          //     keyboardType: TextInputType.number,
          //     textAlign: TextAlign.center,
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(1),
          //       FilteringTextInputFormatter.digitsOnly,
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 50,
          //   width: 50,
          //   child: TextFormField(
          //     onChanged: (value) {
          //       FocusScope.of(context).nextFocus();
          //     },
          //     style: Theme.of(context).textTheme.headlineLarge,
          //     keyboardType: TextInputType.number,
          //     textAlign: TextAlign.center,
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(1),
          //       FilteringTextInputFormatter.digitsOnly,
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 50,
          //   width: 50,
          //   child: TextFormField(
          //     onChanged: (value) {
          //       FocusScope.of(context).nextFocus();
          //     },
          //     style: Theme.of(context).textTheme.headlineLarge,
          //     keyboardType: TextInputType.number,
          //     textAlign: TextAlign.center,
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(1),
          //       FilteringTextInputFormatter.digitsOnly,
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 50,
          //   width: 50,
          //   child: TextFormField(
          //     onChanged: (value) {
          //       FocusScope.of(context).nextFocus();
          //     },
          //     style: Theme.of(context).textTheme.headlineLarge,
          //     keyboardType: TextInputType.number,
          //     textAlign: TextAlign.center,
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(1),
          //       FilteringTextInputFormatter.digitsOnly,
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 50,
          //   width: 50,
          //   child: TextFormField(
          //     onChanged: (value) {
          //       FocusScope.of(context).nextFocus();
          //     },
          //     style: Theme.of(context).textTheme.headlineLarge,
          //     keyboardType: TextInputType.number,
          //     textAlign: TextAlign.center,
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(1),
          //       FilteringTextInputFormatter.digitsOnly,
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
