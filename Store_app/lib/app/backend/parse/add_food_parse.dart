import 'package:get/get_connect.dart';
import 'package:image_picker/image_picker.dart';
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

class AddFoodParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AddFoodParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> uploadImage(XFile data) async {
    return await apiService
        .uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  Future<Response> saveFood(var body) async {
    var response = await apiService.postPrivate(AppConstants.saveFood, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getStoreId() {
    return sharedPreferencesManager.getString('id') ?? '';
  }

  Future<Response> getProductInfo(var body) async {
    var response = await apiService.postPrivate(AppConstants.getProductInfo,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateFood(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateFood, body,
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
