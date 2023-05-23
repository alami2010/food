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

class GiveReviewsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  GiveReviewsParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getStoreRatings(var id) async {
    return await apiService.postPrivate(AppConstants.getStoreRatings,
        {'id': id}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> saveStoreRating(var param) async {
    return await apiService.postPrivate(AppConstants.saveStoreRatings, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getProductRatings(var id) async {
    return await apiService.postPrivate(AppConstants.getProductRatings,
        {'id': id}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> saveProductRating(var param) async {
    return await apiService.postPrivate(AppConstants.saveProductRatings, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getDriverRatings(var id) async {
    return await apiService.postPrivate(AppConstants.getDriverRatings,
        {'id': id}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> saveDriversRatings(var param) async {
    return await apiService.postPrivate(AppConstants.saveDriverRatings, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }
}
