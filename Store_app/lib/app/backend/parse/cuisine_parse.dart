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

class CuisineParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  CuisineParser(
      {required this.apiService, required this.sharedPreferencesManager});
}
