import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/get_x_controller.dart';

class SearchCntrl extends GetxController {
  List<Map<String, dynamic>> dataList = [];
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredList = [];
  List<Map<String, dynamic>> searchData = [];

  Future<List<Map<String, dynamic>>?> fetchFirestoreData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> documentData =
          document.data() as Map<String, dynamic>;
      dataList.add(documentData);
    }
    print(dataList);
    return dataList;
  }

  void search(String query) {
    searchData.clear();
    for (final item in dataList) {
      for (int i = 0; i < dataList.length; i++) {
        dataList[i]['subcategory'].forEach((e) {
          if (e['Name'].toLowerCase() == query.toLowerCase()) {
            searchData.add(dataList[i]);
          }
        });
        update(['search']);
        update(['home']);
      }
    }
  }

  void filterData({required String query, required int index}) {
    filteredList.clear();
    if (query == 'For You') {
      filteredList.addAll(dataList);
      update(['home']);
    } else {
      for (int i = 0; i < dataList.length; i++) {
        dataList[i]['subcategory'].forEach((e) {
          if (e['Name'].toLowerCase() == query.toLowerCase()) {
            filteredList.add(dataList[i]);
          }
        });
        update(['search']);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFirestoreData();
    filterData(query: 'For You', index: 0);
    filteredList.addAll(dataList);
    searchData.addAll(dataList);
  }
}
