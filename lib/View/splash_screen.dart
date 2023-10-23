// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Common/images.dart';
import 'package:news_app/Services/Shared_pref_services/pref_service.dart';
import 'package:news_app/View/bottom_nav_bar.dart';

import 'Auth/Log_in/log_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        bool isLogged = PrefService.getBool('isLogged');
        isLogged
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyCustomBottomNavBar(),
                ),
              )
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [
                    colorRes.SplashtopArea,
                    colorRes.SplashbottomArea,
                  ],
                ),
              ),
              child: Center(
                child: Image.asset(
                  CommonImg.splashLogo,
                  height: Get.height * 0.55,
                  width: Get.width * 0.55,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
