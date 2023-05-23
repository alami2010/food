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
import 'package:upgrade/app/backend/models/restaurant_models.dart';
import 'package:upgrade/app/backend/parse/search_parse.dart';
import 'package:get/get.dart';

class SearchController extends GetxController implements GetxService {
  final SearchParse parser;
  TextEditingController searchController = TextEditingController();
  RxBool isEmpty = true.obs;
  SearchController({required this.parser});
  List<RestaurantModal> _result = <RestaurantModal>[];
  List<RestaurantModal> get result => _result;

  searchProducts(String name) {
    if (name.isNotEmpty && name != '') {
      getSearchResult(name);
    } else {
      // _result = [];
      isEmpty = true.obs;
      update();
    }
  }

  void getSearchResult(String query) async {
    Response response = await parser.getSearchResult(query);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      _result = [];
      isEmpty = false.obs;
      body.forEach((data) {
        RestaurantModal datas = RestaurantModal.fromJson(data);
        _result.add(datas);
      });
    } else {
      isEmpty = false.obs;
      ApiChecker.checkApi(response);
    }
    update();
  }

  void clearData() {
    searchController.clear();
    _result = [];
    isEmpty = true.obs;
    update();
  }
}
