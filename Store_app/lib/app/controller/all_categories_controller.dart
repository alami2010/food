/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/models/categories_model.dart';

import 'package:vender/app/backend/parse/all_categories_parse.dart';
import 'package:vender/app/controller/add_food_controller.dart';
import 'package:vender/app/util/toast.dart';

class AllCategoriesController extends GetxController implements GetxService {
  final AllCategoriesParse parser;

  List<CategoriesModel> _categories = <CategoriesModel>[];
  List<CategoriesModel> get categories => _categories;
  String selectedCatId = '';
  String fromCate = '';
  String cateId = '';
  String cateName = '';
  AllCategoriesController({required this.parser});

  @override
  void onInit() {
    debugPrint('call api');
    super.onInit();
    selectedCatId = Get.arguments[0];
    cateId = Get.arguments[0];
    cateName = Get.arguments[1];
    fromCate = Get.arguments[2];
    if (Get.arguments[2] == '1') {
      debugPrint('from sdstore');
      cateId = 'store_${Get.arguments[0]}';
    }
    getCategory();
  }

  Future<void> getCategory() async {
    var param = {
      "id": parser.getStoreId(),
    };
    Response response = await parser.getCategory(param);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var admin = myMap['data'];
      var store = myMap['stores'];
      _categories = [];
      admin.forEach((cat) {
        CategoriesModel cats = CategoriesModel.fromJson(cat);
        cats.from = 0; // admin id
        cats.cateId = cats.id.toString();
        _categories.add(cats);
      });
      store.forEach((cat) {
        CategoriesModel cats = CategoriesModel.fromJson(cat);
        cats.from = 1; // store id
        cats.cateId = 'store_${cats.id}';
        _categories.add(cats);
      });
      // debugPrint(adminData.length.toString());
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onCategory(String id, String from, String cateIds, String name) {
    selectedCatId = id;
    fromCate = from;
    cateId = cateIds;
    cateName = name;
    // from // id
    debugPrint('real id$selectedCatId');
    debugPrint('from$fromCate');
    debugPrint('cateid$cateId');
    debugPrint('name$name');
    update();
  }

  void onSave() {
    if (selectedCatId.isEmpty) {
      showToast('Please select category');
      return;
    }
    Get.find<AddFoodController>()
        .saveCategory(selectedCatId.toString(), fromCate.toString(), cateName);
    onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
