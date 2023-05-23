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

class ReviewsParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ReviewsParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getMyReviews() async {
    var response = await apiService.postPrivate(
        AppConstants.getMyReviews,
        {'id': sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}
