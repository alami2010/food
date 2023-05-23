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
import 'package:jiffy/jiffy.dart';
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/models/orders_model.dart';
import 'package:vender/app/backend/parse/order_screen_parse.dart';
import 'package:vender/app/controller/order_details_controller.dart';
import 'package:vender/app/helper/router.dart';
import 'package:vender/app/util/constant.dart';

class OrderScreenController extends GetxController implements GetxService {
  final OrderScreenParse parser;

  List<OrdersModel> _latestOrder = <OrdersModel>[];
  List<OrdersModel> get lastestOrder => _latestOrder;

  List<OrdersModel> _ongonigOrder = <OrdersModel>[];
  List<OrdersModel> get ongoingOrder => _ongonigOrder;

  List<OrdersModel> _olderOrder = <OrdersModel>[];
  List<OrdersModel> get olderOrder => _olderOrder;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  bool apiCalled = false;

  bool loadMore = false;
  RxInt lastLimit = 1.obs;

  OrderScreenController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getOrderList();
  }

  Future<void> getOrderList() async {
    Response response = await parser.getOrderDetails();
    apiCalled = true;
    loadMore = false;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var order = myMap['data'];
      _latestOrder = [];
      _ongonigOrder = [];
      _olderOrder = [];
      order.forEach((data) {
        OrdersModel datas = OrdersModel.fromJson(data);
        datas.createdAt = Jiffy(datas.createdAt).yMMMdjm;
        if (datas.status == 0 || datas.status == 1) {
          _latestOrder.add(datas);
        } else if (datas.status == 2 || datas.status == 3) {
          _ongonigOrder.add(datas);
        } else {
          _olderOrder.add(datas);
        }
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onOrderDetails(int id) {
    Get.delete<OrderDetailsController>(force: true);
    Get.toNamed(AppRouter.getSingleOrderDetails(), arguments: [id]);
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
