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

class SearchParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SearchParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getSearchResult(String query) async {
    return await apiService.postPublic(AppConstants.searchQuery, {
      'param': query,
      "lat": getLat(),
      "lng": getLng(),
    });
  }

  double getLat() {
    return sharedPreferencesManager.getDouble('lat') ?? 0.0;
  }

  double getLng() {
    return sharedPreferencesManager.getDouble('lng') ?? 0.0;
  }
}
