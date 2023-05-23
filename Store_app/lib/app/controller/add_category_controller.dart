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
import 'package:vender/app/backend/models/admin_category_model.dart';
import 'package:vender/app/backend/models/store_category_model.dart';
import 'package:vender/app/backend/parse/add_category_parse.dart';
import 'package:vender/app/controller/add_admin_category_controller.dart';
import 'package:vender/app/controller/add_store_category_controller.dart';
import 'package:vender/app/helper/router.dart';
import 'package:vender/app/util/theme.dart';

class AddCategoryController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements GetxService {
  final AddCategoryParse parser;

  AddCategoryController({required this.parser});

  List<AdminCategoryModel> _adminData = <AdminCategoryModel>[];
  List<AdminCategoryModel> get adminData => _adminData;

  List<StoreCategoryModel> _storeData = <StoreCategoryModel>[];
  List<StoreCategoryModel> get storeData => _storeData;

  List<int> masterCateId = [];

  late TabController tabController;
  int currentIndex = 0;

  @override
  void onInit() {
    debugPrint('call api');
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      debugPrint(tabController.index.toString());
      tabController.animateTo(tabController.index);
      update();
    });
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
      _adminData = [];
      masterCateId = [];
      admin.forEach((cat) {
        AdminCategoryModel cats = AdminCategoryModel.fromJson(cat);
        _adminData.add(cats);
        masterCateId.add(cats.id as int);
      });
      debugPrint(masterCateId.toString());
      debugPrint(adminData.length.toString());

      var store = myMap['stores'];
      _storeData = [];
      store.forEach((data) {
        StoreCategoryModel datas = StoreCategoryModel.fromJson(data);
        _storeData.add(datas);
      });
      debugPrint(storeData.length.toString());
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> onStatusChange(int id, int status) async {
    debugPrint(id.toString());
    debugPrint(status.toString());
    Get.dialog(
      const SimpleDialog(
        children: [
          Center(
            child: CircularProgressIndicator(
              color: ThemeProvider.appColor,
            ),
          ),
        ],
      ),
    );

    var param = {"id": id, "status": status == 1 ? 0 : 1};
    Response response = await parser.getStatus(param);
    Get.back();

    if (response.statusCode == 200) {
      getCategory();
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> onAdminStatus(int id) async {
    debugPrint('betore$masterCateId');
    var ids =
        masterCateId.where((element) => element.toString() != id.toString());
    var param = {"id": parser.getStoreId(), "master_categories": ids.join(',')};
    debugPrint(param.toString());
    Response response = await parser.getAdminCategory(param);
    if (response.statusCode == 200) {
      getCategory();
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getDelete(int id) async {
    Get.dialog(
      const SimpleDialog(
        children: [
          Center(
            child: CircularProgressIndicator(
              color: ThemeProvider.appColor,
            ),
          )
        ],
      ),
    );

    var param = {"id": id};
    Response response = await parser.getDelete(param);
    Get.back();

    if (response.statusCode == 200) {
      getCategory();
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onStoreCategory() {
    Get.delete<AddStoreCategoryController>(force: true);
    Get.toNamed(AppRouter.getAddStoreCategory(), arguments: ['new']);
  }

  void onEditStoreCategory(int id) {
    Get.delete<AddStoreCategoryController>(force: true);
    Get.toNamed(AppRouter.getAddStoreCategory(), arguments: ['update', id]);
  }

  void onAdminCategory() {
    Get.delete<AddAdminCategoryController>(force: true);
    Get.toNamed(AppRouter.getAdminCategory(),
        arguments: [jsonEncode(masterCateId)]);
  }
}
