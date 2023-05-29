/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:foodies_user/app/backend/parse/slider_screen_parse.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:get/get.dart';

import '../helper/slider_screen_data.dart';

class SliderScreenController extends GetxController implements GetxService {
  final SliderScreenParse parser;
  int currentIndex = 0;
  late PageController controller = PageController();

  List<Item> contents = <Item>[
    Item(
        image: 'assets/images/s1.png',
        title: 'Find Food You Love',
        description:
            'Discover the best foods from over 1,000 restaurants and fast delivery to your doorstop'),
    Item(
        image: 'assets/images/s2.png',
        title: 'Fast Delivery',
        description: 'Fast delivery to your home,office wherever you are'),
    Item(
        image: 'assets/images/s3.png',
        title: 'Live Tracking',
        description:
            'Real time tracking of your food on the app once you placed the order'),
  ];

  @override
  void onInit() {
    super.onInit();
    update();
  }

  void updateSliderIndex(int index) {
    currentIndex = index;
    update();
  }

  void saveLanguage(String code) {
    parser.saveLanguage(code);
  }

  void onChooseLocation() {
    Get.offNamed(AppRouter.getChooseLocation());
  }

  SliderScreenController({required this.parser});
}
