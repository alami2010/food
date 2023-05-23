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

class AccountParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AccountParse(
      {required this.sharedPreferencesManager, required this.apiService});

  String storeName() {
    return sharedPreferencesManager.getString('name') ?? '';
  }

  String getCover() {
    return sharedPreferencesManager.getString('cover') ?? '';
  }

  String getAddress() {
    return sharedPreferencesManager.getString('address') ?? '';
  }

  String getOpenTime() {
    return sharedPreferencesManager.getString('opentime') ?? '';
  }

  String getCloseTime() {
    return sharedPreferencesManager.getString('closetime') ?? '';
  }

  Future<Response> logout() async {
    return await apiService.logout(
        AppConstants.logout, sharedPreferencesManager.getString('token') ?? '');
  }

  void clearAccount() {
    sharedPreferencesManager.clearKey('first_name');
    sharedPreferencesManager.clearKey('last_name');
    sharedPreferencesManager.clearKey('token');
    sharedPreferencesManager.clearKey('uid');
    sharedPreferencesManager.clearKey('email');
    sharedPreferencesManager.clearKey('cover');
  }
}
