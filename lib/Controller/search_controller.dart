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
  bool searchHasData = false;
  bool save = false;
  List<bool> isSaved = [];

  CollectionReference savedCollection =
      FirebaseFirestore.instance.collection('saved');

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

  savedDemo() async {
    await savedCollection
        .doc(PrefService.getString('docId'))
        .get()
        .then((value) {
      savedList = value['savedList'];
    });
  }

  void searchFunc(String query) {
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

  saved(query) {
    savedDemo();
    for (int i = 0; i < savedList.length; i++) {
      if (savedList[i]['headLine'] == query) {
        save = true;
        print(save);
        print("INDEX ------- > $i");
        FirebaseFirestore.instance.collection('saved').get().then((value) {
          print("INDEX----->${i}");
        });
      }
    }
  }

  // int i = 0;
  // matchData() {
  //   for (int i = 0; i < dataList.length; i++) {
  //     dataList[i]['subcategory'].forEach((e) {
  //       print(e);
  //       for (int K = 0; K < savedList.length; K++) {
  //         if (e['Data']['HeadLine'] == savedList[K]['headLine']) {
  //           isSaved[K] = true;
  //           i = K;
  //           update(['home']);
  //         }
  //       }
  //     });
  //   }
  // }

  data() async {
    await fetchFirestoreData();
    index();
    await savedDemo();
    // matchData();
    filteredList.addAll(dataList);
    searchData.addAll(dataList);
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
