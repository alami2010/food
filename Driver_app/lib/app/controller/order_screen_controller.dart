/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/api/handler.dart';
import 'package:driver/app/backend/models/orders_model.dart';
import 'package:driver/app/backend/parse/order_screen_parse.dart';
import 'package:driver/app/controller/order_detail_controller.dart';
import 'package:driver/app/helper/router.dart';
import 'package:driver/app/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreenController extends GetxController implements GetxService {
  final OrderScreenParse parser;

  bool loadMore = false;
  bool apiCalled = false;
  RxInt lastLimit = 1.obs;

  List<OrderModel> _orderList = <OrderModel>[];
  List<OrderModel> get orderList => _orderList;

  List<OrderModel> _orderOlder = <OrderModel>[];
  List<OrderModel> get orderOlder => _orderOlder;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  OrderScreenController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getOrderList();
  }

  Future<void> getOrderList() async {
    Response response = await parser.getOrderList();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _orderList = [];
      _orderOlder = [];
      var body = myMap['data'];
      body.forEach(
        (element) {
          OrderModel data = OrderModel.fromJson(element);
          if (data.status == 1 || data.status == 2 || data.status == 3) {
            _orderList.add(data);
          } else {
            _orderOlder.add(data);
          }
        },
      );
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onOrderDetails(int id) {
    Get.delete<OrderDetailController>(force: true);
    Get.toNamed(AppRouter.getOrderDetail(), arguments: [id]);
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
