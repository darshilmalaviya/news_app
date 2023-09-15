import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/color.dart';
import 'package:news_app/View/detail_screen.dart';
import '../Common/images.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> dataList = [
    {
      "Image": CommonImg.Monarc1,
      "Description":
          "Monarch population soars\n4,900 percent since last year\nin thrilling 2021 western\nmigration",
      "Type": "Top",
      "Place": "Gujarat, Surat",
      "Time": "Aug 04,2023",
    },
    {
      "Image": CommonImg.Russia2,
      "Description":
          "Russia Withdraws Portion Of\nTroops From Border With\nUkraine",
      "Type": "Politics",
      "Place": "Bihar, Patna",
      "Time": "Sep 04,2023",
    },
    {
      "Image": CommonImg.Isro3,
      "Description":
          "ISRO releases images of the\nEarth and Moon taken by\ncameras on board C.",
      "Type": "Scince",
      "Place": "Goa, Panji",
      "Time": "Jan 04,2023",
    },
    {
      "Image": CommonImg.Monarc1,
      "Description":
          "Monarch population soars\n4,900 percent since last year\nin thrilling 2021 western\nmigration",
      "Type": "Top",
      "Place": "Gujarat, Surat",
      "Time": "Feb 04,2023",
    },
  ];
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList.addAll(dataList); // Initialize the filtered list with all data
  }

  void filterData(String query) {
    filteredList.clear();
    for (final item in dataList) {
      if (item['Type'].toLowerCase().contains(query.toLowerCase()) ||
          item['Description'].toLowerCase().contains(query.toLowerCase()) ||
          item['Place'].toLowerCase().contains(query.toLowerCase()) ||
          item['Time'].toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(item);
      }
    }
    setState(() {}); // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: h * 0.055),
            Text(
              "Search",
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
                  controller: searchController,
                  onChanged: filterData,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Image.asset(
                      CommonImg.searchIconTextField,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        searchController.clear();
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
                  filteredList.isNotEmpty
                      ? SizedBox(
                          height: h * 0.74,
                          child: ListView.builder(
                            itemCount: filteredList.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = filteredList[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen(),
                                    ),
                                  );
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
                                        Container(
                                          height: h * 0.175,
                                          width: w * 0.35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                item['Image'],
                                              ),
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
                                              width: w * 0.55,
                                              child: Text(
                                                item["Description"],
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
                                              item["Type"],
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
                                                  width: w * 0.3,
                                                  child: Text(
                                                    item["Place"],
                                                    style: TextStyle(
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
                                                SizedBox(width: w * 0.02),
                                                Text(
                                                  item["Time"],
                                                  style: TextStyle(
                                                    fontSize: h * 0.016,
                                                    fontWeight: FontWeight.w400,
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
        ),
      ),
    );
  }
}
