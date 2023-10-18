// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Common/images.dart';
import 'package:news_app/Controller/get_x_controller.dart';
import '../Services/Shared_pref_services/pref_service.dart';
import 'Auth/Log_in/log_in_screen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  bool isSwitched = false;

  GetCntrl getCntrl = Get.put(GetCntrl());

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(
          children: [
            SizedBox(height: h * 0.055),
            Center(
              child: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: h * 0.03,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Center(
              child: Container(
                height: h * 0.002,
                width: w * 0.2,
                color: pickColor.blue,
              ),
            ),
            SizedBox(height: h * 0.04),
            Row(
              children: [
                Image.asset(
                  CommonImg.Notification,
                  height: h * 0.05,
                  width: w * 0.05,
                ),
                SizedBox(width: w * 0.02),
                Text(
                  "Push Notifications",
                  style: TextStyle(
                    fontSize: h * 0.02,
                    fontWeight: FontWeight.w400,
                    color: pickColor.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Spacer(),
                GetBuilder<GetCntrl>(
                  id: 'setting',
                  builder: (controller) {
                    return Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        isSwitched = value;
                        getCntrl.update(['setting']);
                      },
                      inactiveThumbColor: pickColor.blue,
                      inactiveTrackColor: pickColor.black,
                      activeTrackColor: pickColor.blue,
                      activeColor: pickColor.blue,
                    );
                  },
                )
              ],
            ),
            SizedBox(height: h * 0.02),
            const Divider(thickness: 1, height: 1, color: pickColor.blue),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: h * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: h * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Image.asset(
                                    CommonImg.cancle,
                                  ),
                                ),
                                SizedBox(width: w * 0.04),
                              ],
                            ),
                            SizedBox(height: h * 0.03),
                            Image.asset(CommonImg.LogOutBlue),
                            SizedBox(height: h * 0.03),
                            Text(
                              "Are you sure you want",
                              style: TextStyle(
                                fontSize: h * 0.025,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              "to Log out",
                              style: TextStyle(
                                fontSize: h * 0.025,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: h * 0.04),
                            GestureDetector(
                              onTap: () async {
                                PrefService.setValue('isLogged', false);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: h * 0.06,
                                width: w * 0.5,
                                decoration: BoxDecoration(
                                  color: pickColor.blue,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: h * 0.02,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                color: Colors.transparent,
                height: h * 0.09,
                child: Row(
                  children: [
                    Image.asset(
                      CommonImg.LogOut,
                      height: h * 0.05,
                      width: w * 0.05,
                    ),
                    SizedBox(width: w * 0.02),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: h * 0.02,
                        fontWeight: FontWeight.w400,
                        color: pickColor.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      CommonImg.ArrowSetting,
                      height: 22,
                      width: 22,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(thickness: 1, height: 1, color: pickColor.blue),
          ],
        ),
      ),
    );
  }
}
