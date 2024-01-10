import 'package:b_sell/appcolors.dart';
import 'package:b_sell/screens/product/all_products.dart';
import 'package:b_sell/screens/product/product_page.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool search = false;

  int _currentPage = 0;

  // final _offset = Offset(6, 6);
  // double blur = 20.0;

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SingleChildScrollView(
      child: Container(
        color: secondCont,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              // padding: EdgeInsets.fromLTRB(, top, right, bottom),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.0),
                ),
                color: cont,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      height: 50,
                      // width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            offset: Offset(2.0, -2.0),
                            blurRadius: 5,
                            inset: true,
                          ),
                          BoxShadow(
                            color: Color(0xff151515),
                            offset: Offset(-2.0, 2.0),
                            blurRadius: 5,
                            inset: true,
                          ),
                        ],
                        color: cont,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _searchController,
                        style: TextStyle(
                          color: secondCont,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Search..',
                          hintStyle: TextStyle(
                            color: secondCont.withOpacity(0.7),
                          ),
                          // suffixIconConstraints: BoxConstraints(),
                          // contentPadding: EdgeInsets.all(),
                          suffixIcon: Icon(
                            Icons.search,
                            color: secondCont.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 30),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: 270,
                      decoration: BoxDecoration(
                        color: cont.withOpacity(0.8),
                        border: Border(
                          right: BorderSide(
                            width: 2.0,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          top: BorderSide(
                            width: 2.0,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: secondCont.withOpacity(0.5),
                            // offset: Offset(-28, -28),
                            offset: Offset(3.0, -3.0),
                            blurRadius: 10.0,
                          ),
                          BoxShadow(
                            color: cont.withOpacity(0.3),
                            // offset: Offset(28.0, 28.0),
                            offset: Offset(-6.0, 6.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120.0),
                ),
                color: cont,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(110.0),
                  ),
                  color: secondCont,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _productTypes(Icon(Icons.diamond)),
                        _productTypes(Icon(Icons.trending_up)),
                        _productTypes(Icon(Icons.access_time))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _productTypes(Icon(Icons.diamond)),
                        _productTypes(Icon(Icons.trending_up)),
                        _productTypes(Icon(Icons.access_time))
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
                // child: SizedBox(
                //   width: double.infinity,
                //   height: MediaQuery.of(context).size.height * 0.5,
                //   child: GridView.count(
                //     clipBehavior: Clip.antiAlias,
                //     // physics: NeverScrollableScrollPhysics(),
                //     // padding: EdgeInsets.zero,
                //     crossAxisCount: 3,
                //     mainAxisSpacing: 10,
                //     crossAxisSpacing: 10,
                //     childAspectRatio: 0.9,
                //     children: [
                //       _productTypes('images/diamondring.png', 'Rings'),
                //       _productTypes('images/placeholder.png', 'Rings'),
                //       _productTypes('images/placeholder.png', 'Rings'),
                //       _productTypes('images/placeholder.png', 'Rings'),
                //       _productTypes('images/placeholder.png', 'Rings'),
                //       _productTypes('images/placeholder.png', 'Rings'),
                //     ],
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
    //   Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //     child: Column(
    //       children: [
    //         // CustomPaint(
    //         //   painter: CurvedLinePainter(),
    //         //   size: Size(MediaQuery.of(context).size.width, 300),
    //         // ),
    //         SizedBox(
    //           height: MediaQuery.of(context).size.height * 0.25,
    //           width: double.infinity,
    //           child: PageView.builder(
    //               itemCount: 3,
    //               onPageChanged: (index) {
    //                 setState(() {
    //                   _currentPage = index;
    //                 });
    //               },
    //               itemBuilder: (context, index) {
    //                 return Image.asset(
    //                   'images/placeholder.png',
    //                   color: Colors.amber,
    //                 );
    //               }),
    //         ),
    //         _buildPageIndicator(),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         SizedBox(
    //           width: double.infinity,
    //           height: MediaQuery.of(context).size.height * 0.4,
    //           child: GridView.count(
    //             physics: NeverScrollableScrollPhysics(),
    //             padding: EdgeInsets.zero,
    //             crossAxisCount: 3,
    //             mainAxisSpacing: 0,
    //             crossAxisSpacing: 3,
    //             childAspectRatio: 0.9,
    //             children: [
    //               _productTypes('images/diamondring.png', 'Rings'),
    //               _productTypes('images/placeholder.png', 'Rings'),
    //               _productTypes('images/placeholder.png', 'Rings'),
    //               _productTypes('images/placeholder.png', 'Rings'),
    //               _productTypes('images/placeholder.png', 'Rings'),
    //               _productTypes('images/placeholder.png', 'Rings'),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
    //           height: MediaQuery.of(context).size.height * 0.1,
    //           width: double.infinity,
    //           child: Row(
    //             // mainAxisSize: MainAxisSize.max,
    //             // mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Expanded(
    //                 child: GestureDetector(
    //                   onTap: () {
    //                     Navigator.push(context, MaterialPageRoute(builder: (_) => ProductPage()));
    //                   },
    //                   child: Container(
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               Expanded(
    //                 child: Container(
    //                   color: Colors.blue,
    //                 ),
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          return Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: 3,
              backgroundColor: _currentPage == index ? Colors.amber : Colors.grey,
            ),
          );
        },
      ),
    );
  }

  Widget _productTypes(Icon icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => AllProducts()));
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: secondCont.withOpacity(0.8),
              // offset: Offset(-28, -28),
              offset: Offset(-6.0, -6.0),
              blurRadius: 20.0,
            ),
            BoxShadow(
              color: cont.withOpacity(0.3),
              // offset: Offset(28.0, 28.0),
              offset: Offset(6.0, 6.0),
              blurRadius: 20.0,
            ),
          ],
          color: Color(0xFFEFEEEE),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}

class CurvedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      // ..color = Color(0xFFE6DECE)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0);

    Path path = Path();
    path.moveTo(0, size.height * 0.2); // Starting point at the top-left
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.5, size.width * 0.5, size.height * 0.4);
    // path.lineTo(size.width * 0.6, size.height * 0.4); // Straight line
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.3, size.width,
        size.height * 0.6); // Curved down to the end point at top-right

    // canvas.drawShadow(path, Colors.black, 6.0, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
