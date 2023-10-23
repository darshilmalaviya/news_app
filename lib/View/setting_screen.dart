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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: h * 0.1,
        backgroundColor: Colors.white,
        title: Column(children: [
          Text(
            "Settings",
            style: TextStyle(
              color: colorRes.iconColor,
              fontWeight: FontWeight.w500,
              fontSize: h * 0.035,
              fontFamily: 'Poppins',
            ),
          ),
          Container(
            height: h * 0.002,
            width: w * 0.24,
            color: colorRes.blue,
          ),
        ]),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  CommonImg.Notification,
                  height: h * 0.07,
                  width: w * 0.07,
                ),
                SizedBox(width: w * 0.03),
                Text(
                  "Push Notifications",
                  style: TextStyle(
                    fontSize: h * 0.025,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
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
                      inactiveThumbColor: colorRes.blue,
                      inactiveTrackColor: colorRes.black,
                      activeTrackColor: colorRes.blue,
                      activeColor: colorRes.blue,
                    );
                  },
                )
              ],
            ),
            SizedBox(height: h * 0.02),
            const Divider(thickness: 1, height: 1, color: colorRes.blue),
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
                                InkResponse(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    CommonImg.cancle,
                                    height: h * 0.03,
                                    width: w * 0.03,
                                  ),
                                ),
                                SizedBox(width: w * 0.04),
                              ],
                            ),
                            SizedBox(height: h * 0.03),
                            SizedBox(
                              height: h * 0.1,
                              child: Image.asset(
                                fit: BoxFit.cover,
                                CommonImg.LogOutBlue,
                              ),
                            ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
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
                                    width: w * 0.25,
                                    decoration: BoxDecoration(
                                      color: colorRes.blue,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: h * 0.03,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    height: h * 0.06,
                                    width: w * 0.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: colorRes.blue, width: 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                          color: colorRes.blue,
                                          fontWeight: FontWeight.w500,
                                          fontSize: h * 0.03,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: h * 0.001),
                color: Colors.transparent,
                height: h * 0.09,
                child: Row(
                  children: [
                    Image.asset(
                      CommonImg.LogOut,
                      height: h * 0.07,
                      width: w * 0.07,
                    ),
                    SizedBox(width: w * 0.03),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: h * 0.025,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      CommonImg.ArrowSetting,
                      height: h * 0.02,
                      width: w * 0.08,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(thickness: 1, height: 1, color: colorRes.blue),
          ],
        ),
      ),
    );
  }
}
