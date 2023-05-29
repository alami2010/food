/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:foodies_user/app/controller/account_controller.dart';
import 'package:foodies_user/app/controller/history_controller.dart';
import 'package:foodies_user/app/controller/home_controller.dart';
import 'package:foodies_user/app/controller/my_cart_controller.dart';
import 'package:foodies_user/app/controller/tab_controller.dart';
import 'package:get/get.dart';

class TabBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => TabsController(parser: Get.find()),
    );
    Get.lazyPut(() => HomeController(parser: Get.find()), fenix: true);

    Get.lazyPut(() => HistoryController(parser: Get.find()), fenix: true);

    Get.lazyPut(() => MyCartController(parser: Get.find()), fenix: true);

    Get.lazyPut(() => AccountController(parser: Get.find()), fenix: true);
  }
}
