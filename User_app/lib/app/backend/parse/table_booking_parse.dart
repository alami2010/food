import 'package:get/get_connect.dart';
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

class TableBookingParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  TableBookingParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> tableBooking(var body) async {
    var response = await apiService.postPrivate(AppConstants.tableBooking, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }
}
