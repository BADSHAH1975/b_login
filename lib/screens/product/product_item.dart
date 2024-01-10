import 'package:b_sell/appcolors.dart';
import 'package:b_sell/screens/product/product_page.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductItem extends StatefulWidget {
  final String productName;

  ProductItem(this.productName);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _fav = false;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return Container(
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     color: secondCont.withOpacity(0.8),
            //     // offset: Offset(-28, -28),
            //     offset: Offset(-6.0, -6.0),
            //     blurRadius: 20.0,
            //   ),
            //   BoxShadow(
            //     color: cont.withOpacity(0.3),
            //     // offset: Offset(28.0, 28.0),
            //     offset: Offset(6.0, 6.0),
            //     blurRadius: 20.0,
            //   ),
            // ],
            color: Color(0xFFEFEEEE),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  // onTap: () {
                  //   Navigator.push(context, MaterialPageRoute(builder: (_) => ProductPage()));
                  // },
                  child: Image.asset('images/diamondring.png'),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Diamond Ring',
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _fav = !_fav;
                        });
                      },
                      child: _fav
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.favorite_border,
                            ),
                    )
                    // IconButton(
                    //   padding: EdgeInsets.zero,
                    //   onPressed: () {
                    //     setState(() {
                    //       _fav = !_fav;
                    //     });
                    //   },
                    //   icon: _fav
                    //       ? Icon(
                    //           Icons.favorite,
                    //           color: Colors.red,
                    //         )
                    //       : Icon(
                    //           Icons.favorite_border,
                    //         ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text(
                  'Rs. 1999',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   height: 25,
              //   decoration: BoxDecoration(
              //     color: cont,
              //     borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(12),
              //       bottomRight: Radius.circular(12),
              //     ),
              //   ),
              //   child: Text(
              //     'Like This?',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // )
            ],
          ),
        );
      },
      openBuilder: (BuildContext _, VoidCallback __) {
        return ProductPage();
      },
    );
  }
}
