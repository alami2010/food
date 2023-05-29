/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:foodies_user/app/backend/parse/tab_parse.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/controller/my_cart_controller.dart';

class TabsController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final TabParse parser;
  int currentIndex = 0;
  int cartTotal = 0;

  late TabController tabController;

  TabsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(length: 4, vsync: this, initialIndex: currentIndex);
  }

  void cleanLoginCreds() {
    parser.cleanData();
  }

  void updateCartValue() {
    cartTotal = Get.find<MyCartController>().totalItemsInCart;
    update();
  }

  void cleanData() {
    cartTotal = 0;
    update();
  }

  void updateIndex(int index) {
    currentIndex = index;
    tabController.animateTo(currentIndex);
    update();
  }
}
