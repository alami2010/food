/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vender/app/backend/api/api.dart';
import 'package:vender/app/backend/parse/account_parse.dart';
import 'package:vender/app/backend/parse/add_admin_category_parse.dart';
import 'package:vender/app/backend/parse/add_category_parse.dart';
import 'package:vender/app/backend/parse/add_food_parse.dart';
import 'package:vender/app/backend/parse/add_store_category_parse.dart';
import 'package:vender/app/backend/parse/all_categories_parse.dart';
import 'package:vender/app/backend/parse/analytics_parse.dart';
import 'package:vender/app/backend/parse/app_pages_parse.dart';
import 'package:vender/app/backend/parse/bookings_parse.dart';
import 'package:vender/app/backend/parse/chat_screen_parse.dart';
import 'package:vender/app/backend/parse/contact_us_parse.dart';
import 'package:vender/app/backend/parse/cuisine_parse.dart';
import 'package:vender/app/backend/parse/edit_profile_parse.dart';
import 'package:vender/app/backend/parse/foods_screen_parse.dart';
import 'package:vender/app/backend/parse/forgot_password_parse.dart';
import 'package:vender/app/backend/parse/insights_parse.dart';
import 'package:vender/app/backend/parse/language_parse.dart';
import 'package:vender/app/backend/parse/login_parse.dart';
import 'package:vender/app/backend/parse/message_screen_parse.dart';
import 'package:vender/app/backend/parse/new_password_parse.dart';
import 'package:vender/app/backend/parse/order_details_parse.dart';
import 'package:vender/app/backend/parse/order_screen_parse.dart';
import 'package:vender/app/backend/parse/reviews_parse.dart';
import 'package:vender/app/backend/parse/driver_list_parse.dart';
import 'package:vender/app/backend/parse/splash_screen_parse.dart';
import 'package:vender/app/backend/parse/stats_chart_parse.dart';
import 'package:vender/app/backend/parse/tab_parse.dart';
import 'package:vender/app/backend/parse/verification_parse.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/helper/shared_pref.dart';

class MainBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final sharedPref = await SharedPreferences.getInstance();
    Get.put(
      SharedPreferencesManager(sharedPreferences: sharedPref),
      permanent: true,
    );

    Get.lazyPut(() => ApiService(appBaseUrl: Environments.apiBaseURL));

    // Parser LazyLoad

    Get.lazyPut(
        () => LoginParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => ForgotPasswordParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => VerificationParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => NewPasswordParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => TabParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => OrderScreenParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => AnalyticsParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => AccountParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => ReviewsParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => AppPagesParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => ContactUsParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => LanguageParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => ChatScreenParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => MessageScreenParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => AddCategoryParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => FoodsScreenParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => AddFoodParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => AllCategoriesParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => EditProfileParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => AddStoreCategoryParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => AddAdminCategoryParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => OrderDetailsParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
      () => DriverListParse(
          apiService: Get.find(), sharedPreferencesManager: Get.find()),
      fenix: true,
    );
    Get.lazyPut(
        () => SplashScreenParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => BookingParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => InsightsParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => CuisineParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => StatsChartParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
  }
}
