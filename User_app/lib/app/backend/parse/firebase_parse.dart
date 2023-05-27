import 'package:get/get.dart';
/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:upgrade/app/backend/api/api.dart';
import 'package:upgrade/app/helper/shared_pref.dart';
import 'package:upgrade/app/util/constant.dart';

class FirebaseParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  FirebaseParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> loginWithPhoneToken(dynamic param) async {
    return await apiService.postPublic(
        AppConstants.loginWithMobileToken, param);
  }

  void saveInfo(String token, String uid, String firstName, String lastName,
      String email, String cover, String phone) {
    sharedPreferencesManager.putString('token', token);
    sharedPreferencesManager.putString('uid', uid);
    sharedPreferencesManager.putString('firstName', firstName);
    sharedPreferencesManager.putString('lastName', lastName);
    sharedPreferencesManager.putString('email', email);
    sharedPreferencesManager.putString('cover', cover);
    sharedPreferencesManager.putString('phone', phone);
  }

  Future<Response> updateProfile(dynamic param) async {
    return await apiService.postPrivate(AppConstants.updateProfile, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getFcmToken() {
    return sharedPreferencesManager.getString('fcm_token') ?? 'NA';
  }
}
