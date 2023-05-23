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

class AwaitPaymentsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AwaitPaymentsParser(
      {required this.sharedPreferencesManager, required this.apiService});
}
