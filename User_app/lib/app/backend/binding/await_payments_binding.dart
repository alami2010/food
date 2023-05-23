/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:get/get.dart';
import 'package:upgrade/app/controller/await_payments_controller.dart';

class AwaitPaymentsBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => AwaitPaymentsController(parser: Get.find()),
    );
  }
}
