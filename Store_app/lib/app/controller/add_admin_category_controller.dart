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
import 'package:get/get.dart';
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/models/add_admin_model.dart';
import 'package:vender/app/backend/parse/add_admin_category_parse.dart';
import 'package:vender/app/controller/add_category_controller.dart';
import 'package:vender/app/util/toast.dart';

class AddAdminCategoryController extends GetxController implements GetxService {
  final AddAdminCategoryParse parser;

  AddAdminCategoryController({required this.parser});

  List<AddAdminModel> _masterData = <AddAdminModel>[];
  List<AddAdminModel> get masterData => _masterData;

  List<int> masterCategories = [];

  @override
  void onInit() {
    debugPrint('call api');
    super.onInit();
    if (Get.arguments[0] != null) {
      var ids = jsonDecode(Get.arguments[0]);
      masterCategories = [];
      ids.forEach((element) {
        masterCategories.add(element);
      });
    }
    getMasterCategory();
  }

  Future<void> getMasterCategory() async {
    var response = await parser.getMasterCategory();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      debugPrint(myMap['data'].toString());
      var cates = myMap['data'];
      _masterData = [];
      cates.forEach((data) {
        AddAdminModel dates = AddAdminModel.fromJson(data);
        var added = masterCategories.where((element) => element == dates.id);
        if (added.isNotEmpty) {
          dates.isChecked = true;
        } else {
          dates.isChecked = false;
        }
        _masterData.add(dates);
      });
      debugPrint(masterData.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onExtra(bool status, int id) {
    debugPrint('$status - -  $id');
    debugPrint(masterCategories.toString());
    var index = masterCategories
        .indexWhere((element) => element.toString() == id.toString());
    var itemIndex = _masterData
        .indexWhere((element) => element.id.toString() == id.toString());
    debugPrint(itemIndex.toString());
    if (index >= 0) {
      debugPrint('already have it');
      masterCategories.remove(id);
      _masterData[itemIndex].isChecked = false;
      update();
    } else {
      debugPrint('no not there add it');
      masterCategories.add(id);
      _masterData[itemIndex].isChecked = true;
      update();
    }
    update();
  }

  Future<void> onUpdate() async {
    var param = {
      'id': parser.getStoreId(),
      'master_categories': masterCategories.join(',')
    };

    Response response = await parser.updateMaster(param);

    if (response.statusCode == 200) {
      masterCategories = [];
      successToast('Updated');
      Get.find<AddCategoryController>().getCategory();
      onBack();
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
