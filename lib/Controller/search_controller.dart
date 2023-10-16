import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchCntrl extends GetxController {
  List<Map<String, dynamic>> dataList = [];
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredList = [];
  List<Map<String, dynamic>> searchData = [];
  bool searchHasData = false;

  Future<List<Map<String, dynamic>>?> fetchFirestoreData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> documentData =
          document.data() as Map<String, dynamic>;
      dataList.add(documentData);
    }
    return dataList;
  }

  void search(String query) {
    searchData.clear();
    for (int i = 0; i < dataList.length; i++) {
      dataList[i]['subcategory'].forEach((e) {
        if (e['Name'].toLowerCase().contains(query.toLowerCase())) {
          searchData.add(dataList[i]['subcategory'][i]);
          print("SEARCH DATA--->${searchData}");
        }
      });
      update(['search']);
      update(['home']);
    }
  }

  void filterData(String query) {
    searchData = [];
    dataList.forEach((map) {
      map['subcategory'].forEach((e) {
        if (e['Name'].toString().toLowerCase().contains(query.toLowerCase())) {
          searchData.add(e /*['Data']*/);
          searchHasData = true;
          update(['search']);
        }
      });
    });

    print(searchData);
    update(['search']);
  }

  void drawerFilter({required String query, required int index}) {
    filteredList.clear();

    for (int i = 0; i < dataList.length; i++) {
      dataList[i]['subcategory'].forEach(
        (e) {
          if (e['Name'].toLowerCase() == query.toLowerCase()) {
            filteredList.add(dataList[i]);
          }
        },
      );
      update(['search']);
    }
  }

  void homeFilter({required String query}) {
    filteredList.clear();
    for (int i = 0; i < dataList.length; i++) {
      if (dataList[i]['category'].toLowerCase() == query.toLowerCase()) {
        filteredList.add(dataList[i]);
      }
      update(['home']);
    }
  }

  data() async {
    await fetchFirestoreData();
    filteredList.addAll(dataList);
    searchData.addAll(dataList);
    Get.forceAppUpdate();
  }

  @override
  void onInit() {
    super.onInit();
    data();
  }
}
