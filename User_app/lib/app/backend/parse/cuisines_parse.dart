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

class CuisinesParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  CuisinesParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getCuisinesData() async {
    var response = await apiService.getPublic(AppConstants.getCuisinesData);
    return response;
  }
}
