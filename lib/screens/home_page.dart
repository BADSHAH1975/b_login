import 'package:b_sell/appcolors.dart';
import 'package:b_sell/bloc/search_bloc.dart';
import 'package:b_sell/models/product.dart';
import 'package:b_sell/screens/product/all_products.dart';
import 'package:b_sell/screens/product/product_item.dart';
import 'package:b_sell/screens/product/products_search_item.dart';
import 'package:b_sell/widgets/card_stack_page_view.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool search = false;
  final List<String> pageTexts = ['Page 1', 'Page 2', 'Page 3', 'Page 4', 'Page 5'];

  int _currentPage = 0;

  // final _offset = Offset(6, 6);
  // double blur = 20.0;

  // final _searchController = TextEditingController();
  final PageController _pageController = PageController();

  late TabController _tabController;
  final List<String> categories = ['Exclusive', 'Trending', 'Most Liked'];

  String _query = '';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     // Access PageController.page here
  //     print(_pageController.page);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return ResponsiveBuilder(
      builder: (_, sizingInformation) => Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 10),
          // color: white,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    child: Image.asset('images/logo.png'),
                  ),
                  Expanded(
                    child: Container(
                      // color: white,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                        color: white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            padding: EdgeInsets.zero,
                            tabAlignment: TabAlignment.fill,
                            indicatorWeight: 3.0,

                            indicatorPadding: EdgeInsets.all(6),
                            controller: _tabController,
                            // isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: gold,
                            labelPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                            labelStyle: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: black,
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: GoogleFonts.poppins(
                              fontSize: 14.0,
                              color: grey,
                            ),
                            tabs: categories.map((category) => Tab(text: category)).toList(),
                            onTap: (index) => _pageController.animateToPage(
                              index,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            ),
                          ),
                          Expanded(
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _tabController.animateTo(index);
                                });
                              },
                              children: categories.map((category) {
                                return Center(
                                  child: Swiper(
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        color: black,
                                      );
                                      // Image.network(
                                      //   "https://via.placeholder.com/288x188",
                                      //   color: black,
                                      //   fit: BoxFit.fill,
                                      // );
                                    },
                                    itemCount: 2,
                                    itemWidth: 200.0,
                                    layout: SwiperLayout.STACK,
                                  ),
                                  //     CardStackPageView(
                                  //   cardDistance: 20.0, // Adjust distance between cards
                                  //   perspective: 0.003, // Increase for stronger 3D effect
                                  //   cards: [
                                  //     Container(
                                  //       height: 120,
                                  //       width: 100,
                                  //       color: black,
                                  //     ),
                                  //     Container(
                                  //       height: 120,
                                  //       width: 100,
                                  //       color: black,
                                  //     ),
                                  //   ],
                                  // )
                                  //     Text(
                                  //   'Content for category: $category',
                                  //   style: const TextStyle(fontSize: 20.0),
                                  // ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Container(
                                    // height: 190,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: black,
                                      borderRadius: BorderRadius.circular(16.0),
                                      // image: DecorationImage(
                                      //   image: AssetImage('images/diamondring.png'),
                                      //   fit: BoxFit.fill,
                                      // ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: black,
                                      borderRadius: BorderRadius.circular(16.0),
                                      // image: DecorationImage(
                                      //   image: AssetImage('images/diamondring.png'),
                                      //   fit: BoxFit.fill,
                                      // ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: black,
                                      borderRadius: BorderRadius.circular(16.0),
                                      // image: DecorationImage(
                                      //   image: AssetImage('images/diamondring.png'),
                                      //   fit: BoxFit.fill,
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 95,
                          ),
                        ],
                      ),
                    ),
                  )
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.35,
                  //   width: double.infinity,
                  //   // padding: EdgeInsets.fromLTRB(, top, right, bottom),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //       bottomLeft: Radius.circular(100.0),
                  //     ),
                  //     color: primary,
                  //   ),
                  //   child: const Column(
                  //     children: [
                  //       // Padding(
                  //       //   padding: const EdgeInsets.symmetric(horizontal: 25),
                  //       //   child: Container(
                  //       //     height: 50,
                  //       //     // width: 100,
                  //       //     decoration: BoxDecoration(
                  //       //       borderRadius: BorderRadius.circular(30),
                  //       //       boxShadow: [
                  //       //         BoxShadow(
                  //       //           color: Colors.white.withOpacity(0.5),
                  //       //           offset: Offset(2.0, -2.0),
                  //       //           blurRadius: 5,
                  //       //           inset: true,
                  //       //         ),
                  //       //         const BoxShadow(
                  //       //           color: Color(0xff151515),
                  //       //           offset: Offset(-2.0, 2.0),
                  //       //           blurRadius: 5,
                  //       //           inset: true,
                  //       //         ),
                  //       //       ],
                  //       //       color: primary,
                  //       //     ),
                  //       //     padding: EdgeInsets.symmetric(horizontal: 20),
                  //       //     child: TextFormField(
                  //       //       controller: _searchController,
                  //       //       onChanged: (query) {
                  //       //         // BlocProvider.of<SearchBloc>(context).add(PerformSearch(query));
                  //       //       },
                  //       //       style: TextStyle(
                  //       //         color: white,
                  //       //       ),
                  //       //       decoration: InputDecoration(
                  //       //         border: InputBorder.none,
                  //       //         focusedBorder: InputBorder.none,
                  //       //         hintText: 'Search..',
                  //       //         hintStyle: TextStyle(
                  //       //           color: secondCont.withOpacity(0.7),
                  //       //         ),
                  //       //         // suffixIconConstraints: BoxConstraints(),
                  //       //         // contentPadding: EdgeInsets.all(),
                  //       //         suffixIcon: Icon(
                  //       //           Icons.search,
                  //       //           color: secondCont.withOpacity(0.7),
                  //       //         ),
                  //       //       ),
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //       // const SizedBox(
                  //       //   height: 30,
                  //       // ),
                  //       // Expanded(
                  //       //   child: PageView.builder(
                  //       //     itemCount: pageTexts.length,
                  //       //     itemBuilder: (context, index) {
                  //       //       double scaleFactor = 1.0;
                  //       //       if (_pageController.position.haveDimensions && index == _pageController.page?.round()) {
                  //       //         scaleFactor = 1.2;
                  //       //       }
                  //       //       return AnimatedContainer(
                  //       //         height: 50,
                  //       //         width: 100,
                  //       //         duration: Duration(milliseconds: 500),
                  //       //         curve: Curves.easeInOut,
                  //       //         transform: Matrix4.identity()..scale(scaleFactor),
                  //       //         margin: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
                  //       //         color: Colors.blue, // Set the background color as needed
                  //       //         child: Center(
                  //       //           child: Text(
                  //       //             pageTexts[index],
                  //       //             // style: TextStyle(color: Colors.white, fontSize: 2.0),
                  //       //           ),
                  //       //         ),
                  //       //       );
                  //       //     },
                  //       //   ),
                  //       // ),
                  //       // Expanded(
                  //       //   child: Padding(
                  //       //     padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                  //       //     child: PageView(
                  //       //       padEnds: false,
                  //       //       children: [
                  //       //         Container(color: Colors.blue),
                  //       //         Container(color: Colors.green),
                  //       //         Container(color: Colors.orange),
                  //       //       ],
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //       // LayoutBuilder(builder: (context, constraints) {
                  //       //   return Expanded(
                  //       //     child: PageView.builder(
                  //       //       controller: _pageController,
                  //       //       itemCount: 5,
                  //       //       itemBuilder: (context, index) {
                  //       //         final isActive = index == _pageController.page?.round();
                  //       //         return AnimatedContainer(
                  //       //           duration: Duration(milliseconds: 200),
                  //       //           curve: Curves.easeInOut,
                  //       //           transform: Matrix4.identity()..scale(isActive ? 1.2 : 1.0),
                  //       //           child: Padding(
                  //       //             padding: EdgeInsets.symmetric(horizontal: 16 / 2),
                  //       //             child: Container(
                  //       //               height: 50,
                  //       //               width: 50,
                  //       //               color: Colors.white,
                  //       //             ),
                  //       //           ),
                  //       //         );
                  //       //       },
                  //       //     ),
                  //       //   );
                  //       // }
                  //       // child: Expanded(
                  //       //   child: PageView.builder(
                  //       //     controller: _pageController,
                  //       //     itemCount: 5,
                  //       //     itemBuilder: (context, index) {
                  //       //       final isActive = index == _pageController.page?.round();
                  //       //       return AnimatedContainer(
                  //       //         duration: Duration(milliseconds: 200),
                  //       //         curve: Curves.easeInOut,
                  //       //         transform: Matrix4.identity()..scale(isActive ? 1.2 : 1.0),
                  //       //         child: Padding(
                  //       //           padding: EdgeInsets.symmetric(horizontal: 16 / 2),
                  //       //           child: Container(
                  //       //             height: 50,
                  //       //             width: 50,
                  //       //             color: Colors.white,
                  //       //           ),
                  //       //         ),
                  //       //       );
                  //       //     },
                  //       //   ),
                  //       // PageView.builder(
                  //       //   itemCount: 10,
                  //       //   controller: PageController(viewportFraction: 0.1),
                  //       //   itemBuilder: (context, index) {
                  //       //     // return CenterUpliftedItem(index);
                  //       //     return Container(
                  //       //       height: 100,
                  //       //       width: 100,
                  //       //       color: Colors.blue,
                  //       //     );
                  //       //   },
                  //       // ),
                  //       // ),
                  //       // ),
                  //       // Align(
                  //       //   alignment: Alignment.centerLeft,
                  //       //   child: Container(
                  //       //     margin: EdgeInsets.only(left: 35),
                  //       //     height: MediaQuery.of(context).size.height * 0.2,
                  //       //     width: 250,
                  //       //     decoration: BoxDecoration(
                  //       //       // color: cont.withOpacity(0.8),
                  //       //       gradient: LinearGradient(
                  //       //         begin: Alignment.topCenter,
                  //       //         end: Alignment.bottomCenter,
                  //       //         colors: [cont],
                  //       //         stops: [1.0],
                  //       //       ),
                  //       //       border: Border(
                  //       //         right: BorderSide(
                  //       //           width: 2.0,
                  //       //           color: Colors.white.withOpacity(0.3),
                  //       //         ),
                  //       //         top: BorderSide(
                  //       //           width: 2.0,
                  //       //           color: Colors.white.withOpacity(0.3),
                  //       //         ),
                  //       //         // left: BorderSide(
                  //       //         //   width: 2.0,
                  //       //         //   color: Colors.white.withOpacity(0.3),
                  //       //         // ),
                  //       //       ),
                  //       //       borderRadius: BorderRadius.only(
                  //       //         topRight: Radius.circular(60),
                  //       //         topLeft: Radius.circular(10),
                  //       //       ),
                  //       //       boxShadow: [
                  //       //         BoxShadow(
                  //       //           color: secondCont.withOpacity(0.5),
                  //       //           // offset: Offset(-28, -28),
                  //       //           offset: Offset(3.0, -3.0),
                  //       //           blurRadius: 10.0,
                  //       //         ),
                  //       //         BoxShadow(
                  //       //           color: Colors.black.withOpacity(0.3),
                  //       //           // offset: Offset(28.0, 28.0),
                  //       //           offset: Offset(-6.0, 6.0),
                  //       //           blurRadius: 10.0,
                  //       //         ),
                  //       //       ],
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: const BorderRadius.only(
                  //       bottomLeft: Radius.circular(120.0),
                  //     ),
                  //     color: primary,
                  //   ),
                  //   child: Container(
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.only(
                  //         topRight: Radius.circular(110.0),
                  //       ),
                  //       color: white,
                  //     ),
                  //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Text(
                  //           'Categories',
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             _productTypes(Icon(Icons.diamond)),
                  //             _productTypes(Icon(Icons.trending_up)),
                  //             _productTypes(Icon(Icons.access_time))
                  //           ],
                  //         ),
                  //         SizedBox(
                  //           height: 20,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             _productTypes(Icon(Icons.diamond)),
                  //             _productTypes(Icon(Icons.trending_up)),
                  //             _productTypes(Icon(Icons.access_time))
                  //           ],
                  //         ),
                  //         SizedBox(
                  //           height: 100,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              // buildFloatingSearchBar(),
            ],
          ),
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

class CenterUpliftedItem extends StatelessWidget {
  final int index;

  CenterUpliftedItem(this.index);

  @override
  Widget build(BuildContext context) {
    double scaleFactor = 1.0;
    if (index == 0) {
      scaleFactor = 1.2; // Scale up the first item
    } else if (index == 1) {
      scaleFactor = 1.1; // Scale up the second item
    }

    return Center(
      child: Transform.scale(
        scale: scaleFactor,
        child: Container(
          width: 200,
          height: 100,
          color: Colors.blue,
          child: Center(
            child: Text('Item $index', style: TextStyle(color: Colors.white)),
          ),
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
