// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Common/images.dart';
import 'package:news_app/Controller/get_x_controller.dart';
import 'package:news_app/View/bottom_nav_bar.dart';

class ForgotPassWord extends StatelessWidget {
  ForgotPassWord({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    GetCntrl getCntrl = Get.put(GetCntrl());

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
                GetBuilder<GetCntrl>(
                  id: 'forgotpass',
                  builder: (controller) {
                    return Column(
                      children: [
                        TextFormField(
                          controller: controller.ForgotPassEmail,
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
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                await controller.auth.sendPasswordResetEmail(
                                    email: controller.ForgotPassEmail.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Reset link sent successfully",
                                    ),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("$e"),
                                  ),
                                );
                              }
                            }
                            controller.update(['forgotpass']);
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
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
