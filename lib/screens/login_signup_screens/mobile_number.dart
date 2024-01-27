import 'package:b_sell/main.dart';
import 'package:b_sell/screens/popup_screens.dart/mobile_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({super.key});

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  bool isSignupScreen = false;
  get labelText => null;
  TextEditingController phonenumber = TextEditingController();
  String _verificationId = '';
  String _inputValue = '';

  @override
  void dispose() {
    phonenumber.dispose();
    super.dispose();
  }

  Future<void> verifyPhoneNumber(String phnumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$phnumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        _auth.signInWithCredential(credential);
        // UserCredential result = await _auth.signInWithCredential(credential);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => const Layout(),
        //   ),
        //   (route) => false,
        // );
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          logger.d('The provided phone number is not valid.');
          setState(() {
            loading = false;
          });
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        if (mounted) {
          setState(() {
            _verificationId = verificationId;
          });
        }
        Navigator.push(context, MaterialPageRoute(builder: (_) => MobileOtp(otp: _verificationId)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (mounted) {
          setState(() {
            _verificationId = verificationId;
          });
          setState(() {
            loading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[50],
      body: Stack(
        children: [
          // LOGO CONTAINER
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  "images/blogo2.gif",
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
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (BuildContext context) => super.widget));
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
            ),
          ),
          buildBottomHalfContainerPositioned(true, phonenumber.text),
          //LOGIN CONTAINER
          AnimatedPositioned(
            duration: const Duration(microseconds: 700),
            curve: Curves.bounceInOut,
            top: isSignupScreen ? 250 : 250,
            child: AnimatedContainer(
              duration: const Duration(microseconds: 700),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 380 : 170,
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              const Text(
                                "Mobile Number",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: 2,
                                width: 100,
                                color: Colors.indigo,
                              )
                            ],
                          ),
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
          buildBottomHalfContainerPositioned(false, phonenumber.text),
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mobile_friendly, "Mobile Number", false, true, phonecontroler: phonenumber),
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mobile_friendly, "Mobile Number", false, true, phonecontroler: phonenumber),
        ],
      ),
    );
  }

  // SUBMIT BUTTON
  Widget buildBottomHalfContainerPositioned(bool showShadow, String phonenumber) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 580 : 370,
      right: 0,
      left: 0,
      child: Center(
        child: InkWell(
          onTap: () {
            if (_inputValue == '' || _inputValue.length != 10) {
              Fluttertoast.showToast(msg: "Enter a valid number");
            } else {
              verifyPhoneNumber(_inputValue);
              setState(() {
                loading = true;
              });
              // Navigator.push(context, MaterialPageRoute(builder: (_) => MobileOtp(otp: _verificationId)));
            }
          },
          child: Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50), boxShadow: [
              if (showShadow)
                BoxShadow(
                  color: Colors.blue.withOpacity(.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                )
            ]),
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.yellow,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orange[200]!, Colors.orange[900]!],
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
      ),
      // )
    );
  }

  Widget buildTextField(IconData icon, String hintText, bool isPassword, bool isEmail,
      {required TextEditingController phonecontroler}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: phonecontroler,
        maxLength: 10,
        obscureText: isPassword,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a number';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            _inputValue = value; // Update the string variable
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.orange,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black12), borderRadius: BorderRadius.circular(35.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black), borderRadius: BorderRadius.circular(35.0)),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            labelText: labelText,
            hintStyle: TextStyle(fontSize: 19, color: Colors.grey[100])),
      ),
    );
  }
}
