import 'package:get/get_connect.dart';
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
import 'package:vender/app/util/constant.dart';

class DriverListParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  DriverListParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getDriverList(var body) async {
    var response = await apiService.postPrivate(AppConstants.getNearDrivers,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}
