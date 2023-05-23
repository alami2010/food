/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/api/handler.dart';
import 'package:driver/app/backend/parse/profile_parse.dart';
import 'package:driver/app/controller/app_pages_controller.dart';
import 'package:driver/app/controller/chat_screen_controller.dart';
import 'package:driver/app/controller/contact_us_controller.dart';
import 'package:driver/app/controller/edit_profile_controller.dart';
import 'package:driver/app/controller/language_controller.dart';
import 'package:driver/app/controller/reviews_controller.dart';
import 'package:driver/app/controller/tab_screen_controller.dart';
import 'package:driver/app/helper/router.dart';
import 'package:driver/app/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileParse parser;
  String cover = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  ProfileController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void onReviews() {
    Get.delete<ReviewsController>(force: true);
    Get.toNamed(AppRouter.getReviews());
  }

  void onForgotPassword() {
    Get.toNamed(AppRouter.getForgotPassword());
  }

  void onAppPages(String name, String id) {
    Get.delete<AppPagesController>(force: true);
    Get.toNamed(AppRouter.getAppPages(),
        arguments: [name, id], preventDuplicates: false);
  }

  void onContactUs() {
    Get.delete<ContactUsController>(force: true);
    Get.toNamed(AppRouter.getContactUs());
  }

  void onLanguage() {
    Get.delete<LanguageController>(force: true);
    Get.toNamed(AppRouter.getLanguage());
  }

  void onEditProfile() {
    Get.delete<EditProfileController>(force: true);
    Get.toNamed(AppRouter.getEditProfile());
  }

  void onTabs() {
    Get.find<TabsController>().updateTabId(0);
  }

  void changeInfo() {
    firstName = parser.getFirstName();
    lastName = parser.getLastName();
    email = parser.getEmail();
    cover = parser.getCover();
    debugPrint('Update');
    update();
  }

  void cleanData() {
    parser.clearAccount();
  }

  void getData() {
    cover = parser.getCover();
    firstName = parser.getFirstName();
    lastName = parser.getLastName();
    email = parser.getEmail();
  }

  void onChatScreen() {
    Get.delete<ChatScreenController>(force: true);
    Get.toNamed(AppRouter.getChatScreen());
  }

  Future<void> logout() async {
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
    Response response = await parser.logout();
    Get.back();
    if (response.statusCode == 200) {
      parser.clearAccount();
      Get.offAndToNamed(AppRouter.getLoginScreen());
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
