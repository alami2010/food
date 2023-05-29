/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/models/table_list_model.dart';
import 'package:foodies_user/app/backend/parse/table_list_parse.dart';
import 'package:get/get.dart';

class TableListController extends GetxController implements GetxService {
  final TableListParse parser;

  List<TableListModel> _tableList = <TableListModel>[];
  List<TableListModel> get tableList => _tableList;

  bool apiCalled = false;

  List<String> status = [
    'Requested'.tr,
    'Accepted'.tr,
    'Completed'.tr,
    'Rejected'.tr,
  ];

  TableListController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getTableList();
  }

  Future<void> getTableList() async {
    Response response = await parser.getTableList();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var booking = myMap['data'];
      _tableList = [];
      booking.forEach((element) {
        TableListModel ele = TableListModel.fromJson(element);
        _tableList.add(ele);
        debugPrint(tableList.length.toString());
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
