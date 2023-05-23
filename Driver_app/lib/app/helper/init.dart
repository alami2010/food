/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/api/api.dart';
import 'package:driver/app/backend/parse/app_pages_parse.dart';
import 'package:driver/app/backend/parse/chat_screen_parse.dart';
import 'package:driver/app/backend/parse/contact_us_parse.dart';
import 'package:driver/app/backend/parse/edit_profile_parse.dart';
import 'package:driver/app/backend/parse/forgot_password_parse.dart';
import 'package:driver/app/backend/parse/language_parse.dart';
import 'package:driver/app/backend/parse/login_parse.dart';
import 'package:driver/app/backend/parse/message_parse.dart';
import 'package:driver/app/backend/parse/order_detail_parse.dart';
import 'package:driver/app/backend/parse/order_screen_parse.dart';
import 'package:driver/app/backend/parse/profile_parse.dart';
import 'package:driver/app/backend/parse/reviews_parse.dart';
import 'package:driver/app/backend/parse/splash_screen_parse.dart';
import 'package:driver/app/backend/parse/tab_screen_parse.dart';
import 'package:driver/app/backend/parse/tracking_parse.dart';
import 'package:driver/app/controller/order_screen_controller.dart';
import 'package:driver/app/controller/profile_controller.dart';
import 'package:driver/app/env.dart';
import 'package:driver/app/helper/shared_pref.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        () => TabParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => OrderScreenParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProfileParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => OrderDetailParse(
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
        () => EditProfileParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SplashScreenParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TrackingParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ChatScreenParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => MessageParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.put(() => OrderScreenController(parser: Get.find()));

    Get.put(() => ProfileController(parser: Get.find()));
  }
}
