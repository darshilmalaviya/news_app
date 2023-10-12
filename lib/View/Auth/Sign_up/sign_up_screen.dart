// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Controller/get_x_controller.dart';
import 'package:news_app/View/Auth/Log_in/log_in_screen.dart';
import '../../../Common/images.dart';
import '../../bottom_nav_bar.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();

  GetCntrl getCntrl = Get.put(GetCntrl());
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
            child: GetBuilder<GetCntrl>(
              id: "register screen",
              builder: (controller) {
                return Column(
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
                      controller: controller.emailcntrl,
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
                      controller: controller.passwordcntrl,
                      validator: (value) {
                        RegExp passwordExp = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
                        if (controller.passwordcntrl.text !=
                            controller.confirmpasswordcntrl.text) {
                          return 'password and confirm password doesnt match';
                        } else {
                          if (value!.trim().isEmpty) {
                            return 'Please enter password';
                          } else if (!passwordExp.hasMatch(value)) {
                            return 'please enter valid password';
                          }
                        }
                        return null;
                      },
                      obscureText: controller.obsecure,
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
                            controller.obsecure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: pickColor.black,
                          ),
                          onPressed: () {
                            controller.obsecure = !controller
                                .obsecure; // Toggle the obscureText value
                            controller.update(['register screen']);
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
                      controller: controller.confirmpasswordcntrl,
                      validator: (value) {
                        RegExp passwordExp = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
                        if (controller.passwordcntrl.text !=
                            controller.confirmpasswordcntrl.text) {
                          return 'password and confirm password doesnt match';
                        } else {
                          if (value!.trim().isEmpty) {
                            return 'Please enter password';
                          } else if (!passwordExp.hasMatch(value)) {
                            return 'please enter valid password';
                          }
                        }

                        return null;
                      },
                      obscureText: controller.obsecure,
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
                          onPressed: () {
                            controller.obsecure = !controller.obsecure;
                            controller.update(['register screen']);
                          },
                          icon: Icon(
                            controller.obsecure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: pickColor.black,
                          ),
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
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            UserCredential userCredential = await controller
                                .auth
                                .createUserWithEmailAndPassword(
                              email: controller.emailcntrl.text,
                              password: controller.passwordcntrl.text,
                            );
                            if (kDebugMode) {
                              print("USER ID ${userCredential.user!.uid}");
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Register Succesfully"),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MyCustomBottomNavBar(),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${e.message}"),
                              ),
                            );
                          }
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
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
