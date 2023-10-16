// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Controller/get_x_controller.dart';
import 'package:video_player/video_player.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});

  GetCntrl getCntrl = Get.put(GetCntrl());

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
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
              width: w * 0.2,
              color: pickColor.blue,
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              getCntrl.isIconChanged =
                  !getCntrl.isIconChanged; // Toggle the icon state
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
      body: GetBuilder<GetCntrl>(
        id: 'detail',
        builder: (controller) {
          if (getCntrl.extension == 'mp4') {
            getCntrl.VideoCntrl =
                VideoPlayerController.networkUrl(Uri.parse(getCntrl.imgUrl))
                  ..initialize().then((_) {});
          }

          // void _toggleVideo() {
          //   if (getCntrl.VideoCntrl!.value.isPlaying) {
          //     getCntrl.VideoCntrl!.pause();
          //   } else {
          //     getCntrl.VideoCntrl!.play();
          //   }
          // }

          return Column(
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
                            ? Stack(
                                children: [
                                  VideoPlayer(getCntrl.VideoCntrl!),
                                  Positioned(
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          // _toggleVideo();
                                          getCntrl.VideoCntrl!.play();
                                          getCntrl.update(['detail']);
                                        },
                                        child: CircleAvatar(
                                          maxRadius: 20,
                                          child: getCntrl
                                                  .VideoCntrl!.value.isPlaying
                                              ? const Icon(Icons.pause)
                                              : const Icon(Icons.play_arrow),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
          );
        },
      ),
    );
  }
}
