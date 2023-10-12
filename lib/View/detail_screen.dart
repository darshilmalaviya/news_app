// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Common/images.dart';
import 'package:news_app/Controller/get_x_controller.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});

  GetCntrl getCntrl = Get.put(GetCntrl());

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<GetCntrl>(
        id: 'detail',
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.04),
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
                  SizedBox(width: w * 0.27),
                  Center(
                    child: Text(
                      "Science",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: h * 0.03,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(width: w * 0.2),
                  GestureDetector(
                    onTap: () {
                      getCntrl.isIconChanged =
                          !getCntrl.isIconChanged; // Toggle the icon state
                      controller.update(['detail']);
                    },
                    child: getCntrl.isIconChanged
                        ? Icon(
                            Icons.bookmark,
                            size: h * 0.03,
                            color: Colors.grey,
                          )
                        : Icon(
                            Icons.bookmark_outline,
                            size: h * 0.03,
                            color: Colors.grey,
                          ),
                  ),
                  SizedBox(width: w * 0.02),
                  Icon(
                    Icons.share,
                    size: h * 0.03,
                    color: Colors.black,
                  ),
                ],
              ),
              Center(
                child: Container(
                  height: h * 0.002,
                  width: w * 0.2,
                  color: pickColor.blue,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: SizedBox(
                  height: h * 0.87,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h * 0.03),
                        Text(
                          "ISRO releases images of the Earth\nand Moon taken by cameras on board Chandrayaan-3\nspacecraft",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: h * 0.028,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: h * 0.015),
                        Text(
                          "The Hindu News",
                          style: TextStyle(
                            fontSize: h * 0.019,
                            fontWeight: FontWeight.w600,
                            color: pickColor.Detailgrey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          "Bengaluru, Aug10, 2023 11:01 am ",
                          style: TextStyle(
                            fontSize: h * 0.019,
                            fontWeight: FontWeight.w500,
                            color: pickColor.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: h * 0.015),
                        Container(
                          height: h * 0.29,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(CommonImg.MoonImg),
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.016),
                        Center(
                          child: Text(
                            "Chandrayaan-3 Mission",
                            style: TextStyle(
                              fontSize: h * 0.022,
                              fontWeight: FontWeight.w600,
                              color: pickColor.HinduNewsgrey,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.016),
                        Text(
                          "Chandrayaan-3 is successfully inserted into the lunar orbit. The orbit achieved is 164 km x 18074 km, as intended. The spacecraft is inserted into the translunar orbit. The orbit achieved is 288 km x 369328 km.",
                          style: TextStyle(
                            fontSize: h * 0.023,
                            fontWeight: FontWeight.w400,
                            color: pickColor.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: h * 0.010),
                        Text(
                          "The Indian Space Research Organisation (ISRO) has unveiled two pictures captured by the Chandrayaan-3 spacecraft. The initial image portrays Earth, captured through the perspective of the Lander Imager (LI) Camera.",
                          style: TextStyle(
                            fontSize: h * 0.023,
                            fontWeight: FontWeight.w400,
                            color: pickColor.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
