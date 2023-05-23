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
import 'package:get/get.dart';
import 'package:upgrade/app/util/constant.dart';

class ReferEarnParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ReferEarnParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getMyCode() async {
    return await apiService.postPrivate(
        AppConstants.getMyReferralCode,
        {'id': sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getName() {
    String firstName = sharedPreferencesManager.getString('first_name') ?? '';
    String lastName = sharedPreferencesManager.getString('last_name') ?? '';
    return '$firstName $lastName';
  }
}
