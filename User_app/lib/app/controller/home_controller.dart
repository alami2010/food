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
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/models/baner_models.dart';
import 'package:foodies_user/app/backend/models/category_models.dart';
import 'package:foodies_user/app/backend/models/restaurant_models.dart';
import 'package:foodies_user/app/backend/parse/home_parse.dart';
import 'package:foodies_user/app/controller/cuisines_controller.dart';
import 'package:foodies_user/app/controller/getby_categories_controller.dart';
import 'package:foodies_user/app/controller/offers_restaurants_controller.dart';
import 'package:foodies_user/app/controller/restaurant_detail_controller.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/util/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController implements GetxService {
  final HomeParse parser;
  int currentMode = 0;

  List<CategoryModel> _categoryList = <CategoryModel>[];
  List<CategoryModel> get categoryList => _categoryList;

  List<RestaurantModal> _restaurantList = <RestaurantModal>[];
  List<RestaurantModal> get restaurantList => _restaurantList;

  List<BanerModal> _banerList = <BanerModal>[];
  List<BanerModal> get banerList => _banerList;

  bool apiCalled = false;
  bool haveData = false;

  String distanceType = 'KM';
  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  String titleName = '';

  HomeController({required this.parser});

  @override
  void onInit() {
    debugPrint('call api');
    super.onInit();
    titleName = parser.getAddressName();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getHomeData();
  }

  Future<void> getHomeData() async {
    var param = {
      "lat": parser.getLat(),
      "lng": parser.getLng(),
      "kind": greeting()
    };
    Response response = await parser.getHomeData(param);
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      // debugPrint(myMap.toString());
      var cates = myMap['categories'];
      haveData = myMap['havedata'];
      distanceType = myMap['distanceType'];
      debugPrint(haveData.toString());
      _categoryList = [];
      cates.forEach((data) {
        CategoryModel datas = CategoryModel.fromJson(data);
        _categoryList.add(datas);
      });
      debugPrint(categoryList.length.toString());

      var restaurant = myMap['data'];
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
      debugPrint(banerList.length.toString());
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return '1';
    }
    if (hour < 17) {
      return '2';
    }
    return '3';
  }

  void onBannerClick(int type, String value) {
    if (type == 1) {
      // category
      Get.delete<GetByCategoriesController>(force: true);
      Get.toNamed(AppRouter.getByCategories(), arguments: [value, 'Offers'.tr]);
    } else if (type == 2) {
      // single restaurants
      Get.delete<RestaurantDetailController>(force: true);
      Get.toNamed(AppRouter.getRestaurantDetail(), arguments: [value]);
    } else if (type == 3) {
      // multiple restaurants
      Get.delete<OffersRestaurantsController>(force: true);
      Get.toNamed(AppRouter.getOffersRestaurantsRoutes(), arguments: [value]);
    } else if (type == 4) {
      // external link
      launchInBrowser(value);
    }
  }

  Future<void> launchInBrowser(String uri) async {
    var url = Uri.parse(uri);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  void onRestaurantDetail(String id) {
    Get.delete<RestaurantDetailController>(force: true);
    Get.toNamed(AppRouter.getRestaurantDetail(), arguments: [id]);
  }

  void onGetByCategories(String id, String name) {
    Get.delete<GetByCategoriesController>(force: true);
    Get.toNamed(AppRouter.getByCategories(), arguments: [id, name]);
  }

  void onSearchScreen() {
    Get.toNamed(AppRouter.getSearch());
  }

  void onCuisines() {
    Get.delete<CuisinesController>(force: true);
    Get.toNamed(AppRouter.getCusiness());
  }

  void onChooseLocation() {
    Get.offNamed(AppRouter.getChooseLocation());
  }

  int getMinDeliveryTime(String value) {
    return int.parse(value) - 5;
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
