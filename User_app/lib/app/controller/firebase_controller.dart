/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/parse/firebase_parse.dart';
import 'package:foodies_user/app/controller/account_controller.dart';
import 'package:foodies_user/app/controller/history_controller.dart';
import 'package:foodies_user/app/controller/home_controller.dart';
import 'package:foodies_user/app/controller/login_controller.dart';
import 'package:foodies_user/app/controller/my_cart_controller.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:foodies_user/app/util/toast.dart';

class FirebaseController extends GetxController implements GetxService {
  final FirebaseParser parser;
  String countryCode = '';
  String phoneNumber = '';
  String apiURL = '';
  bool haveClicked = false;
  FirebaseController({required this.parser});

  @override
  void onInit() async {
    super.onInit();
    apiURL = parser.apiService.appBaseUrl;
    countryCode = Get.arguments[0];
    phoneNumber = Get.arguments[1];
  }

  Future<void> onLogin(context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    loginWithPhoneToken(context);
    showDialog(
        context: context,
        barrierColor: ThemeProvider.appColor,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(0.0),
            content: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                'Please wait'.tr,
                style: const TextStyle(
                    color: ThemeProvider.appColor,
                    fontFamily: 'bold',
                    fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
  }

  Future<void> loginWithPhoneToken(context) async {
    update();
    var param = {'country_code': countryCode, 'mobile': phoneNumber};
    Response response = await parser.loginWithPhoneToken(param);
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['user'] != '' &&
          myMap['token'] != '' &&
          myMap['user']['type'] == 1) {
        if (myMap['user']['status'] == 1) {
          debugPrint(myMap['user']['id'].toString());
          debugPrint(myMap['user']['email'].toString());
          debugPrint(myMap['user']['first_name'].toString());
          debugPrint(myMap['user']['last_name'].toString());
          debugPrint(myMap['user']['cover'].toString());

          parser.saveInfo(
            myMap['token'].toString(),
            myMap['user']['id'].toString(),
            myMap['user']['first_name'].toString(),
            myMap['user']['last_name'].toString(),
            myMap['user']['email'].toString(),
            myMap['user']['cover'].toString(),
            myMap['user']['mobile'].toString(),
          );

          Get.delete<HomeController>(force: true);
          Get.delete<HistoryController>(force: true);
          Get.delete<LoginController>(force: true);
          Get.delete<AccountController>(force: true);
          Get.find<MyCartController>().getCart();
          Get.offNamed(AppRouter.getTab());
        } else {
          showToast('Your account is suspended');
        }
      } else {
        showToast('Something went wrong while signup');
      }
      update();
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }
}
