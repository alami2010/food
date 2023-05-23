/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vender/app/backend/parse/cuisine_parse.dart';
import 'package:vender/app/controller/edit_profile_controller.dart';

class CuisineController extends GetxController implements GetxService {
  final CuisineParser parser;
  List<CuisineModel> _cuisineList = <CuisineModel>[];
  List<CuisineModel> get cuisineList => _cuisineList;
  List<String> savedItems = [];
  CuisineController({required this.parser});

  @override
  void onInit() {
    debugPrint(Get.arguments[0].toString());
    savedItems = Get.arguments[0].toString().split(',');
    super.onInit();
    readJson();
  }

  Future<void> readJson() async {
    _cuisineList = [];
    final String response =
        await rootBundle.loadString('assets/json/cuisine.json');
    var items = jsonDecode(response);
    items.forEach((element) {
      element['isChecked'] =
          savedItems.contains(element['name']) ? true : false;
      CuisineModel data = CuisineModel.fromJson(element);
      _cuisineList.add(data);
    });
    update();
    debugPrint(cuisineList.length.toString());
  }

  void onExtra(bool status, int index) {
    debugPrint(index.toString());
    _cuisineList[index].isChecked = status;
    update();
  }

  void onUpdate() {
    var items = _cuisineList.where((element) => element.isChecked == true);
    var saveItems = [];
    for (var element in items) {
      saveItems.add(element.name);
    }
    Get.find<EditProfileController>().saveCuisines(saveItems.join(','));
    onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}

class CuisineModel {
  String? name;
  late bool? isChecked = false;
  CuisineModel({this.name, this.isChecked});

  CuisineModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isChecked = json['isChecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isChecked'] = isChecked;
    return data;
  }
}
