// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Services/Shared_pref_services/pref_service.dart';

class SearchCntrl extends GetxController {
  List<Map<String, dynamic>> dataList = [];
  List<dynamic> savedList = [];
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredList = [];
  List<Map<String, dynamic>> searchData = [];
  List<bool> isSaved = [];
  bool isDataLoading = false;
  RxBool loader = false.obs;

  CollectionReference savedCollection =
      FirebaseFirestore.instance.collection('saved');

  Future<List<Map<String, dynamic>>?> fetchFirestoreData() async {
    isDataLoading = true;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> documentData =
          document.data() as Map<String, dynamic>;
      dataList.add(documentData);
    }
    isDataLoading = false;
    update(['home']);
    return dataList;
  }

  savedDemo() async {
    await savedCollection
        .doc(PrefService.getString('docId'))
        .get()
        .then((value) {
      savedList = value['savedList'];
    });
  }

  void searchFunc(String query) {
    searchData.clear();
    dataList.forEach((map) {
      map['subcategory'].forEach((e) {
        if (e['Name'].toString().toLowerCase().contains(query.toLowerCase())) {
          searchData.add(e);
          update(['search']);
        }
      });
    });
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
        break;
      }
      update(['home']);
    }
  }

  data() async {
    await fetchFirestoreData();
    index();
    await savedDemo();
    filteredList.addAll(dataList);
    Get.forceAppUpdate();
  }

  index() {
    isSaved = List.generate(dataList.length, (index) => false);
  }

  @override
  void onInit() {
    super.onInit();
    data();
  }
}
