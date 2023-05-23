/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/api/handler.dart';
import 'package:driver/app/backend/parse/login_parse.dart';
import 'package:driver/app/controller/order_screen_controller.dart';
import 'package:driver/app/controller/profile_controller.dart';
import 'package:driver/app/controller/tab_screen_controller.dart';
import 'package:driver/app/helper/router.dart';
import 'package:driver/app/util/theme.dart';
import 'package:driver/app/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController implements GetxService {
  final LoginParse parser;

  final emailTextEditor = TextEditingController();
  final passwordTextEditor = TextEditingController();
  bool passwordVisible = false;

  LoginController({required this.parser});

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
      showToast('All fields are required');
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
          myMap['user']['type'] == 3) {
        if (myMap['user']['status'] == 1) {
          debugPrint(myMap['user']['id'].toString());
          parser.saveInfo(
            myMap['token'].toString(),
            myMap['user']['id'].toString(),
            myMap['user']['first_name'].toString(),
            myMap['user']['last_name'].toString(),
            myMap['user']['cover'].toString(),
            myMap['user']['email'].toString(),
          );
          var updateParam = {
            "id": myMap['user']['id'].toString(),
            'fcm_token': parser.getFcmToken(),
          };
          await parser.updateProfile(updateParam, myMap['token']);
          Get.delete<TabsController>(force: true);
          Get.delete<OrderScreenController>(force: true);
          Get.delete<ProfileController>(force: true);
          Get.offNamed(AppRouter.getTabScreen());
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

  void togglePasswordBtn() {
    passwordVisible = !passwordVisible;
    update();
  }

  void saveLanguage(String code) {
    parser.saveLanguage(code);
  }
}
