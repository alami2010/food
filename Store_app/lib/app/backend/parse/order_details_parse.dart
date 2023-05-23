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

class OrderDetailsParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  OrderDetailsParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getOrderDetails(var body) async {
    var response = await apiService.postPrivate(AppConstants.getOrderDetail,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateOrderStatsu(var body) async {
    var response = await apiService.postPrivate(AppConstants.changeOrderStatus,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getLat() {
    return sharedPreferencesManager.getString('store_lat') ?? '';
  }

  String getLng() {
    return sharedPreferencesManager.getString('store_lng') ?? '';
  }

  int getDriverAssignmentType() {
    return sharedPreferencesManager.getInt('driverAssignment') ??
        AppConstants.defaultDriverAssignment;
  }

  Future<Response> getDriversNearMe() async {
    var response = await apiService.postPrivate(
        AppConstants.getNearDrivers,
        {"lat": getLat(), "lng": getLng()},
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
