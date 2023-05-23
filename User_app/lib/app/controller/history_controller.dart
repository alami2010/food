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
import 'package:upgrade/app/backend/models/orders_model.dart';
import 'package:upgrade/app/backend/parse/history_parse.dart';
import 'package:get/get.dart';
import 'package:upgrade/app/controller/order_details_controller.dart';
import 'package:upgrade/app/helper/router.dart';
import 'package:upgrade/app/util/constant.dart';

class HistoryController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final HistoryParse parser;

  List<OrdersModel> _orderList = <OrdersModel>[];
  List<OrdersModel> get orderList => _orderList;

  List<OrdersModel> _olderOrderList = <OrdersModel>[];
  List<OrdersModel> get olderOrderList => _olderOrderList;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  bool loadMore = false;
  bool apiCalled = false;
  RxInt lastLimit = 1.obs;
  HistoryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    if (parser.haveLoggedIn() == true) {
      getOrderList();
    }
  }

  Future<void> getOrderList() async {
    var param = {"id": parser.getUID()};
    Response response = await parser.getOrders(param);
    apiCalled = true;
    loadMore = false;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var order = myMap['data'];
      _orderList = [];
      _olderOrderList = [];
      order.forEach((data) {
        OrdersModel datas = OrdersModel.fromJson(data);
        if (datas.status == 0 ||
            datas.status == 1 ||
            datas.status == 2 ||
            datas.status == 3 ||
            datas.status == 8) {
          _orderList.add(datas);
        } else {
          _olderOrderList.add(datas);
        }
      });
      debugPrint(orderList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onLogin() {
    Get.toNamed(AppRouter.getLogin());
  }

  void onOrderDetails(int id) {
    debugPrint('hi there');
    Get.delete<OrderDetailsController>(force: true);
    Get.toNamed(AppRouter.getOrderDetails(), arguments: [id]);
  }

  Future<void> onRefresh() async {
    debugPrint('Hi There');
    apiCalled = false;
    update();
    getOrderList();
  }

  void increment() {
    debugPrint('load more');
    loadMore = true;
    lastLimit = lastLimit++;
    update();
    getOrderList();
  }
}
