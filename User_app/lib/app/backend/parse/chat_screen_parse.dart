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
import 'package:get/get.dart';
import 'package:foodies_user/app/util/constant.dart';

class ChatScreenParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ChatScreenParse(
      {required this.sharedPreferencesManager, required this.apiService});

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> getChatConversion(var uid) async {
    return await apiService.postPrivate(AppConstants.getChatConversionList,
        {'id': uid}, sharedPreferencesManager.getString('token') ?? '');
  }
}
