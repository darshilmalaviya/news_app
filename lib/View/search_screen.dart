// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/Controller/get_x_controller.dart';
import 'package:news_app/Controller/search_controller.dart';
import 'package:news_app/View/detail_screen.dart';
import '../Common/images.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  SearchCntrl searchCntrl = Get.put(SearchCntrl());
  GetCntrl getCntrl = Get.put(GetCntrl());

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: GetBuilder<SearchCntrl>(
          id: 'search',
          builder: (controller) {
            return Column(
              children: [
                SizedBox(height: h * 0.055),
                Center(
                  child: Text(
                    "Search",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: h * 0.03,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: h * 0.002,
                    width: w * 0.2,
                    color: pickColor.blue,
                  ),
                ),
                SizedBox(height: h * 0.024),
                Container(
                  height: h * 0.06,
                  width: w * 0.92,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      6,
                    ),
                    color: pickColor.searchTextfield,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: h * 0.005),
                    child: TextField(
                      controller: searchCntrl.searchController,
                      onChanged: searchCntrl.searchFunc,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Image.asset(
                          CommonImg.searchIconTextField,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            searchCntrl.searchController.clear();
                            searchCntrl.update(['search']);
                          },
                          child: Image.asset(
                            CommonImg.cancleTextField,
                          ),
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          fontSize: h * 0.019,
                          fontWeight: FontWeight.w400,
                          color: pickColor.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                  child: Column(
                    children: [
                      searchCntrl.searchData.isNotEmpty
                          ? searchCntrl.searchHasData
                              ? ListView.builder(
                                  itemCount: searchCntrl.searchData.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemBuilder: (context, searchIndex) {
                                    final item =
                                        searchCntrl.searchData[searchIndex];
                                    return GestureDetector(
                                      onTap: () {
                                        getCntrl.categoryName = searchCntrl
                                            .searchData[searchIndex]['Name'];
                                        getCntrl.headLine =
                                            item['Data']['HeadLine'];
                                        getCntrl.channelName =
                                            item['Data']['ChannelName'];
                                        getCntrl.city = item['Data']['City'];
                                        getCntrl.date = item['Data']['Date'];
                                        getCntrl.time = item['Data']['Time'];
                                        getCntrl.imgUrl =
                                            item['Data']['ImageUrl'];
                                        getCntrl.topic = item['Data']['Topic'];
                                        getCntrl.description =
                                            item['Data']['Description'];
                                        Get.to(DetailScreen());
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: h * 0.02),
                                        child: SizedBox(
                                          height: h * 0.18,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: h * 0.175,
                                                width: w * 0.35,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  child: CachedNetworkImage(
                                                    imageUrl: item['Data']
                                                        ['ImageUrl'],
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
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
                                                    height: h * 0.1,
                                                    width: w * 0.54,
                                                    child: Text(
                                                      item['Data']['HeadLine'],
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: h * 0.018,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: h * 0.01),
                                                  Text(
                                                    "${searchCntrl.searchData[searchIndex]['Name']}",
                                                    style: TextStyle(
                                                      fontSize: h * 0.017,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: pickColor.grey,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                  SizedBox(height: h * 0.01),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: w * 0.29,
                                                        child: Text(
                                                          item['Data']['City'],
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: h * 0.017,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      ),
                                                      CircleAvatar(
                                                        maxRadius: h * 0.005,
                                                        backgroundColor:
                                                            Colors.grey,
                                                      ),
                                                      SizedBox(width: w * 0.02),
                                                      Text(
                                                        item['Data']['Time'],
                                                        style: TextStyle(
                                                          fontSize: h * 0.016,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: pickColor.grey,
                                                          fontFamily: 'Poppins',
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
                                )
                              : SizedBox(
                                  height: h * 0.74,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: searchCntrl.searchData.length,
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final item =
                                          searchCntrl.searchData[index];

                                      return ListView.builder(
                                        itemCount: searchCntrl
                                            .searchData[index]['subcategory']
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemBuilder: (context, searchIndex) {
                                          return GestureDetector(
                                            onTap: () {
                                              getCntrl.categoryName =
                                                  item['subcategory']
                                                      [searchIndex]['Name'];
                                              getCntrl.headLine =
                                                  item['subcategory']
                                                          [searchIndex]['Data']
                                                      ['HeadLine'];
                                              getCntrl.channelName =
                                                  item['subcategory']
                                                          [searchIndex]['Data']
                                                      ['ChannelName'];
                                              getCntrl.city =
                                                  item['subcategory']
                                                          [searchIndex]['Data']
                                                      ['City'];
                                              getCntrl.date =
                                                  item['subcategory']
                                                          [searchIndex]['Data']
                                                      ['Date'];
                                              getCntrl.time =
                                                  item['subcategory']
                                                          [searchIndex]['Data']
                                                      ['Time'];
                                              getCntrl.imgUrl =
                                                  item['subcategory']
                                                          [searchIndex]['Data']
                                                      ['ImageUrl'];
                                              getCntrl.topic =
                                                  item['subcategory']
                                                          [searchIndex]['Data']
                                                      ['Topic'];
                                              getCntrl.description =
                                                  item['subcategory']
                                                          [searchIndex]['Data']
                                                      ['Description'];
                                              Get.to(DetailScreen());
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: h * 0.02),
                                              child: SizedBox(
                                                height: h * 0.18,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: h * 0.175,
                                                      width: w * 0.35,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: item[
                                                                      'subcategory']
                                                                  [searchIndex][
                                                              'Data']['ImageUrl'],
                                                          fit: BoxFit.cover,
                                                          placeholder: (context,
                                                                  url) =>
                                                              const Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
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
                                                          height: h * 0.1,
                                                          width: w * 0.54,
                                                          child: Text(
                                                            item['subcategory'][
                                                                        searchIndex]
                                                                    ['Data']
                                                                ['HeadLine'],
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
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height: h * 0.01),
                                                        Text(
                                                          item['subcategory']
                                                                  [searchIndex]
                                                              ['Name'],
                                                          style: TextStyle(
                                                            fontSize: h * 0.017,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                pickColor.grey,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height: h * 0.01),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: w * 0.29,
                                                              child: Text(
                                                                item['subcategory']
                                                                            [
                                                                            searchIndex]
                                                                        ['Data']
                                                                    ['City'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
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
                                                                  Colors.grey,
                                                            ),
                                                            SizedBox(
                                                                width:
                                                                    w * 0.02),
                                                            Text(
                                                              item['subcategory']
                                                                      [
                                                                      searchIndex]
                                                                  [
                                                                  'Data']['Time'],
                                                              style: TextStyle(
                                                                fontSize:
                                                                    h * 0.016,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: pickColor
                                                                    .grey,
                                                                fontFamily:
                                                                    'Poppins',
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
                                  ),
                                )
                          : const Center(
                              child: Text(
                                "No data found",
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
