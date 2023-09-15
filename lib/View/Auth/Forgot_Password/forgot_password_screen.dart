import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/View/bottom_nav_bar.dart';

import '../../../Common/images.dart';

class ForgotPassWord extends StatefulWidget {
  const ForgotPassWord({super.key});

  @override
  State<ForgotPassWord> createState() => _ForgotPassWordState();
}

class _ForgotPassWordState extends State<ForgotPassWord> {
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
              children: [
                SizedBox(height: h * 0.055),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: w * 0.07,
                      ),
                    ),
                    SizedBox(width: w * 0.2),
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: h * 0.025,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.026),
                Text(
                  "Enter your email id to reset your",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: h * 0.02,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: h * 0.02,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: h * 0.03),
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
                      fontSize: h * 0.016,
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
                          "Continue",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
