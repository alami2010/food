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

class ForgotPasswordParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ForgotPasswordParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> resetWithOTPMail(dynamic param) async {
    return await apiService.postPublic(AppConstants.resetWithEmail, param);
  }

  Future<Response> verifyOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyOTPForReset, param);
  }

  Future<Response> updatePassword(var param, String token) async {
    return await apiService.postPrivate(
        AppConstants.updatePasswordWithToken, param, token);
  }
}
