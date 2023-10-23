// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Controller/get_x_controller.dart';
import 'package:news_app/Controller/search_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  GetCntrl getCntrl = Get.put(GetCntrl());
  SearchCntrl searchCntrl = Get.put(SearchCntrl());
  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text(
              "Notifications",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: h * 0.03,
                fontFamily: 'Poppins',
              ),
            ),
            Container(
              height: h * 0.002,
              width: w * 0.32,
              color: colorRes.blue,
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: h * 0.03,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: getCntrl.Users.orderBy('DateTime').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data['subcategory'].length,
                          itemBuilder: (context, index1) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 25),
                                Row(
                                  children: [
                                    Text(
                                      data['subcategory'][index1]['Data']
                                          ['ChannelName'],
                                      style: TextStyle(
                                        fontSize: h * 0.019,
                                        fontWeight: FontWeight.w400,
                                        color: colorRes.grey,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    const Spacer(),
                                    index == 0
                                        ? Container(
                                            width: w * 0.12,
                                            height: h * 0.025,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              color: colorRes.blue,
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
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                                SizedBox(height: h * 0.01),
                                Container(
                                  height: h * 0.14,
                                  width: w * 1,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: colorRes.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: w * 0.02),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: h * 0.02),
                                        Text(
                                          data['subcategory'][index1]['Data']
                                              ['HeadLine'],
                                          style: TextStyle(
                                            fontSize: h * 0.017,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                          ),
                                          maxLines: 3,
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Text(
                                              data['subcategory'][index1]
                                                  ['Name'],
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w500,
                                                fontSize: h * 0.016,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            SizedBox(width: w * 0.04),
                                            const CircleAvatar(
                                              maxRadius: 4,
                                              backgroundColor: colorRes.grey,
                                            ),
                                            SizedBox(width: w * 0.04),
                                            Text(
                                              data['subcategory'][index1]
                                                  ['Data']['Time'],
                                              style: TextStyle(
                                                fontSize: h * 0.018,
                                                fontWeight: FontWeight.w400,
                                                color: colorRes.grey,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: h * 0.01),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: h * 0.025),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
