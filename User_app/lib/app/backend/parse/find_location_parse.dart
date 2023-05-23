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

class FindLocationParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  FindLocationParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getPlacesList(url) async {
    var response = await apiService.getOther(url);
    return response;
  }

  void saveLatLng(var lat, var lng, var address) {
    sharedPreferencesManager.putDouble('lat', lat);
    sharedPreferencesManager.putDouble('lng', lng);
    sharedPreferencesManager.putString('address', address);
  }
}
