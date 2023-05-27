/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:upgrade/app/controller/message_controll.dart';
import 'package:get/get.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => MessageController(parser: Get.find()),
    );
  }
}
