import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: h * 0.045),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: h * 0.03,
                ),
              ),
              SizedBox(width: w * 0.21),
              Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: h * 0.03,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              height: h * 0.002,
              width: w * 0.32,
              color: pickColor.blue,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Row(
                  children: [
                    Text(
                      "The Hindu News",
                      style: TextStyle(
                        fontSize: h * 0.019,
                        fontWeight: FontWeight.w400,
                        color: pickColor.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: w * 0.12,
                      height: h * 0.025,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: pickColor.blue,
                      ),
                      child: Center(
                        child: Text("New",
                            style: TextStyle(
                              fontSize: h * 0.016,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.01),
                Container(
                  height: h * 0.13,
                  width: w * 1,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: pickColor.blue,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        SizedBox(height: 12),
                        Text(
                          "Covid live: England hospitality bosses welcome lack of new restrictions; Japan reports first Omicron cluster",
                          style: TextStyle(
                            fontSize: h * 0.017,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "World",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: h * 0.016,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(width: w * 0.04),
                            CircleAvatar(
                              maxRadius: 4,
                              backgroundColor: pickColor.grey,
                            ),
                            SizedBox(width: w * 0.04),
                            Text("1 hr ago",
                                style: TextStyle(
                                  fontSize: h * 0.018,
                                  fontWeight: FontWeight.w400,
                                  color: pickColor.grey,
                                  fontFamily: 'Poppins',
                                )),
                          ],
                        ),
                        SizedBox(height: h * 0.01),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: h * 0.025),
                Text(
                  "The Hindu News",
                  style: TextStyle(
                    fontSize: h * 0.019,
                    fontWeight: FontWeight.w400,
                    color: pickColor.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: h * 0.005),
                Container(
                  width: w * 1,
                  height: h * 0.16,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: pickColor.blue,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.004),
                    child: Column(
                      children: [
                        SizedBox(height: h * 0.012),
                        Text(
                          "India launched its ambitious Chandrayaan-3 mission aboard India's heaviest rocket, Launch vehicle Mark-III a.k.a LVM3 on a journey to the Moon.",
                          style: TextStyle(
                            fontSize: h * 0.017,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "World",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: h * 0.016,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(width: w * 0.04),
                            CircleAvatar(
                              maxRadius: 4,
                              backgroundColor: pickColor.grey,
                            ),
                            SizedBox(width: w * 0.04),
                            Text("1 hr ago",
                                style: TextStyle(
                                  fontSize: h * 0.018,
                                  fontWeight: FontWeight.w400,
                                  color: pickColor.grey,
                                  fontFamily: 'Poppins',
                                )),
                          ],
                        ),
                        SizedBox(height: h * 0.01),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
