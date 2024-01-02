import 'package:b_sell/screens/home_page.dart';
import 'package:b_sell/screens/login_signup_screens/mobile_number.dart';
import 'package:flutter/material.dart';

class ManiPage extends StatefulWidget {
  const ManiPage({super.key});

  @override
  State<ManiPage> createState() => _ManiPageState();
}

class _ManiPageState extends State<ManiPage> {
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
                                      builder: (context) =>
                                          const MobileNumber()));
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
            top: 290,
            child: AnimatedContainer(
              duration: const Duration(microseconds: 700),
              curve: Curves.bounceInOut,
              height: 390,
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
                        Column(
                          children: [
                            const Text(
                              "Details",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "Cinzel"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              height: 2,
                              width: 90,
                              color: Colors.indigo,
                            )
                          ],
                        ),
                      ],
                    ),
                    //if (isSignupScreen)
                    buildSignupSection(),
                    // if (!isSignupScreen) buildSigninSection(),
                  ],
                ),
              ),
            ),
          ),
          //submit button
          buildBottomHalfContainerPositioned(false),
          Positioned(
              top: MediaQuery.of(context).size.height - 120,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const Text(
                    "Available On",
                    style: TextStyle(fontFamily: "Cinzel"),
                  ),
                  Image.asset("images/stores.png")
                ],
              ))
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.manage_accounts, "NAME", false, true),
          buildTextField(Icons.mobile_friendly, "MOBILE NUMBER", false, false),
          buildTextField(Icons.credit_card, "PAN NUMBER", true, false),
          buildTextField(Icons.credit_score, "ADHAR NUMBER", true, false),
          buildTextField(Icons.account_balance, "ACCOUNT NUMBER", true, false),
          Container(
            width: 270,
            margin: const EdgeInsets.only(top: 20),
          )
        ],
      ),
    );
  }

  // SUBMIT BUTTON
  Widget buildBottomHalfContainerPositioned(bool showShadow) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 700),
        curve: Curves.bounceInOut,
        top: 420,
        right: 0,
        left: 0,
        bottom: 00,
        child: Center(
          child: InkWell(
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
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
                  Icons.check,
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
