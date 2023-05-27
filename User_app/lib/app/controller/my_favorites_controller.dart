/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/models/restaurant_models.dart';
import 'package:upgrade/app/backend/parse/my_favorites_parse.dart';
import 'package:get/get.dart';
import 'package:upgrade/app/controller/restaurant_detail_controller.dart';
import 'package:upgrade/app/helper/router.dart';
import 'package:upgrade/app/util/constant.dart';

class MyFavoritesController extends GetxController implements GetxService {
  final MyFavoritesParse parser;
  bool apiCalled = false;
  bool haveData = false;
  String distanceType = 'KM';
  List<RestaurantModal> _restaurantList = <RestaurantModal>[];
  List<RestaurantModal> get restaurantList => _restaurantList;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;
  MyFavoritesController({required this.parser});

  @override
  void onInit() {
    debugPrint('call api');
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getMyList();
  }

  Future<void> getMyList() async {
    var param = {
      "lat": parser.getLat(),
      "lng": parser.getLng(),
      "uid": parser.getUID()
    };
    Response response = await parser.getMyList(param);
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      haveData = myMap['havedata'];
      distanceType = myMap['distanceType'];
      debugPrint(haveData.toString());
      var restaurant = myMap['data'];
      _restaurantList = [];
      restaurant.forEach((res) {
        RestaurantModal rests = RestaurantModal.fromJson(res);
        _restaurantList.add(rests);
      });
      debugPrint(restaurantList.length.toString());
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

  Widget getDummy() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 30),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 50,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(8)),
            ),
            const SizedBox(height: 20),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 150,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(8)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 16,
                      width: 64,
                      borderRadius: BorderRadius.circular(8)),
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 16,
                      width: 64,
                      borderRadius: BorderRadius.circular(8)),
                )
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(10, (index) {
                return SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  borderRadius: BorderRadius.circular(8),
                ));
              })),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 16,
                      width: 64,
                      borderRadius: BorderRadius.circular(8)),
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 16,
                      width: 64,
                      borderRadius: BorderRadius.circular(8)),
                )
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(10, (index) {
                return SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                  width: 280,
                  height: 120,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  borderRadius: BorderRadius.circular(8),
                ));
              })),
            ),
            const SizedBox(height: 10),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 120,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(8)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
