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

class OrderScreenParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  OrderScreenParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getOrderList() async {
    var response = await apiService.postPrivate(AppConstants.orderList,
        {"id": getUid()}, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUid() {
    return sharedPreferencesManager.getString('uid') ?? '';
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
