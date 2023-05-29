/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:foodies_user/app/backend/api/api.dart';
import 'package:foodies_user/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/util/constant.dart';

class WalletParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  WalletParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getWallet() async {
    var response = await apiService.postPrivate(
        AppConstants.getWalletAmounts,
        {"id": sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
    return response;
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
