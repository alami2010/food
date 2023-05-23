import 'package:get/get_connect/http/src/response/response.dart';
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

class SavedAddressParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SavedAddressParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getSavedAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.getSavedAddress,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> deleteAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.deleteAddress,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}
