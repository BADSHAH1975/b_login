import 'package:b_sell/appcolors.dart';
import 'package:b_sell/bloc/search_bloc.dart';
import 'package:b_sell/models/product.dart';
import 'package:b_sell/screens/product/all_products.dart';
import 'package:b_sell/screens/product/product_item.dart';
import 'package:b_sell/screens/product/products_search_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

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
  String _query = '';

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 10),
        color: secondCont,
        child: Stack(
          children: [
            Column(
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
                              const BoxShadow(
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
                            onChanged: (query) {
                              BlocProvider.of<SearchBloc>(context).add(PerformSearch(query));
                            },
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
                          margin: EdgeInsets.only(left: 35),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: 250,
                          decoration: BoxDecoration(
                            // color: cont.withOpacity(0.8),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [cont],
                              stops: [1.0],
                            ),
                            border: Border(
                              right: BorderSide(
                                width: 2.0,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              top: BorderSide(
                                width: 2.0,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              // left: BorderSide(
                              //   width: 2.0,
                              //   color: Colors.white.withOpacity(0.3),
                              // ),
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(60),
                              topLeft: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: secondCont.withOpacity(0.5),
                                // offset: Offset(-28, -28),
                                offset: Offset(3.0, -3.0),
                                blurRadius: 10.0,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
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
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(120.0),
                    ),
                    color: cont,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(110.0),
                      ),
                      color: secondCont,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
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
                  ),
                ),
              ],
            ),
            buildFloatingSearchBar(),
          ],
        ),
      ),
    );
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

  Widget buildFloatingSearchBar() {
    // final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 200),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      // axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      height: 40,
      debounceDelay: const Duration(milliseconds: 500),
      borderRadius: BorderRadius.circular(30),

      // shadowColor: ,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(30),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.white.withOpacity(0.5),
      //       offset: Offset(2.0, -2.0),
      //       blurRadius: 5,
      //       inset: true,
      //     ),
      //     const BoxShadow(
      //       color: Color(0xff151515),
      //       offset: Offset(-2.0, 2.0),
      //       blurRadius: 5,
      //       inset: true,
      //     ),
      //   ],
      //   color: cont,
      // ),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
        // BlocProvider.of<SearchBloc>(context).add(PerformSearch(query));

        setState(() {
          _query = query.toLowerCase();
        });
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        // return BlocBuilder<SearchBloc, SearchState>(
        //   builder: (context, state) {
        //     if (state is SearchLoading) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (state is SearchLoaded) {
        //       return ClipRRect(
        //         borderRadius: BorderRadius.circular(8),
        //         child: Material(
        //           color: Colors.white,
        //           elevation: 4.0,
        //           child: ListView.builder(
        //             itemCount: state.products.length,
        //             itemBuilder: (context, index) {
        //               final product = state.products[index];
        //               return ListTile(
        //                 title: Text(product.name),
        //                 // Add more details or customize the ListTile as needed
        //               );
        //             },
        //           ),
        //         ),
        //       );
        //     } else if (state is SearchError) {
        //       return Center(child: Text('Error: ${state.error}'));
        //     } else {
        //       return Container(); // Empty container when no search query
        //     }
        //   },
        // );
        return StreamBuilder<QuerySnapshot>(
          stream:
              // _query == ''
              //     ? FirebaseFirestore.instance.collection('products').snapshots()
              //     :
              FirebaseFirestore.instance
                  .collection('products')
                  // .orderBy('name')
                  .where('name', isGreaterThanOrEqualTo: _query)
                  .where('name', isLessThanOrEqualTo: _query + '\uf7ff')
                  // .startAt([_query]).endAt([_query])
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final products = snapshot.data!.docs.map((doc) => Product.fromSnapshot(doc)).toList();

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    // border: Border.fromBorderSide(bottom: )
                    ),
                child: ProductSearchItem(
                  product: products[index],
                ),
              ),
            );
          },
        );

        // return ClipRRect(
        //   borderRadius: BorderRadius.circular(8),
        //   child: Material(
        //     color: Colors.white,
        //     elevation: 4.0,
        //     child: Container(
        //       height: 100,
        //       color: Colors.white,
        //     ),
        //     // Column(
        //     //   mainAxisSize: MainAxisSize.min,
        //     //   children: Colors.accents.map((color) {
        //     //     return Container(height: 112, color: color);
        //     //   }).toList(),
        //     // ),
        //   ),
        // );
      },
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
