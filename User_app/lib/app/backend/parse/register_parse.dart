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

class RegisterParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  RegisterParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> createAccount(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.register, body);
    return response;
  }

  Future<Response> saveReferral(dynamic body) async {
    var response = await apiService.postPrivate(AppConstants.referralCode, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  // void saveInfo(String token, String id) {
  //   sharedPreferencesManager.putString('token', token);
  //   sharedPreferencesManager.putString('uid', id);
  // }

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

  int getVerificationMethod() {
    return sharedPreferencesManager.getInt('user_verify_with') ??
        AppConstants.defaultVerificationForSignup;
  }

  String getSMSName() {
    return sharedPreferencesManager.getString('smsName') ??
        AppConstants.defaultSMSGateway;
  }

  Future<Response> sendVerificationMail(dynamic param) async {
    return await apiService.postPublic(
        AppConstants.sendVerificationMail, param);
  }

  Future<Response> verifyOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyOTP, param);
  }

  Future<Response> sendRegisterOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.sendVerificationSMS, param);
  }

  Future<Response> verifyMobileForeFirebase(dynamic param) async {
    return await apiService.postPublic(
        AppConstants.verifyMobileForeFirebase, param);
  }

  Future<Response> updateProfile(var body, var token) async {
    var response =
        await apiService.postPrivate(AppConstants.updateProfile, body, token);
    return response;
  }

  String getFcmToken() {
    return sharedPreferencesManager.getString('fcm_token') ?? 'NA';
  }
}
