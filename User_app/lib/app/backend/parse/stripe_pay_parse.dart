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

class StripePayParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  StripePayParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getProfile() async {
    return await apiService.postPrivate(
        AppConstants.getUserProfile,
        {'id': sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getStripeCards(var id) async {
    return await apiService.postPrivate(AppConstants.getStripeCards, {'id': id},
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  Future<Response> createOrder(var param) async {
    return await apiService.postPrivate(AppConstants.createOrder, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> checkout(param) async {
    return await apiService.postPrivate(AppConstants.stripeCheckout, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> sendNotification(var body) async {
    var response = await apiService.postPrivate(AppConstants.sendNotification,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}
