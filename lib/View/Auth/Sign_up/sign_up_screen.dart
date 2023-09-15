import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/View/Auth/Log_in/log_in_screen.dart';

import '../../../Common/images.dart';
import '../../bottom_nav_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obsecure = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.08),
                  Text(
                    "Hello!",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                      fontSize: h * 0.065,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Text(
                    "Signup to get Started",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: h * 0.027,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: h * 0.05),
                  TextFormField(
                    validator: (value) {
                      RegExp emailExp = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (value!.trim().isEmpty) {
                        return 'please enter email';
                      } else if (!emailExp.hasMatch(value)) {
                        return 'please enter valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Email ID",
                      hintStyle: TextStyle(
                        fontSize: h * 0.018,
                        fontWeight: FontWeight.w500,
                        color: Colors.black38,
                        fontFamily: 'Poppins',
                      ),
                      prefixIcon: Image.asset(
                        CommonImg.mail,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03),
                  TextFormField(
                    validator: (value) {
                      RegExp passwordExp = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
                      if (value!.trim().isEmpty) {
                        return 'Please enter password';
                      } else if (!passwordExp.hasMatch(value)) {
                        return 'please enter valid password';
                      }
                      return null;
                    },
                    obscureText: obsecure,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      hintStyle: TextStyle(
                        fontSize: h * 0.018,
                        fontWeight: FontWeight.w500,
                        color: Colors.black38,
                        fontFamily: 'Poppins',
                      ),
                      prefixIcon: Image.asset(
                        CommonImg.password,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obsecure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: pickColor.black,
                        ),
                        onPressed: () {
                          setState(() {
                            obsecure =
                                !obsecure; // Toggle the obscureText value
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03),
                  TextFormField(
                    validator: (value) {
                      RegExp passwordExp = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
                      if (value!.trim().isEmpty) {
                        return 'Please enter password';
                      } else if (!passwordExp.hasMatch(value)) {
                        return 'please enter valid password';
                      }
                      return null;
                    },
                    obscureText: obsecure,
                    decoration: InputDecoration(
                      hintText: "Enter Confirm Password",
                      hintStyle: TextStyle(
                        fontSize: h * 0.018,
                        fontWeight: FontWeight.w500,
                        color: Colors.black38,
                        fontFamily: 'Poppins',
                      ),
                      prefixIcon: Image.asset(
                        CommonImg.password,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obsecure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: pickColor.black,
                        ),
                        onPressed: () {
                          setState(() {
                            obsecure =
                                !obsecure; // Toggle the obscureText value
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.08),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyCustomBottomNavBar(),
                          ),
                        );
                      }
                    },
                    child: Center(
                      child: Container(
                        height: h * 0.07,
                        width: w * 0.7,
                        decoration: BoxDecoration(
                          color: pickColor.blue,
                          borderRadius: BorderRadius.circular(
                            7,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: h * 0.023,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.07),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: h * 0.018,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          " Sign in",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: h * 0.018,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
