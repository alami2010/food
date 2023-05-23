/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:get/get.dart';
import 'package:vender/app/controller/account_controller.dart';
import 'package:vender/app/controller/insights_controller.dart';
import 'package:vender/app/controller/order_screen_controller.dart';
import 'package:vender/app/controller/tab_controller.dart';

class TabBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => TabsController(parser: Get.find()),
    );
    Get.lazyPut(
      () => OrderScreenController(parser: Get.find()),
    );
    Get.lazyPut(
      () => InsightsController(parser: Get.find()),
    );
    Get.lazyPut(
      () => AccountController(parser: Get.find()),
    );
  }
}
