import 'package:flutter/material.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({super.key});

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
  bool isSignupScreen = false;
  get labelText => null;
  TextEditingController phonenumber = TextEditingController();
  @override
  void dispose() {
    phonenumber.dispose();
    super.dispose();
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
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          super.widget));
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
          buildBottomHalfContainerPositioned(true, phonenumber.text),
          //LOGIN CONTAINER
          AnimatedPositioned(
            duration: const Duration(microseconds: 700),
            curve: Curves.bounceInOut,
            top: isSignupScreen ? 250 : 250,
            child: AnimatedContainer(
              duration: const Duration(microseconds: 700),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 380 : 250,
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
                                "Mobile Number",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
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
          buildBottomHalfContainerPositioned(false, phonenumber.text),
          // Positioned(.
          //     top: MediaQuery.of(context).size.height - 220,
          //     left: 0,
          //     right: 0,
          //     child: Column(
          //       children: [
          //         Text(
          //           "Available On",
          //           style: TextStyle(fontFamily: "Cinzel"),
          //         ),
          //         Image.asset("images/stores.png")
          //       ],
          //     ))
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
          buildTextField(Icons.mobile_friendly, "Mobile Number", false, true,
              phonecontroler: phonenumber),
          Container(
            width: 270,
            margin: const EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                  text: "By pressing 'Submit' You agree to our\n",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                  ),
                  children: [
                    WidgetSpan(child: SizedBox(height: 30)),
                    TextSpan(
                      text: "Term & Conditions",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mobile_friendly, "Mobile Number", false, true,
              phonecontroler: phonenumber),
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
  Widget buildBottomHalfContainerPositioned(
      bool showShadow, String phonenumber) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 580 : 450,
      right: 0,
      left: 0,
      child: Center(
        // child: InkWell(
        //   onTap: () async {
        //     log(phonenumber);
        //     var response = await http.post(
        //         Uri.parse(
        // "https://preprod-lendx.neokredx.com/kyc-svc/api/v1/kyc/std/profilex/score-advance"),
        // headers: {
        // "secret-key": "pKd9czMKRjgRRzaSZFFqhuk9b2Kl",
        //  "access-key": "836JXGlYLyTksy0kOwBfjzHHHWhqTRWnUiXwTz",
        // "neokredx-client-id": "82cf6bee-2036-45ff-94c3-9e59bf9b27c4"
        // },
        // body: json.encode({
        //  "requestId": "jhjgfhhgcvvhvh",
        //  "mobileNo": "9867493007",
        // }));
        //log(response.body);
        // setState(() {
        //   // isSignupScreen = true;
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const MobileOtp()),
        //   );
        // });
        // },
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
      // )
    );
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail,
      {required TextEditingController phonecontroler}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: phonecontroler,
        maxLength: 10,
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
