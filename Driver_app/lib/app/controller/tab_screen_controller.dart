/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/parse/tab_screen_parse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabsController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final TabParse parser;
  int currentIndex = 0;
  late TabController tabController;

  TabsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(length: 2, vsync: this, initialIndex: currentIndex);
  }

  void updateIndex(int index) {
    currentIndex = index;
    update();
  }

  void updateTabId(int id) {
    currentIndex = id;
    tabController.animateTo(currentIndex);
    update();
  }
}
