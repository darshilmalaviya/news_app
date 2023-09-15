import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Common/images.dart';

import 'Auth/Log_in/log_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  pickColor.SplashtopArea,
                  pickColor.SplashbottomArea,
                ],
              ),
            ),
            child: Center(
              child: Image.asset(
                CommonImg.splashLogo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
