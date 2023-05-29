/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/models/product_models.dart';
import 'package:foodies_user/app/backend/models/store_models.dart';
import 'package:foodies_user/app/backend/parse/restaurant_detail_parse.dart';
import 'package:foodies_user/app/controller/my_cart_controller.dart';
import 'package:foodies_user/app/controller/tab_controller.dart';
import 'package:foodies_user/app/controller/table_booking_controller.dart';
import 'package:foodies_user/app/env.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/util/constant.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:flutter_share/flutter_share.dart';

class RestaurantDetailController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final RestaurantDetailParse parser;
  late TabController? tabController;
  int currentMode = 0;
  String tabID = '1';
  String restId = '';

  bool isFav = false;
  bool apiCalled = false;
  bool isSwitched = false; // 1 = veg // 2 = non
  bool isNon = false; // 1 = veg // 2 = non

  StoreModal _storeData = StoreModal();
  StoreModal get storeData => _storeData;

  List<ProductModal> _productList = <ProductModal>[];
  List<ProductModal> get productList => _productList;

  List<GlobalKey> cateListKey = <GlobalKey>[];

  ScrollController sController = ScrollController();

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  bool haveData = false;

  String userName = '';

  RestaurantDetailController({required this.parser});

  @override
  void onInit() {
    debugPrint('call api');
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    tabController = TabController(vsync: this, length: 4);
    restId = Get.arguments[0];
    userName = parser.getName();
    getStoreData();
  }

  Future<void> getStoreData() async {
    var param = {
      "id": restId,
    };
    Response response = await parser.getStoreData(param);
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var store = myMap['store'];
      StoreModal datas = StoreModal.fromJson(store);

      _storeData = datas;
      debugPrint(storeData.name);

      var product = myMap['data'];
      if (product.length > 0) {
        haveData = true;
      }
      debugPrint(haveData.toString());
      _productList = [];
      product.forEach((pro) {
        ProductModal prods = ProductModal.fromJson(pro);
        cateListKey.add(GlobalKey());
        _productList.add(prods);
      });
      checkCartData();
      parser.cleanLocal();
      parser.saveLocalInfo(_productList);
      debugPrint(productList.length.toString());

      if (parser.isLoggedIn() == true) {
        var myFavParam = {"uid": parser.getUID(), "store_id": restId};
        Response favList = await parser.myFavList(myFavParam);
        Map<String, dynamic> favMap = Map<String, dynamic>.from(favList.body);
        debugPrint(favMap.toString());
        if (favMap['data'] != null &&
            favMap['data'] != 'null' &&
            favMap['data']['id'] != null) {
          isFav = true;
          update();
        }
      }
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  void checkCartData() {
    for (var element in _productList) {
      for (var product in element.products!) {
        if (Get.find<MyCartController>()
                .checkProductInCart(product.id as int) ==
            true) {
          product.quantity =
              Get.find<MyCartController>().getQuantity(product.id as int);
        } else {
          product.quantity = 0;
        }
      }
    }
    update();
  }

  int getMinDeliveryTime(String value) {
    return int.parse(value) - 5;
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  void changeFindingMode(int mode) {
    currentMode = mode;
    update();
  }

  void changeCat(String cat) {
    tabID = cat;
    update();
    var index =
        productList.indexWhere((element) => element.cateId.toString() == cat);
    debugPrint('index=>>>>$index');
    if (index >= 0) {
      Scrollable.ensureVisible(cateListKey[index].currentContext!);
    }
    update();
  }

  void onMyCart() {
    Get.find<MyCartController>().getCart();
    Get.find<TabsController>().updateIndex(2);
    Get.offAllNamed(AppRouter.getTab());
  }

  Future<void> share() async {
    String title =
        '${'Your friend'.tr} $userName ${'has invited you to'.tr} ${Environments.appName}';
    String message = '${'Hey Buddy download'.tr} ${Environments.appName}';
    await FlutterShare.share(
        title: title,
        text: message,
        linkUrl: Environments.websiteURL,
        chooserTitle: 'Share with buddies'.tr);
  }

  void onTableBooking() {
    Get.delete<TableBookingController>(force: true);
    if (parser.isLoggedIn() == true) {
      debugPrint('Go to table booking');
      Get.toNamed(AppRouter.getTableBooking(),
          arguments: [storeData.uid.toString()]);
    } else {
      debugPrint('Go to Login');
      Get.offNamed(AppRouter.getLogin());
    }
  }

  void onSwitch(bool value) {
    isSwitched = value;
    if (value == true) {
      for (var element in _productList) {
        element.products = element.products!.where((e) => e.veg == 1).toList();
      }
    } else {
      _productList = parser.getLocalProducts();
    }

    update();
  }

  void onNon(bool value) {
    isNon = value;
    if (value == true) {
      for (var element in _productList) {
        element.products = element.products!.where((e) => e.veg == 2).toList();
      }
    } else {
      _productList = parser.getLocalProducts();
    }

    update();
  }

  void addToCart(int index, int subIndex) {
    _productList[index].products![subIndex].quantity = 1;
    Get.find<MyCartController>()
        .addItem(_productList[index].products![subIndex]);
    checkCartData();
    update();
  }

  void updateProductQuantity(int index, int subIndex) {
    _productList[index].products![subIndex].quantity =
        _productList[index].products![subIndex].quantity + 1;
    Get.find<MyCartController>()
        .addQuantity(_productList[index].products![subIndex]);
    checkCartData();
    update();
  }

  void updateProductQuantityRemove(int index, int subIndex) {
    if (_productList[index].products![subIndex].quantity == 1) {
      _productList[index].products![subIndex].quantity = 0;
      Get.find<MyCartController>()
          .removeItem(_productList[index].products![subIndex]);
      Get.find<TabsController>().updateCartValue();
    } else {
      _productList[index].products![subIndex].quantity =
          _productList[index].products![subIndex].quantity - 1;
      Get.find<MyCartController>()
          .addQuantity(_productList[index].products![subIndex]);
    }
    checkCartData();
    update();
  }

  int getSumOfItems(int id) {
    return Get.find<MyCartController>().getSumOfVariations(id);
  }

  void addToFav() {
    if (parser.isLoggedIn() == true) {
      debugPrint('favoirite');
      if (isFav == true) {
        debugPrint('remove');
        removeFavList();
      } else {
        debugPrint('add');
        addToFavList();
      }
    } else {
      debugPrint('Go to Login');
      Get.toNamed(AppRouter.getLogin());
    }
  }

  Future<void> removeFavList() async {
    Get.dialog(
      SimpleDialog(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              const CircularProgressIndicator(
                color: ThemeProvider.appColor,
              ),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                  child: Text(
                "Please wait".tr,
                style: const TextStyle(fontFamily: 'bold'),
              )),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
    var addToFavParam = {
      "uid": parser.getUID(),
      "store_id": restId,
      "status": 1
    };
    Response response = await parser.removeFromFavList(addToFavParam);
    Get.back();
    if (response.statusCode == 200) {
      isFav = false;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> addToFavList() async {
    Get.dialog(
      SimpleDialog(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              const CircularProgressIndicator(
                color: ThemeProvider.appColor,
              ),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                  child: Text(
                "Please wait".tr,
                style: const TextStyle(fontFamily: 'bold'),
              )),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
    var addToFavParam = {
      "uid": parser.getUID(),
      "store_id": restId,
      "status": 1
    };
    Response response = await parser.addToFavourite(addToFavParam);
    Get.back();
    if (response.statusCode == 200) {
      isFav = true;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
