// ignore_for_file: non_constant_identifier_names, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Common/images.dart';
import 'package:news_app/Controller/get_x_controller.dart';
import 'package:news_app/Controller/search_controller.dart';
import 'package:news_app/Services/Shared_pref_services/pref_service.dart';
import 'package:news_app/View/detail_screen.dart';
import 'package:news_app/View/notification_screen.dart';
import 'package:share_plus/share_plus.dart';
import '../Controller/videoPlayerWidget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  GetCntrl getCntrl = Get.put(GetCntrl());
  SearchCntrl searchCntrl = Get.put(SearchCntrl());

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return GetBuilder<GetCntrl>(
      id: 'home',
      builder: (controller) {
        return StreamBuilder(
          stream: getCntrl.Users.orderBy("DateTime").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: Colors.white,
                key: getCntrl.scaffoldKey,
                drawer: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(20)),
                  child: Drawer(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                      ),
                    ),
                    elevation: 0,
                    child: Column(
                      children: [
                        SizedBox(height: h * 0.1),
                        const Center(
                          child: Text(
                            "Daily news",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: w * 0.34,
                            height: h * 0.002,
                            color: colorRes.blue,
                          ),
                        ),
                        SizedBox(height: h * 0.06),
                        Container(
                          height: h * 0.055,
                          decoration: const BoxDecoration(
                            color: colorRes.blue,
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
                                color: colorRes.blue,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: SizedBox(
                                  height: h * 0.6,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> data =
                                          snapshot.data!.docs[index].data()
                                              as Map<String, dynamic>;
                                      return Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: h * 0.015),
                                            GestureDetector(
                                              onTap: () {
                                                data['subcategory'].length == 0
                                                    ? getCntrl.subCatHasData =
                                                        true
                                                    : getCntrl.subCatHasData =
                                                        false;
                                                for (int i = 0;
                                                    i <
                                                        getCntrl.showDropDown
                                                            .length;
                                                    i++) {
                                                  if (i != index) {
                                                    if (getCntrl
                                                            .showDropDown[i] ==
                                                        true) {
                                                      getCntrl.showDropDown[i] =
                                                          false;
                                                    }
                                                  }
                                                }
                                                if (getCntrl
                                                        .showDropDown[index] ==
                                                    true) {
                                                  getCntrl.showDropDown[index] =
                                                      false;
                                                } else {
                                                  getCntrl.showDropDown[index] =
                                                      true;
                                                }
                                                getCntrl.update(['home']);
                                              },
                                              child: Container(
                                                height: h * 0.028,
                                                color: Colors.transparent,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      data['category'],
                                                      style: TextStyle(
                                                        fontSize: h * 0.019,
                                                        fontWeight:
                                                            getCntrl.showDropDown[
                                                                        index] ==
                                                                    true
                                                                ? FontWeight
                                                                    .w700
                                                                : FontWeight
                                                                    .w500,
                                                        color: Colors.black,
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    getCntrl.showDropDown[
                                                                index] ==
                                                            true
                                                        ? const Icon(
                                                            Icons
                                                                .keyboard_arrow_up,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .keyboard_arrow_down_sharp,
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: h * 0.015),
                                            const Divider(
                                              height: 1,
                                              color: colorRes.blue,
                                            ),
                                            getCntrl.showDropDown[index] == true
                                                ? Container(
                                                    width: w * 0.8,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: colorRes.blue,
                                                      ),
                                                    ),
                                                    child:
                                                        getCntrl.subCatHasData ==
                                                                true
                                                            ? SizedBox(
                                                                height:
                                                                    h * 0.06,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8),
                                                                    child: Text(
                                                                      "No subcategory found",
                                                                      style:
                                                                          TextStyle(
                                                                        color: colorRes
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontSize:
                                                                            h * 0.019,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    const BouncingScrollPhysics(),
                                                                itemCount: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                        [
                                                                        'subcategory']
                                                                    .length,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  int i = snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                              [
                                                                              'subcategory']
                                                                          .length -
                                                                      1;
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      getCntrl.isTapCategory =
                                                                          true;
                                                                      getCntrl.DropDownColor =
                                                                          index;
                                                                      searchCntrl.drawerFilter(
                                                                          index:
                                                                              index,
                                                                          query:
                                                                              data['subcategory'][index]['Name']);
                                                                      getCntrl
                                                                          .scaffoldKey
                                                                          .currentState!
                                                                          .openEndDrawer();
                                                                      getCntrl
                                                                          .update([
                                                                        'home'
                                                                      ]);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      color: getCntrl.DropDownColor ==
                                                                              index
                                                                          ? const Color(
                                                                              0xffcce1fd)
                                                                          : Colors
                                                                              .transparent,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                              height: h * 0.015),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              left: w * 0.05,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              data['subcategory'][index]['Name'],
                                                                              style: TextStyle(
                                                                                color: colorRes.grey,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: h * 0.019,
                                                                                fontFamily: 'Poppins',
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              height: h * 0.015),
                                                                          i == index || index == 0
                                                                              ? const SizedBox()
                                                                              : const Divider(
                                                                                  thickness: 1,
                                                                                  height: 1,
                                                                                  color: colorRes.blue,
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
                ),
                appBar: AppBar(
                  toolbarHeight: h * 0.1,
                  leading: IconButton(
                    onPressed: () {
                      getCntrl.scaffoldKey.currentState!.openDrawer();
                    },
                    icon:
                        Icon(Icons.menu, color: Colors.black, size: h * 0.035),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Text(
                    "Daily news",
                    style: TextStyle(
                      fontSize: h * 0.035,
                      color: colorRes.iconColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  actions: [
                    InkResponse(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
                      child: Image.asset(
                        CommonImg.notification,
                        height: h * 0.07,
                        width: w * 0.07,
                      ),
                    ),
                    SizedBox(width: w * 0.04),
                  ],
                ),
                body: Obx(() {
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  height: h * 0.04,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> data =
                                          snapshot.data!.docs[index].data()
                                              as Map<String, dynamic>;
                                      return GestureDetector(
                                        onTap: () {
                                          getCntrl.isTapCategory = false;
                                          getCntrl.categories1 = index;
                                          searchCntrl.homeFilter(
                                              query: data['category']);
                                          controller.update(['home']);
                                        },
                                        child: data['subcategory'] != null
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    right: w * 0.03),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          h * 0.3),
                                                  color: getCntrl.categories1 ==
                                                          index
                                                      ? colorRes.blue
                                                      : Colors.white,
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                w * 0.03),
                                                    child: Text(
                                                      data['category'],
                                                      style: getCntrl
                                                                  .categories1 ==
                                                              index
                                                          ? TextStyle(
                                                              fontSize:
                                                                  h * 0.02,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Poppins',
                                                            )
                                                          : TextStyle(
                                                              fontSize:
                                                                  h * 0.02,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  colorRes.grey,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(height: h * 0.02),
                                  const Divider(
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: h * 0.76,
                                    child: searchCntrl.isDataLoading
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : searchCntrl.filteredList.isNotEmpty
                                            ? getCntrl.isTapCategory
                                                ? ListView.builder(
                                                    itemCount: searchCntrl
                                                        .filteredList.length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.015,
                                                        bottom: h * 0.06),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final item = searchCntrl
                                                          .filteredList[index];
                                                      bool saved = false;
                                                      searchCntrl.savedList
                                                          .forEach((element) {
                                                        if (element[
                                                                'headLine'] ==
                                                            item['subcategory'][
                                                                        getCntrl
                                                                            .DropDownColor]
                                                                    ['Data']
                                                                ['HeadLine']) {
                                                          saved = true;
                                                        }
                                                      });
                                                      return GestureDetector(
                                                        onTap: () {
                                                          getCntrl.categoryName =
                                                              item['subcategory']
                                                                      [getCntrl
                                                                          .DropDownColor]
                                                                  ['Name'];
                                                          getCntrl
                                                              .headLine = item[
                                                                      'subcategory']
                                                                  [getCntrl
                                                                      .DropDownColor]
                                                              [
                                                              'Data']['HeadLine'];
                                                          getCntrl
                                                              .channelName = item[
                                                                      'subcategory']
                                                                  [getCntrl
                                                                      .DropDownColor]
                                                              [
                                                              'Data']['ChannelName'];
                                                          getCntrl.city = item[
                                                                      'subcategory']
                                                                  [getCntrl
                                                                      .DropDownColor]
                                                              ['Data']['City'];
                                                          getCntrl.date = item[
                                                                      'subcategory']
                                                                  [getCntrl
                                                                      .DropDownColor]
                                                              ['Data']['Date'];
                                                          getCntrl.time = item[
                                                                      'subcategory']
                                                                  [getCntrl
                                                                      .DropDownColor]
                                                              ['Data']['Time'];
                                                          getCntrl
                                                              .imgUrl = item[
                                                                      'subcategory']
                                                                  [getCntrl
                                                                      .DropDownColor]
                                                              [
                                                              'Data']['ImageUrl'];
                                                          getCntrl.topic = item[
                                                                      'subcategory']
                                                                  [getCntrl
                                                                      .DropDownColor]
                                                              ['Data']['Topic'];
                                                          getCntrl
                                                              .description = item[
                                                                      'subcategory']
                                                                  [getCntrl
                                                                      .DropDownColor]
                                                              [
                                                              'Data']['Description'];
                                                          getCntrl.isSaved1 =
                                                              saved;
                                                          Get.to(
                                                              DetailScreen());
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top:
                                                                      h * 0.02),
                                                          child: SizedBox(
                                                            height: h * 0.19,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  height:
                                                                      h * 0.18,
                                                                  width:
                                                                      w * 0.35,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: colorRes
                                                                            .border),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(7),
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                    child: item['subcategory'][getCntrl.DropDownColor]['Data']['AssetType'] !=
                                                                            'mp4'
                                                                        ? CachedNetworkImage(
                                                                            imageUrl:
                                                                                item['subcategory'][getCntrl.DropDownColor]['Data']['ImageUrl'],
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            placeholder: (context, url) =>
                                                                                const Center(child: CircularProgressIndicator()),
                                                                            errorWidget: (context, url, error) =>
                                                                                const Icon(Icons.error),
                                                                          )
                                                                        : VideoPlayerWidget(
                                                                            height:
                                                                                h * 0.18,
                                                                            width:
                                                                                w * 0.35,
                                                                            showPlayPause:
                                                                                false,
                                                                            video:
                                                                                item['subcategory'][getCntrl.DropDownColor]['Data']['ImageUrl'],
                                                                          ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: w *
                                                                        0.02),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height: h *
                                                                          0.11,
                                                                      width: w *
                                                                          0.53,
                                                                      child:
                                                                          Text(
                                                                        item['subcategory'][getCntrl.DropDownColor]['Data']
                                                                            [
                                                                            'HeadLine'],
                                                                        maxLines:
                                                                            3,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              h * 0.018,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          color:
                                                                              Colors.black,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height: h *
                                                                            0.01),
                                                                    Text(
                                                                      item['subcategory']
                                                                              [
                                                                              getCntrl.DropDownColor]
                                                                          [
                                                                          'Name'],
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            h * 0.017,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: colorRes
                                                                            .grey,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height: h *
                                                                            0.01),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              w * 0.24,
                                                                          child:
                                                                              Text(
                                                                            item['subcategory'][getCntrl.DropDownColor]['Data']['City'],
                                                                            style:
                                                                                TextStyle(
                                                                              overflow: TextOverflow.ellipsis,
                                                                              color: Colors.blue,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: h * 0.017,
                                                                              fontFamily: 'Poppins',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        CircleAvatar(
                                                                          maxRadius:
                                                                              h * 0.005,
                                                                          backgroundColor:
                                                                              Colors.grey,
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                w * 0.01),
                                                                        Text(
                                                                          item['subcategory'][getCntrl.DropDownColor]['Data']
                                                                              [
                                                                              'Time'],
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                h * 0.016,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                colorRes.grey,
                                                                            fontFamily:
                                                                                'Poppins',
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                w * 0.01),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            controller.update([
                                                                              'home'
                                                                            ]);
                                                                          },
                                                                          child:
                                                                              InkResponse(
                                                                            onTap:
                                                                                () async {
                                                                              searchCntrl.loader.value = true;
                                                                              if (saved == true) {
                                                                                int removeAt = 0;
                                                                                for (int i = 0; i < searchCntrl.savedList.length; i++) {
                                                                                  if (item['subcategory'][getCntrl.DropDownColor]['Data']['HeadLine'] == searchCntrl.savedList[i]['headLine']) {
                                                                                    removeAt = i;
                                                                                  }
                                                                                }
                                                                                searchCntrl.savedList.removeAt(removeAt);
                                                                                await searchCntrl.savedCollection.doc(PrefService.getString('docId')).update({
                                                                                  "savedList": searchCntrl.savedList,
                                                                                });
                                                                                searchCntrl.loader.value = false;
                                                                                getCntrl.update([
                                                                                  'home'
                                                                                ]);
                                                                              } else {
                                                                                searchCntrl.savedList.insert(0, {
                                                                                  "categoryName": item['subcategory'][getCntrl.DropDownColor]['Name'],
                                                                                  "assetType": item['subcategory'][getCntrl.DropDownColor]['Data']['AssetType'],
                                                                                  "headLine": item['subcategory'][getCntrl.DropDownColor]['Data']['HeadLine'],
                                                                                  "channelName": item['subcategory'][getCntrl.DropDownColor]['Data']['ChannelName'],
                                                                                  "city": item['subcategory'][getCntrl.DropDownColor]['Data']['City'],
                                                                                  "date": item['subcategory'][getCntrl.DropDownColor]['Data']['Date'],
                                                                                  "time": item['subcategory'][getCntrl.DropDownColor]['Data']['Time'],
                                                                                  "imgUrl": item['subcategory'][getCntrl.DropDownColor]['Data']['ImageUrl'],
                                                                                  "topic": item['subcategory'][getCntrl.DropDownColor]['Data']['Topic'],
                                                                                  "description": item['subcategory'][getCntrl.DropDownColor]['Data']['Description'],
                                                                                  'isSaved': true,
                                                                                });
                                                                                await searchCntrl.savedCollection.doc(PrefService.getString('docId')).update({
                                                                                  "savedList": searchCntrl.savedList,
                                                                                });
                                                                                searchCntrl.loader.value = false;
                                                                                getCntrl.update([
                                                                                  'home'
                                                                                ]);
                                                                              }
                                                                            },
                                                                            child:
                                                                                Image.asset(
                                                                              saved == true ? CommonImg.save : CommonImg.saveOutLined,
                                                                              height: h * 0.03,
                                                                              width: w * 0.05,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                w * 0.01),
                                                                        Icon(
                                                                          Icons
                                                                              .share,
                                                                          color:
                                                                              Colors.grey,
                                                                          size: h *
                                                                              0.025,
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
                                                  )
                                                : ListView.builder(
                                                    itemCount: searchCntrl
                                                        .filteredList.length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.015,
                                                        bottom: h * 0.06),
                                                    itemBuilder:
                                                        (context, index) {
                                                      final item = searchCntrl
                                                          .filteredList[index];
                                                      return ListView.builder(
                                                        itemCount: searchCntrl
                                                            .filteredList[index]
                                                                ['subcategory']
                                                            .length,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index1) {
                                                          bool saved = false;
                                                          searchCntrl.savedList
                                                              .forEach(
                                                                  (element) {
                                                            if (element[
                                                                    'headLine'] ==
                                                                item['subcategory']
                                                                            [
                                                                            index1]
                                                                        ['Data']
                                                                    [
                                                                    'HeadLine']) {
                                                              saved = true;
                                                            }
                                                          });
                                                          return GestureDetector(
                                                            onTap: () {
                                                              getCntrl.categoryName =
                                                                  item['subcategory']
                                                                          [
                                                                          index1]
                                                                      ['Name'];
                                                              getCntrl.headLine =
                                                                  item['subcategory']
                                                                              [
                                                                              index1]
                                                                          [
                                                                          'Data']
                                                                      [
                                                                      'HeadLine'];
                                                              getCntrl.channelName =
                                                                  item['subcategory']
                                                                              [
                                                                              index1]
                                                                          [
                                                                          'Data']
                                                                      [
                                                                      'ChannelName'];
                                                              getCntrl
                                                                  .city = item[
                                                                          'subcategory']
                                                                      [index1][
                                                                  'Data']['City'];
                                                              getCntrl
                                                                  .date = item[
                                                                          'subcategory']
                                                                      [index1][
                                                                  'Data']['Date'];
                                                              getCntrl
                                                                  .time = item[
                                                                          'subcategory']
                                                                      [index1][
                                                                  'Data']['Time'];
                                                              getCntrl.imgUrl =
                                                                  item['subcategory']
                                                                              [
                                                                              index1]
                                                                          [
                                                                          'Data']
                                                                      [
                                                                      'ImageUrl'];
                                                              getCntrl
                                                                  .topic = item[
                                                                          'subcategory']
                                                                      [index1][
                                                                  'Data']['Topic'];
                                                              getCntrl.description =
                                                                  item['subcategory']
                                                                              [
                                                                              index1]
                                                                          [
                                                                          'Data']
                                                                      [
                                                                      'Description'];
                                                              getCntrl.extension =
                                                                  item['subcategory']
                                                                              [
                                                                              index1]
                                                                          [
                                                                          'Data']
                                                                      [
                                                                      'AssetType'];
                                                              getCntrl.isSaved1 =
                                                                  saved;
                                                              Get.to(
                                                                  DetailScreen());
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: h *
                                                                          0.02),
                                                              child: SizedBox(
                                                                height:
                                                                    h * 0.19,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      height: h *
                                                                          0.18,
                                                                      width: w *
                                                                          0.35,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                colorRes.border),
                                                                        borderRadius:
                                                                            BorderRadius.circular(7),
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(6),
                                                                        child: item['subcategory'][index1]['Data']['AssetType'] !=
                                                                                'mp4'
                                                                            ? CachedNetworkImage(
                                                                                imageUrl: item['subcategory'][index1]['Data']['ImageUrl'],
                                                                                fit: BoxFit.cover,
                                                                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                              )
                                                                            : VideoPlayerWidget(
                                                                                height: h * 0.18,
                                                                                width: w * 0.35,
                                                                                showPlayPause: false,
                                                                                video: item['subcategory'][index1]['Data']['ImageUrl'],
                                                                                videoFrom: 'network',
                                                                                index: index1,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        width: w *
                                                                            0.02),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              h * 0.11,
                                                                          width:
                                                                              w * 0.53,
                                                                          child:
                                                                              Text(
                                                                            item['subcategory'][index1]['Data']['HeadLine'],
                                                                            maxLines:
                                                                                3,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: h * 0.018,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.black,
                                                                              fontFamily: 'Poppins',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                h * 0.01),
                                                                        Text(
                                                                          item['subcategory'][index1]
                                                                              [
                                                                              'Name'],
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                h * 0.017,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                colorRes.grey,
                                                                            fontFamily:
                                                                                'Poppins',
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                h * 0.01),
                                                                        Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: w * 0.24,
                                                                              child: Text(
                                                                                item['subcategory'][index1]['Data']['City'],
                                                                                style: TextStyle(
                                                                                  overflow: TextOverflow.ellipsis,
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
                                                                              item['subcategory'][index1]['Data']['Time'],
                                                                              style: TextStyle(
                                                                                fontSize: h * 0.016,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: colorRes.grey,
                                                                                fontFamily: 'Poppins',
                                                                              ),
                                                                            ),
                                                                            SizedBox(width: w * 0.01),
                                                                            InkResponse(
                                                                              onTap: () async {
                                                                                searchCntrl.loader.value = true;
                                                                                if (saved == true) {
                                                                                  int newsRemoveAt = 0;
                                                                                  for (int i = 0; i < searchCntrl.savedList.length; i++) {
                                                                                    if (searchCntrl.savedList[i]['headLine'] == item['subcategory'][index1]['Data']['HeadLine']) {
                                                                                      newsRemoveAt = i;
                                                                                    }
                                                                                  }
                                                                                  searchCntrl.savedList.removeAt(newsRemoveAt);
                                                                                  await searchCntrl.savedCollection.doc(PrefService.getString('docId')).update({
                                                                                    "savedList": searchCntrl.savedList,
                                                                                  });
                                                                                  searchCntrl.loader.value = false;
                                                                                  getCntrl.update([
                                                                                    'home'
                                                                                  ]);
                                                                                } else {
                                                                                  searchCntrl.savedList.insert(0, {
                                                                                    'assetType': item['subcategory'][index1]['Data']['AssetType'],
                                                                                    'channelName': item['subcategory'][index1]['Data']['ChannelName'],
                                                                                    'categoryName': item['subcategory'][index1]['Name'],
                                                                                    'city': item['subcategory'][index1]['Data']['City'],
                                                                                    'date': item['subcategory'][index1]['Data']['Date'],
                                                                                    'description': item['subcategory'][index1]['Data']['Description'],
                                                                                    'headLine': item['subcategory'][index1]['Data']['HeadLine'],
                                                                                    'imgUrl': item['subcategory'][index1]['Data']['ImageUrl'],
                                                                                    'state': item['subcategory'][index1]['Data']['State'],
                                                                                    'time': item['subcategory'][index1]['Data']['Time'],
                                                                                    'topic': item['subcategory'][index1]['Data']['Topic'],
                                                                                    'isSaved': true,
                                                                                  });
                                                                                  await searchCntrl.savedCollection.doc(PrefService.getString('docId')).update({
                                                                                    "savedList": searchCntrl.savedList,
                                                                                  });
                                                                                  searchCntrl.loader.value = false;
                                                                                  getCntrl.update([
                                                                                    'home'
                                                                                  ]);
                                                                                }
                                                                              },
                                                                              child: Image.asset(
                                                                                saved == true ? CommonImg.save : CommonImg.saveOutLined,
                                                                                height: h * 0.03,
                                                                                width: w * 0.05,
                                                                              ),
                                                                            ),
                                                                            SizedBox(width: w * 0.01),
                                                                            InkResponse(
                                                                              onTap: () {
                                                                                Share.share("${item['subcategory'][index1]['Data']['HeadLine']}\n"
                                                                                    "${item['subcategory'][index1]['Data']['ImageUrl']}");
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
                                                      );
                                                    },
                                                  )
                                            : const Center(
                                                child: Text(
                                                  "No news found",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      searchCntrl.loader.value
                          ? Center(
                              child: SizedBox(
                                  height: h * 0.05,
                                  width: w * 0.05,
                                  child: const Center(
                                      child: CircularProgressIndicator())),
                            )
                          : const SizedBox()
                    ],
                  );
                }),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
