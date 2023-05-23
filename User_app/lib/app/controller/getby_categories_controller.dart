/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/models/baner_models.dart';
import 'package:upgrade/app/backend/models/restaurant_models.dart';
import 'package:upgrade/app/backend/parse/getby_categories_parse.dart';
import 'package:get/get.dart';
import 'package:upgrade/app/controller/restaurant_detail_controller.dart';
import 'package:upgrade/app/helper/router.dart';
import 'package:upgrade/app/util/constant.dart';

class GetByCategoriesController extends GetxController implements GetxService {
  final GetByCategoriesParse parser;

  List<RestaurantModal> _restaurantList = <RestaurantModal>[];
  List<RestaurantModal> get restaurantList => _restaurantList;

  List<BanerModal> _banerList = <BanerModal>[];
  List<BanerModal> get banerList => _banerList;

  bool apiCalled = false;
  String cusineId = '';
  String cusineName = '';

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  String distanceType = 'KM';
  bool haveData = false;

  GetByCategoriesController({required this.parser});

  @override
  void onInit() {
    debugPrint('call api');
    super.onInit();
    cusineId = Get.arguments[0];
    cusineName = Get.arguments[1];
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getNearMeCategories();
  }

  Future<void> getNearMeCategories() async {
    var param = {
      "id": cusineId,
      "lat": parser.getLat(),
      "lng": parser.getLng(),
    };

    Response response = await parser.getNearMeCategories(param);
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      haveData = myMap['havedata'];
      var restaurant = myMap['data'];
      distanceType = myMap['distanceType'];
      _restaurantList = [];
      restaurant.forEach((res) {
        RestaurantModal rests = RestaurantModal.fromJson(res);
        _restaurantList.add(rests);
      });
      debugPrint(restaurantList.length.toString());

      var baner = myMap['banners'];
      _banerList = [];
      baner.forEach((data) {
        BanerModal dates = BanerModal.fromJson(data);
        _banerList.add(dates);
      });
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  int getMinDeliveryTime(String value) {
    return int.parse(value) - 5;
  }

  void onRestaurantDetail(String id) {
    Get.delete<RestaurantDetailController>(force: true);
    Get.toNamed(AppRouter.getRestaurantDetail(), arguments: [id]);
  }
}
