import 'package:b_sell/popup_screens.dart/adhar_otp.dart';
import 'package:b_sell/screens/login_signup_screens/mobile_number.dart';
import 'package:flutter/material.dart';

class AdharNumber extends StatefulWidget {
  const AdharNumber({super.key});

  @override
  State<AdharNumber> createState() => _AdharNumberState();
}

class _AdharNumberState extends State<AdharNumber> {
  bool isSignupScreen = false;
  get labelText => null;

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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MobileNumber()),
                              );
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
            top: 250,
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
                                "Adhar Number",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        // !isSignupScreen
                                        //     ?
                                        Colors.black
                                    // : Colors.black12
                                    ),
                              ),
                              //if (!isSignupScreen)
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: 2,
                                width: 120,
                                color: Colors.indigo,
                              )
                            ],
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       isSignupScreen = true;
                        //     });
                        //   },
                        // child:
                        // Column(
                        //   children: [
                        //     Text(
                        //       "Pan Number",
                        //       style: TextStyle(
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.bold,
                        //           color: isSignupScreen
                        //               ? Colors.black
                        //               : Colors.black12),
                        //     ),
                        //     if (isSignupScreen)
                        //         Container(
                        //           margin: EdgeInsets.only(top: 3),
                        //           height: 2,
                        //           width: 100,
                        //           color: Colors.indigo,
                        //         )
                        //     ],
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       isSignupScreen = true;
                        //     });
                        //   },
                        // child: Column(
                        //   children: [
                        //     Text(
                        //       "Adhar Number",
                        //       style: TextStyle(
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.bold,
                        //           color: isSignupScreen
                        //               ? Colors.black
                        //               : Colors.black12),
                        //     ),
                        //     if (isSignupScreen)
                        //       Container(
                        //         margin: EdgeInsets.only(top: 3),
                        //         height: 2,
                        //         width: 100,
                        //         color: Colors.indigo,
                        //       )
                        //   ],
                        // ),
                        // ),
                      ],
                    ),
                    // if (isSignupScreen) buildSignupSection(),
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
          // buildTextField(Icons.manage_accounts, "NAME", false, true),
          buildTextField(Icons.credit_score, "Adhar Number", true, false),
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mobile_friendly, "Mobile Number", false, true),
          // buildTextField(Icons.manage_accounts, "Name", false, false),
          //buildTextField(Icons.credit_score, "Pan Number", true, false),
          // Container(
          //   width: 270,
          //   margin: EdgeInsets.only(top: 20),
          // )
        ],
      ),
    );
  }

  // SUBMIT BUTTON
  Widget buildBottomHalfContainerPositioned(bool showShadow) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 700),
        curve: Curves.bounceInOut,
        top: 400,
        right: 0,
        left: 0,
        child: Center(
          child: InkWell(
            onTap: () {
              setState(() {
                // isSignupScreen = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdharOtp()),
                );
              });
            },
            child: Container(
              height: 90,
              width: 90,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    if (showShadow)
                      BoxShadow(
                        color: Colors.blue.withOpacity(.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 1),
                      )
                  ]),
              child: Container(
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
        ));
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.orange,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(35.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(35.0)),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            labelText: labelText,
            hintStyle: TextStyle(fontSize: 19, color: Colors.grey[100])),
      ),
    );
  }
}
