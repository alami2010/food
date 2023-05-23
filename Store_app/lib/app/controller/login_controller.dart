/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/parse/login_parse.dart';
import 'package:vender/app/helper/router.dart';
import 'package:vender/app/util/theme.dart';
import 'package:vender/app/util/toast.dart';

class LoginController extends GetxController implements GetxService {
  final LoginParse parser;
  final emailTextEditor = TextEditingController();
  final passwordTextEditor = TextEditingController();

  LoginController({required this.parser});

  bool passwordVisible = false;

  @override
  void onInit() {
    debugPrint('api call');
    super.onInit();
    emailTextEditor.text = '';
    passwordTextEditor.text = '';
  }

  Future<void> onLogin() async {
    debugPrint(emailTextEditor.text);
    debugPrint(passwordTextEditor.text);
    if (emailTextEditor.text == '' ||
        emailTextEditor.text.isEmpty ||
        passwordTextEditor.text == '' ||
        passwordTextEditor.text.isEmpty) {
      showToast('All Fields Are Required');
      return;
    }
    if (!GetUtils.isEmail(emailTextEditor.text)) {
      showToast("Email is not valid");
      return;
    }
    var body = {
      "email": emailTextEditor.text,
      "password": passwordTextEditor.text
    };
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);

    var response = await parser.onLogin(body);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['user'] != '' &&
          myMap['token'] != '' &&
          myMap['user']['type'] == 2) {
        if (myMap['user']['status'] == 1) {
          debugPrint(myMap['user']['id'].toString());
          var openTime = myMap['store']['open_time'].split(':');
          if (openTime.isNotEmpty) {
            myMap['store']['open_time'] = Jiffy({
              "year": 2020,
              "month": 10,
              "day": 19,
              "hour": num.parse(openTime[0]).toInt(),
              "minute": num.parse(openTime[1]).toInt(),
            }).format("H:mm").toString();
          }

          var closeTime = myMap['store']['close_time'].split(':');
          if (closeTime.isNotEmpty) {
            myMap['store']['close_time'] = Jiffy({
              "year": 2020,
              "month": 10,
              "day": 19,
              "hour": num.parse(closeTime[0]).toInt(),
              "minute": num.parse(closeTime[1]).toInt(),
            }).format("H:mm").toString();
          }
          parser.saveInfo(
              myMap['token'].toString(),
              myMap['user']['id'].toString(),
              myMap['store']['name'].toString(),
              myMap['store']['address'].toString(),
              myMap['store']['open_time'].toString(),
              myMap['store']['close_time'].toString(),
              myMap['store']['cover'].toString(),
              myMap['store']['uid'].toString(),
              myMap['store']['lat'].toString(),
              myMap['store']['lng'].toString(),
              myMap['user']['email'].toString(),
              myMap['store']['mobile'].toString(),
              myMap['store']['pincode'].toString());
          var updateParam = {
            "id": myMap['user']['id'].toString(),
            'fcm_token': parser.getFcmToken(),
          };
          await parser.updateProfile(updateParam, myMap['token']);
          Get.offNamed(AppRouter.getTab());
        } else {
          showToast('Your account is suspended');
        }
      } else {
        showToast('Something went wrong while signup');
      }
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  void onForgotPassword() {
    Get.toNamed(AppRouter.getForgotPassword());
  }

  void onTabsScreen() {
    Get.toNamed(AppRouter.getTab());
  }

  void togglePasswordBtn() {
    passwordVisible = !passwordVisible;
    update();
  }

  void saveLanguage(String code) {
    parser.saveLanguage(code);
  }
}
