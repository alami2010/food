import 'package:get/get_connect.dart';
/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:vender/app/backend/api/api.dart';
import 'package:vender/app/helper/shared_pref.dart';
import 'package:vender/app/util/constant.dart';

class OrderScreenParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  OrderScreenParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getOrderDetails() async {
    var response = await apiService.postPrivate(
        AppConstants.getOrders,
        {'id': sharedPreferencesManager.getString('uid') ?? ''},
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
