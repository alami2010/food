/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:upgrade/app/controller/account_controller.dart';
import 'package:upgrade/app/controller/tab_controller.dart';
import 'package:upgrade/app/helper/router.dart';
import 'package:upgrade/app/util/toast.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      showToast('Session expired!'.tr);
      showToast('Session expired!'.tr);
      Get.find<TabsController>().cleanLoginCreds();
      Get.find<AccountController>().cleanData();
      Get.toNamed(AppRouter.getLogin());
    } else {
      showToast(response.statusText.toString().tr);
    }
  }
}
