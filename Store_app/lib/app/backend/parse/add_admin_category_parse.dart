import 'package:get/get.dart';
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

class AddAdminCategoryParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AddAdminCategoryParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getMasterCategory() async {
    var response = await apiService.getPrivate(AppConstants.masterCategory,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateMaster(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateMaster, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getStoreId() {
    return sharedPreferencesManager.getString('id') ?? '';
  }
}
