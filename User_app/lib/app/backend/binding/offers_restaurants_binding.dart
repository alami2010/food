/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:get/get.dart';
import 'package:upgrade/app/controller/offers_restaurants_controller.dart';

class OffersRestaurantsBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => OffersRestaurantsController(parser: Get.find()),
    );
  }
}
