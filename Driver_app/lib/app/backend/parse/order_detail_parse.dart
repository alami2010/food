/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/api/api.dart';
import 'package:driver/app/helper/shared_pref.dart';
import 'package:driver/app/util/constant.dart';
import 'package:get/get_connect.dart';

class OrderDetailParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  OrderDetailParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getOrderDetails(var body) async {
    var response = await apiService.postPrivate(AppConstants.orderDetail, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateOrderStatus(var body) async {
    var response = await apiService.postPrivate(
        AppConstants.updateOrderStatusFromDriver,
        body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getCurrencyCode() {
    return sharedPreferencesManager.getString('currencyCode') ??
        AppConstants.defaultCurrencyCode;
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }
}
