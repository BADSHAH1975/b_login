import 'package:b_sell/appcolors.dart';
import 'package:b_sell/screens/product/product_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool search = false;

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100.0),
              ),
              color: cont,
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
                    children: [_productTypes(), _productTypes(), _productTypes()],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_productTypes(), _productTypes(), _productTypes()],
                  ),
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

  Widget _productTypes() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: secondCont.withOpacity(0.8),
            offset: Offset(-6.0, -6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: cont.withOpacity(0.3),
            offset: Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
        color: Color(0xFFEFEEEE),
        borderRadius: BorderRadius.circular(12.0),
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
