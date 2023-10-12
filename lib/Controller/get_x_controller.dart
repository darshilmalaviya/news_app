// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Common/images.dart';

class GetCntrl extends GetxController {
  // Register Screen

  TextEditingController emailcntrl = TextEditingController();
  TextEditingController passwordcntrl = TextEditingController();
  TextEditingController confirmpasswordcntrl = TextEditingController();

  // Log in Screen
  bool obsecure = true;
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController Loginemail = TextEditingController();
  TextEditingController Loginpassword = TextEditingController();

  // Forgot Password
  TextEditingController ForgotPassEmail = TextEditingController();

  // home screen
  bool subCatHasData = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CollectionReference Users =
      FirebaseFirestore.instance.collection('categories');
  List<bool> showDropDown = List.generate(0, (index) => false);

  // detail screen
  bool isIconChanged = false;

  int categories1 = 0;

  int select = 0;
  List Categery = [
    "For You",
    "Top",
    "World",
    "Politics",
    "Entertainment",
  ];

  bool bookMark = false;
  List<bool> BookMark = List.generate(1000, (index) => false);
  int DropDownColor = 0;
  String? ingredient;

  indexes() async {
    var data = await Users.get();
    showDropDown = List.generate(data.docs.length, (index) => false);
  }

  @override
  void onInit() {
    indexes();
    super.onInit();
  }
}
