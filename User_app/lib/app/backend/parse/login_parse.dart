/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:get/get.dart';
import 'package:foodies_user/app/backend/api/api.dart';
import 'package:foodies_user/app/helper/shared_pref.dart';
import 'package:foodies_user/app/util/constant.dart';

class LoginParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  LoginParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> onLogin(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.login, body);
    return response;
  }

  void saveInfo(String token, String id, String firstname, String lastname,
      String email, String cover, String phone) {
    sharedPreferencesManager.putString('token', token);
    sharedPreferencesManager.putString('uid', id);
    sharedPreferencesManager.putString('first_name', firstname);
    sharedPreferencesManager.putString('last_name', lastname);
    sharedPreferencesManager.putString('email', email);
    sharedPreferencesManager.putString('cover', cover);
    sharedPreferencesManager.putString('phone', phone);
  }

  String getSMSName() {
    return sharedPreferencesManager.getString('smsName') ??
        AppConstants.defaultSMSGateway;
  }

  int getUserLoginMethod() {
    return sharedPreferencesManager.getInt('userLogin') ??
        AppConstants.userLogin;
  }

  Future<Response> loginWithPhonePasswordPost(dynamic param) async {
    return await apiService.postPublic(
        AppConstants.loginWithPhonePassword, param);
  }

  Future<Response> verifyPhone(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyPhone, param);
  }

  Future<Response> verifyOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyOTP, param);
  }

  Future<Response> loginWithPhoneToken(dynamic param) async {
    return await apiService.postPublic(
        AppConstants.loginWithMobileToken, param);
  }

  Future<Response> verifyPhoneWithFirebase(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyPhoneFirebase, param);
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
