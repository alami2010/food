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

class AddNewAddressParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AddNewAddressParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> saveAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.saveAddress, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> getAddressById(var body) async {
    var response = await apiService.postPrivate(AppConstants.addressById, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateAddress,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> getLatLngFromAddress(String url) async {
    return await apiService.getOther(url);
  }
}
