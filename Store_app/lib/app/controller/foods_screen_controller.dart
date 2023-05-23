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
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/models/categories_model.dart';
import 'package:vender/app/backend/models/food_list_model.dart';
import 'package:vender/app/backend/parse/foods_screen_parse.dart';
import 'package:vender/app/controller/add_food_controller.dart';
import 'package:vender/app/helper/router.dart';
import 'package:vender/app/util/constant.dart';

class FoodsScreenController extends GetxController implements GetxService {
  final FoodsScreenParse parser;
  String cateId = '';
  String from = '';
  final List<String> elements = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];
  List<CategoriesModel> _categories = <CategoriesModel>[];
  List<CategoriesModel> get categories => _categories;

  List<FoodListModel> _foodList = <FoodListModel>[];
  List<FoodListModel> get foodList => _foodList;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  FoodsScreenController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getCategories();
  }

  Future<void> getCategories() async {
    var body = {'id': parser.storeId()};
    Response response = await parser.getCategory(body);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var admin = myMap['data'];
      var store = myMap['stores'];
      _categories = [];
      admin.forEach((cat) {
        CategoriesModel cats = CategoriesModel.fromJson(cat);
        cats.from = 0; // admin id
        cats.cateId = cats.id.toString();
        _categories.add(cats);
      });
      store.forEach((cat) {
        CategoriesModel cats = CategoriesModel.fromJson(cat);
        cats.from = 1; // store id
        cats.cateId = 'store_${cats.id}';
        _categories.add(cats);
      });
      if (_categories.isNotEmpty) {
        cateId = _categories[0].id.toString();
        from = _categories[0].from.toString();
        getFoods();
        update();
      }
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getFoods() async {
    var param = {
      "store_id": parser.storeId(),
      "from_cate": from,
      "cate_id": cateId
    };
    Response response = await parser.getFoodList(param);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var food = myMap['data'];
      debugPrint(response.bodyString);
      _foodList = [];
      food.forEach((data) {
        FoodListModel datas = FoodListModel.fromJson(data);
        _foodList.add(datas);
      });
      debugPrint(foodList.length.toString());
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  void changeCat(String id, String fromCate) {
    cateId = id;
    from = fromCate;
    _foodList = [];
    update();
    getFoods();
  }

  void onAddFood() {
    Get.delete<AddFoodController>(force: true);
    Get.toNamed(AppRouter.getAddFood(), arguments: ['new']);
  }

  void editFood(String id) {
    Get.delete<AddFoodController>(force: true);
    Get.toNamed(AppRouter.getAddFood(), arguments: ['update', id]);
  }
}
