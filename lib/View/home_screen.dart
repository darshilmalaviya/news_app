// ignore_for_file: non_constant_identifier_names, must_be_immutable

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
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> data =
                                          snapshot.data!.docs[index].data()
                                              as Map<String, dynamic>;
                                      return Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: GestureDetector(
                                          onTap: () {
                                            data['subcategory'].length == 0
                                                ? getCntrl.subCatHasData = true
                                                : getCntrl.subCatHasData =
                                                    false;

                                            for (int i = 0;
                                                i <
                                                    getCntrl
                                                        .showDropDown.length;
                                                i++) {
                                              if (i != index) {
                                                if (getCntrl.showDropDown[i] ==
                                                    true) {
                                                  getCntrl.showDropDown[i] =
                                                      false;
                                                }
                                              }
                                            }
                                            if (getCntrl.showDropDown[index] ==
                                                true) {
                                              getCntrl.showDropDown[index] =
                                                  false;
                                            } else {
                                              getCntrl.showDropDown[index] =
                                                  true;
                                            }
                                            getCntrl.update(['home']);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: h * 0.015),
                                              Row(
                                                children: [
                                                  Text(
                                                    data['category'],
                                                    style: TextStyle(
                                                      fontSize: h * 0.019,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          getCntrl.showDropDown[
                                                                      index] ==
                                                                  true
                                                              ? Colors.black
                                                              : pickColor.grey,
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
                                              SizedBox(height: h * 0.015),
                                              const Divider(
                                                height: 1,
                                                color: pickColor.blue,
                                              ),
                                              getCntrl.showDropDown[index] ==
                                                      true
                                                  ? Container(
                                                      width: w * 0.8,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: pickColor.blue,
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
                                                                      child:
                                                                          Text(
                                                                        "No subcategory found",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              pickColor.grey,
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
                                                              : ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const BouncingScrollPhysics(),
                                                                  itemCount: snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                          [
                                                                          'subcategory']
                                                                      .length,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
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
                                                                            ? const Color(0xffcce1fd)
                                                                            : Colors.transparent,
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(height: h * 0.015),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(
                                                                                left: w * 0.05,
                                                                              ),
                                                                              child: Text(
                                                                                data['subcategory'][index]['Name'],
                                                                                style: TextStyle(
                                                                                  color: pickColor.grey,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  fontSize: h * 0.019,
                                                                                  fontFamily: 'Poppins',
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: h * 0.015),
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
                ),
                appBar: AppBar(
                  toolbarHeight: h * 0.08,
                  leading: IconButton(
                    onPressed: () {
                      getCntrl.scaffoldKey.currentState!.openDrawer();
                    },
                    icon: const Icon(Icons.menu, color: Colors.black),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: const Text(
                    "Daily news",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
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
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: h * 0.03,
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
                                          height: h * 0.03,
                                          margin:
                                              EdgeInsets.only(right: w * 0.03),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            color: getCntrl.categories1 == index
                                                ? pickColor.blue
                                                : Colors.white,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: w * 0.03),
                                              child: Text(
                                                data['category'],
                                                style: getCntrl.categories1 ==
                                                        index
                                                    ? TextStyle(
                                                        fontSize: h * 0.018,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                      )
                                                    : TextStyle(
                                                        fontSize: h * 0.018,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: pickColor.grey,
                                                        fontFamily: 'Poppins',
                                                      ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                );
                              },
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: h * 0.01),
                            const Divider(
                              height: 1,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: h * 0.76,
                              child: searchCntrl.filteredList.isNotEmpty
                                  ? getCntrl.isTapCategory
                                      ? ListView.builder(
                                          itemCount:
                                              searchCntrl.filteredList.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final item =
                                                searchCntrl.filteredList[index];
                                            return GestureDetector(
                                              onTap: () {
                                                getCntrl.categoryName = item[
                                                            'subcategory']
                                                        [getCntrl.DropDownColor]
                                                    ['Name'];
                                                getCntrl.headLine = item[
                                                            'subcategory']
                                                        [getCntrl.DropDownColor]
                                                    ['Data']['HeadLine'];
                                                getCntrl.channelName = item[
                                                            'subcategory']
                                                        [getCntrl.DropDownColor]
                                                    ['Data']['ChannelName'];
                                                getCntrl
                                                    .city = item['subcategory']
                                                        [getCntrl.DropDownColor]
                                                    ['Data']['City'];
                                                getCntrl
                                                    .date = item['subcategory']
                                                        [getCntrl.DropDownColor]
                                                    ['Data']['Date'];
                                                getCntrl
                                                    .time = item['subcategory']
                                                        [getCntrl.DropDownColor]
                                                    ['Data']['Time'];
                                                getCntrl.imgUrl = item[
                                                            'subcategory']
                                                        [getCntrl.DropDownColor]
                                                    ['Data']['ImageUrl'];
                                                getCntrl
                                                    .topic = item['subcategory']
                                                        [getCntrl.DropDownColor]
                                                    ['Data']['Topic'];
                                                getCntrl.description = item[
                                                            'subcategory']
                                                        [getCntrl.DropDownColor]
                                                    ['Data']['Description'];
                                                Get.to(DetailScreen());
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: h * 0.02),
                                                child: SizedBox(
                                                  height: h * 0.19,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: h * 0.175,
                                                        width: w * 0.35,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          child: item['subcategory']
                                                                              [getCntrl.DropDownColor]
                                                                          [
                                                                          'Data']
                                                                      [
                                                                      'AssetType'] !=
                                                                  'mp4'
                                                              ? CachedNetworkImage(
                                                                  imageUrl: item[
                                                                              'subcategory']
                                                                          [
                                                                          getCntrl
                                                                              .DropDownColor]['Data']['ImageUrl'] ??
                                                                      "",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const Center(
                                                                          child:
                                                                              CircularProgressIndicator()),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .error),
                                                                )
                                                              : VideoPlayerWidget(
                                                                  height:
                                                                      h * 0.18,
                                                                  width:
                                                                      w * 0.35,
                                                                  video: item['subcategory'][getCntrl.DropDownColor]
                                                                              [
                                                                              'Data']
                                                                          [
                                                                          'ImageUrl'] ??
                                                                      "",
                                                                ),
                                                        ),
                                                      ),
                                                      SizedBox(width: w * 0.02),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: h * 0.11,
                                                            width: w * 0.53,
                                                            child: Text(
                                                              item['subcategory']
                                                                              [getCntrl.DropDownColor]
                                                                          [
                                                                          'Data']
                                                                      [
                                                                      'HeadLine'] ??
                                                                  "",
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    h * 0.018,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: h * 0.01),
                                                          Text(
                                                            item['subcategory'][
                                                                        getCntrl
                                                                            .DropDownColor]
                                                                    ['Name'] ??
                                                                "",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  h * 0.017,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: pickColor
                                                                  .grey,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: h * 0.01),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: w * 0.27,
                                                                child: Text(
                                                                  item['subcategory'][getCntrl.DropDownColor]
                                                                              [
                                                                              'Data']
                                                                          [
                                                                          'City'] ??
                                                                      "",
                                                                  style:
                                                                      TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize: h *
                                                                        0.017,
                                                                    fontFamily:
                                                                        'Poppins',
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
                                                                item['subcategory']
                                                                        [
                                                                        getCntrl
                                                                            .DropDownColor]
                                                                    [
                                                                    'Data']['Time'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      h * 0.016,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      pickColor
                                                                          .grey,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      w * 0.01),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller
                                                                      .update([
                                                                    'home'
                                                                  ]);
                                                                },
                                                                child:
                                                                    InkResponse(
                                                                  onTap:
                                                                      () async {
                                                                    if (searchCntrl
                                                                            .isSaved[index] ==
                                                                        true) {
                                                                      searchCntrl
                                                                              .isSaved[index] =
                                                                          false;
                                                                      searchCntrl.saved(item['subcategory'][index]
                                                                              [
                                                                              'Data']
                                                                          [
                                                                          'HeadLine']);
                                                                    } else {
                                                                      searchCntrl
                                                                              .isSaved[index] =
                                                                          true;
                                                                      searchCntrl
                                                                          .savedList
                                                                          .insert(
                                                                              0,
                                                                              {
                                                                            "categoryName":
                                                                                item['subcategory'][getCntrl.DropDownColor]['Name'],
                                                                            "assetType":
                                                                                item['subcategory'][getCntrl.DropDownColor]['Data']['AssetType'],
                                                                            "headLine":
                                                                                item['subcategory'][getCntrl.DropDownColor]['Data']['HeadLine'],
                                                                            "channelName":
                                                                                item['subcategory'][getCntrl.DropDownColor]['Data']['ChannelName'],
                                                                            "city":
                                                                                item['subcategory'][getCntrl.DropDownColor]['Data']['City'],
                                                                            "date":
                                                                                item['subcategory'][getCntrl.DropDownColor]['Data']['Date'],
                                                                            "time":
                                                                                item['subcategory'][getCntrl.DropDownColor]['Data']['Time'],
                                                                            "imgUrl":
                                                                                item['subcategory'][getCntrl.DropDownColor]['Data']['ImageUrl'],
                                                                            "topic":
                                                                                item['subcategory'][getCntrl.DropDownColor]['Data']['Topic'],
                                                                            "description":
                                                                                item['subcategory'][getCntrl.DropDownColor]['Data']['Description'],
                                                                            'isSaved':
                                                                                true,
                                                                          });
                                                                      await searchCntrl
                                                                          .savedCollection
                                                                          .doc(
                                                                              '${PrefService.getString('docId')}')
                                                                          .update({
                                                                        "savedList":
                                                                            searchCntrl.savedList,
                                                                      });
                                                                    }
                                                                    searchCntrl
                                                                        .update([
                                                                      'home'
                                                                    ]);
                                                                  },
                                                                  child: Icon(
                                                                    searchCntrl.isSaved[index] ==
                                                                            true
                                                                        ? Icons
                                                                            .bookmark
                                                                        : Icons
                                                                            .bookmark_outline,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: h *
                                                                        0.025,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      w * 0.01),
                                                              Icon(
                                                                Icons.share,
                                                                color:
                                                                    Colors.grey,
                                                                size: h * 0.025,
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
                                          itemCount:
                                              searchCntrl.filteredList.length,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            final item =
                                                searchCntrl.filteredList[index];
                                            return ListView.builder(
                                              itemCount: searchCntrl
                                                  .filteredList[index]
                                                      ['subcategory']
                                                  .length,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index1) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    getCntrl.categoryName =
                                                        item['subcategory']
                                                            [index1]['Name'];
                                                    getCntrl.headLine =
                                                        item['subcategory']
                                                                [index1]['Data']
                                                            ['HeadLine'];
                                                    getCntrl.channelName =
                                                        item['subcategory']
                                                                [index1]['Data']
                                                            ['ChannelName'];
                                                    getCntrl.city =
                                                        item['subcategory']
                                                                [index1]['Data']
                                                            ['City'];
                                                    getCntrl.date =
                                                        item['subcategory']
                                                                [index1]['Data']
                                                            ['Date'];
                                                    getCntrl.time =
                                                        item['subcategory']
                                                                [index1]['Data']
                                                            ['Time'];
                                                    getCntrl.imgUrl =
                                                        item['subcategory']
                                                                [index1]['Data']
                                                            ['ImageUrl'];
                                                    getCntrl.topic =
                                                        item['subcategory']
                                                                [index1]['Data']
                                                            ['Topic'];
                                                    getCntrl.description =
                                                        item['subcategory']
                                                                [index1]['Data']
                                                            ['Description'];
                                                    getCntrl.extension =
                                                        item['subcategory']
                                                                [index1]['Data']
                                                            ['AssetType'];
                                                    Get.to(DetailScreen());
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.02),
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
                                                            height: h * 0.18,
                                                            width: w * 0.35,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                              child: item['subcategory'][index1]
                                                                              [
                                                                              'Data']
                                                                          [
                                                                          'AssetType'] !=
                                                                      'mp4'
                                                                  ? CachedNetworkImage(
                                                                      imageUrl: item['subcategory'][index1]
                                                                              [
                                                                              'Data']
                                                                          [
                                                                          'ImageUrl'],
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          const Center(
                                                                              child: CircularProgressIndicator()),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          const Icon(
                                                                              Icons.error),
                                                                    )
                                                                  : VideoPlayerWidget(
                                                                      height: h *
                                                                          0.18,
                                                                      width: w *
                                                                          0.35,
                                                                      showPlayPause:
                                                                          false,
                                                                      video: item['subcategory'][index1]
                                                                              [
                                                                              'Data']
                                                                          [
                                                                          'ImageUrl'],
                                                                      videoFrom:
                                                                          'network',
                                                                      index:
                                                                          index1,
                                                                    ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: w * 0.02),
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
                                                                width: w * 0.53,
                                                                child: Text(
                                                                  item['subcategory']
                                                                              [
                                                                              index1]
                                                                          [
                                                                          'Data']
                                                                      [
                                                                      'HeadLine'],
                                                                  maxLines: 3,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: h *
                                                                        0.018,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      h * 0.01),
                                                              Text(
                                                                item['subcategory']
                                                                        [index1]
                                                                    ['Name'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      h * 0.017,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      pickColor
                                                                          .grey,
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
                                                                    width: w *
                                                                        0.25,
                                                                    child: Text(
                                                                      item['subcategory'][index1]
                                                                              [
                                                                              'Data']
                                                                          [
                                                                          'City'],
                                                                      style:
                                                                          TextStyle(
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontSize:
                                                                            h * 0.017,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  CircleAvatar(
                                                                    maxRadius:
                                                                        h * 0.005,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .grey,
                                                                  ),
                                                                  SizedBox(
                                                                      width: w *
                                                                          0.01),
                                                                  Text(
                                                                    item['subcategory'][index1]
                                                                            [
                                                                            'Data']
                                                                        [
                                                                        'Time'],
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize: h *
                                                                          0.016,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: pickColor
                                                                          .grey,
                                                                      fontFamily:
                                                                          'Poppins',
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: w *
                                                                          0.01),
                                                                  InkResponse(
                                                                    onTap:
                                                                        () async {
                                                                      if (searchCntrl
                                                                              .isSaved[index] ==
                                                                          true) {
                                                                        searchCntrl.isSaved[index] =
                                                                            searchCntrl.save;
                                                                        searchCntrl.saved(item['subcategory'][index1]['Data']
                                                                            [
                                                                            'HeadLine']);
                                                                      } else {
                                                                        searchCntrl.isSaved[index] =
                                                                            searchCntrl.save;
                                                                        searchCntrl
                                                                            .savedList
                                                                            .insert(
                                                                                0,
                                                                                {
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
                                                                        await searchCntrl
                                                                            .savedCollection
                                                                            .doc('${PrefService.getString('docId')}')
                                                                            .update({
                                                                          "savedList":
                                                                              searchCntrl.savedList,
                                                                        });
                                                                      }
                                                                      searchCntrl
                                                                          .update([
                                                                        'home'
                                                                      ]);
                                                                    },
                                                                    child: Icon(
                                                                      searchCntrl.isSaved[index1] ==
                                                                              true
                                                                          ? Icons
                                                                              .bookmark
                                                                          : Icons
                                                                              .bookmark_border_outlined,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: h *
                                                                          0.025,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: w *
                                                                          0.01),
                                                                  InkResponse(
                                                                    onTap: () {
                                                                      Share.share(
                                                                          "${item['subcategory'][index1]['Data']['HeadLine']}\n"
                                                                          "${item['subcategory'][index1]['Data']['ImageUrl']}");
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .share,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: h *
                                                                          0.025,
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
                                        "No Data Found",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
