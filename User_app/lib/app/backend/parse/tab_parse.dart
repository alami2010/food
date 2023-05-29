/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:foodies_user/app/backend/api/api.dart';
import 'package:foodies_user/app/helper/shared_pref.dart';

class TabParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  TabParse({required this.sharedPreferencesManager, required this.apiService});

  void cleanData() {
    sharedPreferencesManager.clearKey('token');
    sharedPreferencesManager.clearKey('uid');
    sharedPreferencesManager.clearKey('firstName');
    sharedPreferencesManager.clearKey('lastName');
    sharedPreferencesManager.clearKey('email');
    sharedPreferencesManager.clearKey('cover');
    sharedPreferencesManager.clearKey('phone');
  }
}
