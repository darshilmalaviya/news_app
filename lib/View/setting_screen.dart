import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Common/images.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = false;
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
            Text(
              "Settings",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: h * 0.03,
                fontFamily: 'Poppins',
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
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  inactiveThumbColor: pickColor.blue,
                  inactiveTrackColor: pickColor.black,
                  activeTrackColor: pickColor.blue,
                  activeColor: pickColor.blue,
                ),
              ],
            ),
            SizedBox(height: h * 0.02),
            const Divider(thickness: 1, height: 1, color: pickColor.blue),
            SizedBox(height: h * 0.02),
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
                            Container(
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
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
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
            SizedBox(height: h * 0.02),
            const Divider(thickness: 1, height: 1, color: pickColor.blue),
          ],
        ),
      ),
    );
  }
}
