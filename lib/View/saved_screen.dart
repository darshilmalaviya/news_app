// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Controller/get_x_controller.dart';
import 'package:news_app/Controller/search_controller.dart';
import 'package:news_app/Services/Shared_pref_services/pref_service.dart';
import 'package:news_app/View/detail_screen.dart';
import 'package:share_plus/share_plus.dart';
import '../Controller/videoPlayerWidget.dart';

class SavedScreen extends StatelessWidget {
  SavedScreen({super.key});

  GetCntrl getCntrl = Get.put(GetCntrl());
  SearchCntrl searchCntrl = Get.put(SearchCntrl());
  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      body: StreamBuilder(
        stream: getCntrl.saved.doc(PrefService.getString('docId')).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
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
                    GetBuilder<GetCntrl>(
                      id: 'saved',
                      builder: (controller) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                          child: ListView.builder(
                            itemCount: snapshot.data!['savedList'].length,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  getCntrl.categoryName =
                                      snapshot.data!['savedList'][index]
                                          ['categoryName'];
                                  getCntrl.headLine = snapshot
                                      .data!['savedList'][index]['headLine'];
                                  getCntrl.channelName = snapshot
                                      .data!['savedList'][index]['channelName'];
                                  getCntrl.city = snapshot.data!['savedList']
                                      [index]['city'];
                                  getCntrl.date = snapshot.data!['savedList']
                                      [index]['date'];
                                  getCntrl.time = snapshot.data!['savedList']
                                      [index]['time'];
                                  getCntrl.imgUrl = snapshot.data!['savedList']
                                      [index]['imgUrl'];
                                  getCntrl.topic = snapshot.data!['savedList']
                                      [index]['topic'];
                                  getCntrl.description = snapshot
                                      .data!['savedList'][index]['description'];
                                  getCntrl.extension = snapshot
                                      .data!['savedList'][index]['assetType'];
                                  Get.to(DetailScreen());
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: h * 0.02),
                                  child: SizedBox(
                                    height: h * 0.19,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: h * 0.18,
                                          width: w * 0.35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: snapshot.data!['savedList']
                                                        [index]['assetType'] !=
                                                    'mp4'
                                                ? CachedNetworkImage(
                                                    imageUrl: snapshot
                                                            .data!['savedList']
                                                        [index]['imgUrl'],
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  )
                                                : VideoPlayerWidget(
                                                    height: h,
                                                    width: w,
                                                    showPlayPause: false,
                                                    video: snapshot
                                                            .data!['savedList']
                                                        [index]['imgUrl'],
                                                    videoFrom: 'network',
                                                    index: index,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(width: w * 0.02),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: h * 0.11,
                                              width: w * 0.53,
                                              child: Text(
                                                snapshot.data!['savedList']
                                                        [index]['headLine'] ??
                                                    "",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
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
                                              snapshot.data!['savedList'][index]
                                                      ['channelName'] ??
                                                  "",
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
                                                  width: w * 0.25,
                                                  child: Text(
                                                    snapshot.data!['savedList']
                                                        [index]['city'],
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                  "${snapshot.data!['savedList'][index]['time']}",
                                                  style: TextStyle(
                                                    fontSize: h * 0.016,
                                                    fontWeight: FontWeight.w400,
                                                    color: pickColor.grey,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                SizedBox(width: w * 0.01),
                                                InkResponse(
                                                  onTap: () async {
                                                    searchCntrl.savedList
                                                        .removeAt(index);
                                                    await searchCntrl
                                                        .savedCollection
                                                        .doc(PrefService
                                                            .getString('docId'))
                                                        .update({
                                                      "savedList":
                                                          searchCntrl.savedList,
                                                    });
                                                    searchCntrl
                                                        .update(['saved']);
                                                  },
                                                  child: Icon(
                                                    snapshot.data!['savedList']
                                                                    [index]
                                                                ['isSaved'] ==
                                                            true
                                                        ? Icons.bookmark
                                                        : Icons
                                                            .bookmark_border_outlined,
                                                    color: Colors.grey,
                                                    size: h * 0.025,
                                                  ),
                                                ),
                                                SizedBox(width: w * 0.01),
                                                InkResponse(
                                                  onTap: () {
                                                    Share.share("");
                                                  },
                                                  child: Icon(
                                                    Icons.share,
                                                    color: Colors.grey,
                                                    size: h * 0.025,
                                                  ),
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
                        );
                      },
                    )
                  ],
                ),
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
