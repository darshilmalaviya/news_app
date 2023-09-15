// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Common/images.dart';
import 'package:news_app/View/detail_screen.dart';
import 'package:news_app/View/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int categories1 = 0;
  List<String> Name = [
    "Politics",
    "Health",
    "Economy",
    "Education",
    "Science",
    "Technology",
    "Entertainment",
    "Multimedia",
    "Life style",
    "Business",
  ];
  int select = 0;

  List Categery = [
    "For You",
    "Top",
    "World",
    "Politics",
    "Entertainment",
  ];
  List Img = [
    CommonImg.Monarc1,
    CommonImg.Russia2,
    CommonImg.Isro3,
    CommonImg.Monarc1,
  ];
  List Description = [
    "Monarch population soars\n4,900 percent since last year\nin thrilling 2021 western\nmigration",
    "Russia Withdraws Portion Of\nTroops From Border With\nUkraine",
    "ISRO releases images of the\nEarth and Moon taken by\ncameras on board C.",
    "Monarch population soars\n4,900 percent since last year\nin thrilling 2021 western\nmigration",
  ];
  List type = [
    "Top",
    "Politics",
    "Scince",
    "Top",
  ];
  List Place = [
    "Gujarat, Surat",
    "Bihar, Patna",
    "Goa, Panji",
    "Gujarat, Surat",
  ];
  List<String> DropDown = [
    "Cricket",
    "Football",
    "Badminton",
    "Kabaddi",
    "Basketball",
    "Other",
  ];
  bool bookMark = false;
  List<bool> showDropDown = List.generate(10, (index) => false);
  List<bool> BookMark = List.generate(4, (index) => false);
  int DropDownColor = 0;
  String? ingredient;
  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
          ),
        ),
        elevation: 0,
        child: Column(
          children: [
            SizedBox(height: h * 0.1),
            Center(
              child: Image.asset(
                CommonImg.smallLogo,
                height: h * 0.04,
                width: w * 0.3,
              ),
            ),
            Center(
              child: Container(
                width: w * 0.13,
                height: h * 0.002,
                color: pickColor.blue,
              ),
            ),
            SizedBox(height: h * 0.06),
            Container(
              height: h * 0.055,
              decoration: const BoxDecoration(
                color: pickColor.blue,
              ),
            ),
            SizedBox(height: h * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.015),
                  Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: h * 0.019,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: h * 0.015),
                  const Divider(
                    height: 1,
                    color: pickColor.blue,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: SizedBox(
                      height: h * 0.6,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: Name.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (int i = 0;
                                      i < showDropDown.length;
                                      i++) {
                                    if (i != index) {
                                      if (showDropDown[i] == true) {
                                        showDropDown[i] = false;
                                      }
                                    }
                                  }
                                  if (showDropDown[index] == true) {
                                    showDropDown[index] = false;
                                  } else {
                                    showDropDown[index] = true;
                                  }
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: h * 0.015),
                                  Row(
                                    children: [
                                      Text(
                                        Name[index],
                                        style: TextStyle(
                                          fontSize: h * 0.019,
                                          fontWeight: FontWeight.w500,
                                          color: showDropDown[index] == true
                                              ? Colors.black
                                              : pickColor.grey,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      const Spacer(),
                                      showDropDown[index] == true
                                          ? const Icon(
                                              Icons.keyboard_arrow_up,
                                            )
                                          : const Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                            ),
                                    ],
                                  ),
                                  SizedBox(height: h * 0.015),
                                  const Divider(
                                    height: 1,
                                    color: pickColor.blue,
                                  ),
                                  showDropDown[index] == true
                                      ? Container(
                                          height: h * 0.335,
                                          width: w * 0.8,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: pickColor.blue,
                                            ),
                                          ),
                                          child: ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: DropDown.length,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    DropDownColor = index;
                                                  });
                                                },
                                                child: Container(
                                                  color: DropDownColor == index
                                                      ? const Color(0xffcce1fd)
                                                      : Colors.transparent,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                          height: h * 0.015),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: w * 0.05,
                                                        ),
                                                        child: Text(
                                                          DropDown[index],
                                                          style: TextStyle(
                                                            color:
                                                                pickColor.grey,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: h * 0.019,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: h * 0.015),
                                                      const Divider(
                                                        thickness: 1,
                                                        height: 1,
                                                        color: pickColor.blue,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: h * 0.08,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          CommonImg.smallLogo,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            child: Image.asset(
              CommonImg.notification,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.02),
              child: SizedBox(
                height: h * 0.03,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Categery.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          categories1 = index;
                        });
                      },
                      child: Container(
                        height: h * 0.03,
                        margin: EdgeInsets.only(left: w * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: categories1 == index
                              ? pickColor.blue
                              : Colors.white,
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                            child: Text(
                              Categery[index],
                              style: categories1 == index
                                  ? TextStyle(
                                      fontSize: h * 0.018,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    )
                                  : TextStyle(
                                      fontSize: h * 0.018,
                                      fontWeight: FontWeight.w500,
                                      color: pickColor.grey,
                                      fontFamily: 'Poppins',
                                    ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                children: [
                  SizedBox(height: h * 0.01),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: h * 0.76,
                    child: ListView.builder(
                      itemCount: Img.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
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
                          child: Padding(
                            padding: EdgeInsets.only(top: h * 0.02),
                            child: SizedBox(
                              height: h * 0.18,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: h * 0.175,
                                    width: w * 0.35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          Img[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: w * 0.02),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: h * 0.1,
                                        width: w * 0.55,
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
                                            child: Icon(
                                              BookMark[index] == true
                                                  ? Icons.bookmark
                                                  : Icons
                                                      .bookmark_border_outlined,
                                              color: Colors.grey,
                                              size: w * 0.044,
                                            ),
                                          ),
                                          SizedBox(width: w * 0.01),
                                          Icon(
                                            Icons.share,
                                            color: Colors.grey,
                                            size: w * 0.044,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
