import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:b_sell/appcolors.dart';
import 'package:b_sell/screens/home_page.dart';
import 'package:b_sell/screens/fav_page.dart';
import 'package:b_sell/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentIndex = 0;
  bool search = false;
  final _pageController = PageController(initialPage: 0);
  final notchBottomBarController = NotchBottomBarController(index: 0);

  final List<Widget> _pages = const [
    HomePage(),
    FavPage(),
    SettingsPage(),
  ];

  String getTitle(int condition) {
    switch (condition) {
      case 0:
        return 'STORE';
      case 1:
        return 'FAVOURITES';
      case 2:
        return 'INFO';
      default:
        return 'Default Option';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          backgroundColor: Colors.black,
          // _currentIndex != 0 ?
          appBar: _currentIndex != 0
              ? AppBar(
                  scrolledUnderElevation: 0,
                  toolbarHeight: MediaQuery.of(context).size.height * 0.2,
                  centerTitle: true,
                  title: Image.asset(
                    'images/logo.png',
                    // scale: 0.01,
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(8),
                  //   child: Icon(
                  //     Icons.diamond,
                  //     color: Colors.white,
                  //     size: 30,
                  //   ),
                  // ),
                  elevation: 0,
                  backgroundColor: Colors.black,
                )
              : null,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: _pages[_currentIndex],
          ),
          extendBody: true,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: SizedBox(
            height: MediaQuery.of(context).size.height >= 800
                ? MediaQuery.of(context).size.height * 0.2
                : MediaQuery.of(context).size.height * 0.115,
            child: AnimatedNotchBottomBar(
              showLabel: MediaQuery.of(context).size.height >= 800 ? true : false,
              itemLabelStyle: TextStyle(color: white, fontSize: 12),
              kIconSize: MediaQuery.of(context).size.height >= 800 ? 24 : 20,
              notchBottomBarController: notchBottomBarController,
              bottomBarWidth: MediaQuery.of(context).size.width * 0.5,
              kBottomRadius: 0,
              removeMargins: true,
              color: Colors.black,
              notchColor: white,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home,
                    color: white,
                  ),
                  activeItem: const Icon(
                    Icons.home_filled,
                    color: Colors.black,
                  ),
                  itemLabel: 'Home',
                  // icon: Icons.home,
                  // text: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.favorite,
                    color: white,
                  ),
                  activeItem: const Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                  itemLabel: 'Saved',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.settings,
                    color: white,
                  ),
                  activeItem: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  itemLabel: 'Settings',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _buildSearchField() {
  //   return TextField(
  //     autofocus: true,
  //     decoration: InputDecoration(
  //       hintText: 'Search Products',
  //       border: InputBorder.none,
  //       hintStyle: TextStyle(color: Colors.black),
  //     ),
  //     style: TextStyle(color: Colors.black),
  //     onChanged: (value) {
  //       logger.i(value);
  //     },
  //     onSubmitted: (value) {},
  //   );
  // }
}
