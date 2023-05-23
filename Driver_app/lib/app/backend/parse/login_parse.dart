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
    String uid,
    String firstname,
    String lastname,
    String cover,
    String email,
  ) {
    sharedPreferencesManager.putString('token', token);
    sharedPreferencesManager.putString('uid', uid);
    sharedPreferencesManager.putString('first_name', firstname);
    sharedPreferencesManager.putString('last_name', lastname);
    sharedPreferencesManager.putString('cover', cover);
    sharedPreferencesManager.putString('email', email);
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
