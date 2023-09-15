// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/View/detail_screen.dart';

import '../Common/images.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List Img = [
    CommonImg.Monarc1,
    CommonImg.Russia2,
  ];
  List Description = [
    "Monarch population soars\n4,900 percent since last year\nin thrilling 2021 western\nmigration",
    "Russia Withdraws Portion Of\nTroops From Border With\nUkraine",
  ];
  List type = [
    "Top",
    "Politics",
  ];
  List Place = [
    "Gujarat, Surat",
    "Bihar, Patna",
  ];
  List<bool> BookMark = List.generate(2, (index) => false);
  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.02),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: h * 0.05),
              Text(
                "Saved",
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
                  width: w * 0.17,
                  color: pickColor.blue,
                ),
              ),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: Img.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 25),
                          height: h * 0.175,
                          width: w * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(
                                Img[index],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: h * 0.1,
                                width: w * 0.54,
                                child: Text(
                                  Description[index],
                                  style: TextStyle(
                                    fontSize: h * 0.018,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              SizedBox(height: h * 0.01),
                              Text(
                                type[index],
                                style: TextStyle(
                                  fontSize: h * 0.017,
                                  fontWeight: FontWeight.w400,
                                  color: pickColor.grey,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(height: h * 0.01),
                              Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.27,
                                    child: Text(
                                      Place[index],
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: h * 0.017,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    maxRadius: h * 0.005,
                                    backgroundColor: Colors.grey,
                                  ),
                                  SizedBox(width: w * 0.01),
                                  Text(
                                    "1m ago",
                                    style: TextStyle(
                                      fontSize: h * 0.016,
                                      fontWeight: FontWeight.w400,
                                      color: pickColor.grey,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  SizedBox(width: w * 0.01),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (BookMark[index] == true) {
                                          BookMark[index] = false;
                                        } else {
                                          BookMark[index] = true;
                                        }
                                      });
                                    },
                                    child: BookMark[index] == true
                                        ? Icon(
                                            Icons.bookmark_outline,
                                            color: Colors.grey,
                                            size: w * 0.05,
                                          )
                                        : Icon(
                                            Icons.bookmark,
                                            color: Colors.grey,
                                            size: w * 0.05,
                                          ),
                                  ),
                                  SizedBox(width: w * 0.01),
                                  Icon(
                                    Icons.share,
                                    color: Colors.grey,
                                    size: w * 0.05,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
