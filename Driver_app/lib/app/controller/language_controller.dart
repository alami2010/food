/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/parse/language_parse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController implements GetxService {
  final LanguageParse parser;
  int filter = 1;

  late String languageCode;
  LanguageController({required this.parser});

  void onFilter(var id) {
    filter = id;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    languageCode = parser.getDefault();
  }

  void saveLanguages(String code) {
    var locale = Locale(code.toString());
    Get.updateLocale(locale);
    parser.saveLanguage(code);
    languageCode = code;
    update();
  }
}
