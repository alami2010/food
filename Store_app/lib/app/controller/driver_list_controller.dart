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
import 'package:vender/app/backend/models/drivers_model.dart';
import 'package:vender/app/backend/parse/driver_list_parse.dart';
import 'package:vender/app/controller/order_details_controller.dart';
import 'package:vender/app/util/toast.dart';

class DriverListController extends GetxController implements GetxService {
  final DriverListParse parser;
  List<DriversModel> _driverList = <DriversModel>[];
  List<DriversModel> get driverList => _driverList;

  int selectedDriverId = 0;
  DriverListController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    _driverList = Get.find<OrderDetailsController>().driverList;
  }

  void onSaveDriver(int id) {
    selectedDriverId = id;
    update();
  }

  void onSaveAndExit() {
    if (selectedDriverId == 0) {
      showToast('Please select driver');
      return;
    }
    Get.find<OrderDetailsController>().saveDriverId(selectedDriverId);
    onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
