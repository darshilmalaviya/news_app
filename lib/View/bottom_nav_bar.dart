// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Common/images.dart';
import 'package:news_app/View/search_screen.dart';
import 'home_screen.dart';
import 'saved_screen.dart';
import 'setting_screen.dart';

class MyCustomBottomNavBar extends StatefulWidget {
  const MyCustomBottomNavBar({super.key});

  @override
  _MyCustomBottomNavBarState createState() => _MyCustomBottomNavBarState();
}

class _MyCustomBottomNavBarState extends State<MyCustomBottomNavBar> {
  int _currentIndex = 0;

  // Define your screens here
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    SavedScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.black,
          child: Container(
            height: h * 0.085,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: h * 0.035),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  pickColor.blue,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomNavBarItem(
                  image: Image.asset(
                    CommonImg.HomeUnselect,
                    height: h * 0.05,
                    width: w * 0.06,
                  ),
                  image1: Image.asset(
                    CommonImg.HomeSelected,
                    height: h * 0.05,
                    width: w * 0.06,
                  ),
                  onTap: () {
                    _navigateTo(0);
                  },
                  isSelected: _currentIndex == 0,
                ),
                CustomNavBarItem(
                  image: Image.asset(
                    CommonImg.SearchUnselect,
                    height: h * 0.05,
                    width: w * 0.06,
                  ),
                  image1: Image.asset(
                    CommonImg.Searchselect,
                    height: h * 0.05,
                    width: w * 0.06,
                  ),
                  onTap: () {
                    _navigateTo(1);
                  },
                  isSelected: _currentIndex == 1,
                ),
                CustomNavBarItem(
                  image: Image.asset(
                    CommonImg.BookMarkUnselect,
                    height: h * 0.05,
                    width: w * 0.06,
                  ),
                  image1: Image.asset(
                    CommonImg.BookMarkSelect,
                    height: h * 0.05,
                    width: w * 0.06,
                  ),
                  onTap: () {
                    _navigateTo(2);
                  },
                  isSelected: _currentIndex == 2,
                ),
                CustomNavBarItem(
                  image: Image.asset(
                    CommonImg.SettingUnselect,
                    height: h * 0.05,
                    width: w * 0.06,
                  ),
                  image1: Image.asset(
                    CommonImg.Settingselect,
                    height: h * 0.05,
                    width: w * 0.06,
                  ),
                  onTap: () {
                    _navigateTo(3);
                  },
                  isSelected: _currentIndex == 3,
                ),
              ],
            ),
          ),
        ),
      ),
      body: _screens[_currentIndex],
    );
  }

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class CustomNavBarItem extends StatelessWidget {
  final Image image;
  final Image image1;
  final VoidCallback onTap;
  final bool isSelected;

  const CustomNavBarItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.image,
    required this.image1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          isSelected ? image1 : image,
        ],
      ),
    );
  }
}
