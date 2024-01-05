import 'package:b_sell/appcolors.dart';
import 'package:b_sell/main.dart';
import 'package:b_sell/screens/home_page.dart';
import 'package:b_sell/screens/offers_page.dart';
import 'package:b_sell/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentIndex = 0;
  bool search = false;
  NotchBottomBarController notchBottomBarController = NotchBottomBarController();

  final List<Widget> _pages = [
    HomePage(),
    OffersPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 206, 214, 230),
      appBar: AppBar(
        title: search ? _buildSearchField() : Text('STORE'),
        elevation: 0,
        backgroundColor: cont,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
            color: secondCont,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                search = !search;
              });
            },
            icon: Icon(Icons.search),
            color: secondCont,
          ),
        ],
      ),
      body: Center(
        child: Text(
          'hello',
          style: TextStyle(color: Colors.black),
        ),
      ),
      // IndexedStack(
      //   index: _currentIndex,
      //   children: _pages,
      // ),
      // SafeArea(
      //   child: _pages[_currentIndex],
      // ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        itemLabelStyle: TextStyle(color: secondCont, fontSize: 12),
        kIconSize: 24,
        notchBottomBarController: notchBottomBarController,
        kBottomRadius: 0,
        removeMargins: true,
        color: cont,
        notchColor: secondCont,
        // pageController: _pageController,
        //  : _currentIndex,

        onTap: (index) {
          // notchBottomBarController.addListener(() => {
          //   _currentIndex = index
          // });
          setState(() {
            // _currentIndex = index;
            _currentIndex = notchBottomBarController.index;
            // logger.d(index);
            logger.d(_currentIndex);
          });
        },
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home,
              color: secondCont,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: cont,
            ),
            itemLabel: 'Home',
            // icon: Icons.home,
            // text: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.favorite,
              color: secondCont,
            ),
            activeItem: Icon(
              Icons.favorite,
              color: cont,
            ),
            itemLabel: 'Fav',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.settings,
              color: secondCont,
            ),
            activeItem: Icon(
              Icons.settings,
              color: cont,
            ),
            itemLabel: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search Products',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black),
      ),
      style: TextStyle(color: Colors.black),
      onChanged: (value) {
        logger.i(value);
      },
      onSubmitted: (value) {},
    );
  }
}
