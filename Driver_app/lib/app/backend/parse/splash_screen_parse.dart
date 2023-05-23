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

class SplashScreenParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SplashScreenParse(
      {required this.sharedPreferencesManager, required this.apiService});

  bool isNewUser() {
    return sharedPreferencesManager.getBool('welcome');
  }

  void saveWelcome(bool value) {
    sharedPreferencesManager.putBool('welcome', value);
  }

  Future<Response> getAppSettings() async {
    return apiService.getPublic(AppConstants.appSettings);
  }

  Future<bool> initAppSettings() {
    return Future.value(true);
  }

  String getLanguagesCode() {
    return sharedPreferencesManager.getString('language') ?? 'en';
  }

  void saveBasicInfo(
      var currencyCode,
      var currencySide,
      var currencySymbol,
      var smsName,
      var verifyWith,
      var userLogin,
      var supportEmail,
      var appName,
      var shipping,
      var shippingPrice,
      var tax,
      var free,
      var appLogo,
      var supportName,
      var supportId,
      var supportPhone,
      var allowDistance) {
    sharedPreferencesManager.putString('currencyCode', currencyCode);
    sharedPreferencesManager.putString('currencySide', currencySide);
    sharedPreferencesManager.putString('currencySymbol', currencySymbol);
    sharedPreferencesManager.putString('smsName', smsName);
    sharedPreferencesManager.putInt('user_verify_with', verifyWith);
    sharedPreferencesManager.putInt('userLogin', userLogin);
    sharedPreferencesManager.putString('supportEmail', supportEmail);
    sharedPreferencesManager.putString('appName', appName);
    sharedPreferencesManager.putInt('shipping', shipping);
    sharedPreferencesManager.putDouble('shippingPrice', shippingPrice);
    sharedPreferencesManager.putDouble('tax', tax);
    sharedPreferencesManager.putDouble('free', free);
    sharedPreferencesManager.putString('appLogo', appLogo);
    sharedPreferencesManager.putInt('supportUID', supportId);
    sharedPreferencesManager.putString('supportName', supportName);
    sharedPreferencesManager.putString('supportPhone', supportPhone);
    sharedPreferencesManager.putDouble('allowDistance', allowDistance);
  }

  void saveDeviceToken(String token) {
    sharedPreferencesManager.putString('fcm_token', token);
  }
}
