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
import 'package:get/get.dart';
import 'package:vender/app/util/constant.dart';

class AnalyticsParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AnalyticsParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getResults(String from, String to) async {
    return await apiService.postPrivate(
        AppConstants.getStoreStatsWithDate,
        {
          'id': sharedPreferencesManager.getString('uid'),
          'from': from,
          'to': to
        },
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  String storeName() {
    return sharedPreferencesManager.getString('name') ?? '';
  }

  String storeAddress() {
    return sharedPreferencesManager.getString('address') ?? '';
  }

  String getMobile() {
    return sharedPreferencesManager.getString('mobile') ?? '';
  }

  String getZipcode() {
    return sharedPreferencesManager.getString('zipcode') ?? '';
  }

  String getEmail() {
    return sharedPreferencesManager.getString('email') ?? '';
  }
}
