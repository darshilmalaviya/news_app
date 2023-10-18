// ignore_for_file: unused_local_variable, must_be_immutable, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Common/images.dart';
import 'package:news_app/Controller/get_x_controller.dart';
import 'package:news_app/View/Auth/Forgot_Password/forgot_password_screen.dart';
import 'package:news_app/View/Auth/Sign_up/sign_up_screen.dart';
import 'package:news_app/View/bottom_nav_bar.dart';

import '../../../Services/Shared_pref_services/pref_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();

  final h = Get.height;
  final w = Get.width;

  GetCntrl getCntrl = Get.put(GetCntrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: GetBuilder<GetCntrl>(
              id: "LoginScreen",
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.08),
                    Text(
                      "Hello",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: h * 0.065,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      "Again!",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                        fontSize: h * 0.065,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: h * 0.001),
                    Text(
                      "Welcome back",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: h * 0.027,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: h * 0.04),
                    TextFormField(
                      controller: controller.loginEmail,
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
                      controller: controller.loginPassword,
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
                      obscureText: controller.obSecure,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        hintStyle: TextStyle(
                          fontSize: h * 0.018,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38,
                          fontFamily: 'Poppins',
                        ),
                        prefixIcon: SizedBox(
                          height: h * 0.02,
                          width: w * 0.02,
                          child: Image.asset(
                            CommonImg.password,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.obSecure = !controller.obSecure;
                            controller.update(['LoginScreen']);
                          },
                          icon: Icon(
                            controller.obSecure
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
                    SizedBox(height: h * 0.01),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassWord(),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: h * 0.018,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.055),
                    controller.loading == true
                        ? const Center(child: CircularProgressIndicator())
                        : Center(
                            child: GestureDetector(
                              onTap: () async {
                                controller.loading = true;
                                getCntrl.update(['LoginScreen']);
                                if (formKey.currentState!.validate()) {
                                  print("LOADING-----${controller.loading}");
                                  try {
                                    UserCredential userCredential =
                                        await controller
                                            .auth
                                            .signInWithEmailAndPassword(
                                                email:
                                                    controller.loginEmail.text,
                                                password: controller
                                                    .loginPassword.text);

                                    await getCntrl.saved.get().then((value) {
                                      value.docs.forEach((element) {
                                        if (element['email'] ==
                                            getCntrl.loginEmail.text) {
                                          var id = element.id;
                                          PrefService.setValue('docId', id);
                                          PrefService.setValue(
                                              'isLogged', true);
                                          print(PrefService.getString('docId'));
                                        } else {}
                                      });
                                    });

                                    if (kDebugMode) {
                                      print(
                                          "USER ID ${userCredential.user!.uid}");
                                    }

                                    controller.loading = false;
                                    getCntrl.update(['LoginScreen']);

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MyCustomBottomNavBar(),
                                      ),
                                    );
                                    controller.update(['LoginScreen']);
                                  } on FirebaseAuthException catch (e) {
                                    controller.loading = false;
                                    getCntrl.update(['LoginScreen']);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("${e.message}"),
                                      ),
                                    );
                                  }
                                  getCntrl.update(['LoginScreen']);
                                } else {
                                  controller.loading = false;
                                  getCntrl.update(['LoginScreen']);
                                }
                              },
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
                                  child: controller.loading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Sign In",
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
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: h * 0.018,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            " Sign up",
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
