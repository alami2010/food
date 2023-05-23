/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/models/cuisines_models.dart';
import 'package:upgrade/app/backend/parse/cuisines_parse.dart';
import 'package:get/get.dart';
import 'package:upgrade/app/controller/getby_categories_controller.dart';
import 'package:upgrade/app/helper/router.dart';

class CuisinesController extends GetxController implements GetxService {
  final CuisinesParse parser;
  bool apiCalled = false;

  List<CuisinesModal> _categoryList = <CuisinesModal>[];
  List<CuisinesModal> get categoryList => _categoryList;

  CuisinesController({required this.parser});

  @override
  void onInit() {
    debugPrint('call api');
    super.onInit();
    getCuisinesData();
  }

  Future<void> getCuisinesData() async {
    Response response = await parser.getCuisinesData();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var cuisine = myMap['data'];
      _categoryList = [];
      cuisine.forEach((data) {
        CuisinesModal dates = CuisinesModal.fromJson(data);
        _categoryList.add(dates);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onGetByCategories(String id, String name) {
    Get.delete<GetByCategoriesController>(force: true);
    Get.toNamed(AppRouter.getByCategories(), arguments: [id, name]);
  }
}
