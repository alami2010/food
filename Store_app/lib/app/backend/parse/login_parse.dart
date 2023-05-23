import 'package:get/get.dart';
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

class LoginParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  LoginParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> onLogin(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.login, body);
    return response;
  }

  void saveInfo(
      String token,
      String id,
      String name,
      String address,
      String opentime,
      String closetime,
      String cover,
      String uid,
      String lat,
      String lng,
      String email,
      String mobile,
      String zipcode) {
    sharedPreferencesManager.putString('token', token);
    sharedPreferencesManager.putString('id', id);
    sharedPreferencesManager.putString('name', name);
    sharedPreferencesManager.putString('address', address);
    sharedPreferencesManager.putString('opentime', opentime);
    sharedPreferencesManager.putString('closetime', closetime);
    sharedPreferencesManager.putString('cover', cover);
    sharedPreferencesManager.putString('uid', uid);
    sharedPreferencesManager.putString('store_lat', lat);
    sharedPreferencesManager.putString('store_lng', lng);
    sharedPreferencesManager.putString('email', email);
    sharedPreferencesManager.putString('mobile', mobile);
    sharedPreferencesManager.putString('zipcode', zipcode);
  }

  void saveLanguage(String code) {
    sharedPreferencesManager.putString('language', code);
  }

  String getFcmToken() {
    return sharedPreferencesManager.getString('fcm_token') ?? 'NA';
  }

  Future<Response> updateProfile(var body, var token) async {
    var response =
        await apiService.postPrivate(AppConstants.updateProfile, body, token);
    return response;
  }
}
