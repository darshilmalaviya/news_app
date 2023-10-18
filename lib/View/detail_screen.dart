// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Controller/get_x_controller.dart';
import 'package:news_app/Controller/search_controller.dart';
import '../Controller/videoPlayerWidget.dart';
import '../Services/Shared_pref_services/pref_service.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});

  GetCntrl getCntrl = Get.put(GetCntrl());
  SearchCntrl searchCntrl = Get.put(SearchCntrl());

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return GetBuilder<GetCntrl>(
      id: 'detail',
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
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
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Column(
              children: [
                Text(
                  getCntrl.categoryName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: h * 0.03,
                    fontFamily: 'Poppins',
                  ),
                ),
                Container(
                  height: h * 0.002,
                  width: getCntrl.categoryName.length * 8.5,
                  color: pickColor.blue,
                ),
              ],
            ),
            actions: [
              InkResponse(
                onTap: () async {
                  getCntrl.isIconChanged = !getCntrl.isIconChanged;
                  getCntrl.update(['detail']);
                  searchCntrl.savedList.insert(0, {
                    "categoryName": getCntrl.categoryName,
                    "assetType": getCntrl.extension,
                    "headLine": getCntrl.headLine,
                    "channelName": getCntrl.channelName,
                    "city": getCntrl.city,
                    "date": getCntrl.date,
                    "time": getCntrl.time,
                    "imgUrl": getCntrl.imgUrl,
                    "topic": getCntrl.topic,
                    "description": getCntrl.description,
                    'isSaved': true,
                  });
                  await searchCntrl.savedCollection
                      .doc('${PrefService.getString('docId')}')
                      .update({
                    "savedList": searchCntrl.savedList,
                  });
                  getCntrl.update(['detail']);
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
              SizedBox(width: w * 0.03),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h * 0.03),
                      Text(
                        getCntrl.headLine,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: h * 0.028,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: h * 0.015),
                      Text(
                        getCntrl.channelName,
                        style: TextStyle(
                          fontSize: h * 0.019,
                          fontWeight: FontWeight.w600,
                          color: pickColor.Detailgrey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        "${getCntrl.city}, ${getCntrl.date} ${getCntrl.time}",
                        style: TextStyle(
                          fontSize: h * 0.019,
                          fontWeight: FontWeight.w500,
                          color: pickColor.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: h * 0.015),
                      SizedBox(
                        height: h * 0.29,
                        width: w,
                        child: getCntrl.extension == 'mp4'
                            ? VideoPlayerWidget(
                                height: h * 0.29,
                                width: w,
                                showPlayPause: true,
                                video: getCntrl.imgUrl,
                                index: 0,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: CachedNetworkImage(
                                  imageUrl: getCntrl.imgUrl,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                      ),
                      SizedBox(height: h * 0.016),
                      Center(
                        child: Text(
                          getCntrl.topic,
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
                        getCntrl.description,
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
            ],
          ),
        );
      },
    );
  }
}
