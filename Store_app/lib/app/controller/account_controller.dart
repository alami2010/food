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
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/parse/account_parse.dart';
import 'package:vender/app/controller/add_category_controller.dart';
import 'package:vender/app/controller/app_pages_controller.dart';
import 'package:vender/app/controller/bookings_controller.dart';
import 'package:vender/app/controller/chat_screen_controller.dart';
import 'package:vender/app/controller/contact_us_controller.dart';
import 'package:vender/app/controller/edit_profile_controller.dart';
import 'package:vender/app/controller/foods_screen_controller.dart';
import 'package:vender/app/controller/forgot_password_controller.dart';
import 'package:vender/app/controller/reviews_controller.dart';
import 'package:vender/app/controller/tab_controller.dart';
import 'package:vender/app/helper/router.dart';
import 'package:vender/app/util/theme.dart';

class AccountController extends GetxController implements GetxService {
  final AccountParse parser;

  String storeName = '';
  String cover = '';
  String address = '';
  String openTime = '';
  String closeTime = '';
  AccountController({required this.parser});

  @override
  void onInit() {
    debugPrint('api call');
    super.onInit();
    getData();
  }

  void getData() {
    storeName = parser.storeName();
    cover = parser.getCover();
    address = parser.getAddress();
    openTime = parser.getOpenTime();
    closeTime = parser.getCloseTime();
    update();
  }

  void onReviews() {
    Get.delete<ReviewsController>(force: true);
    Get.toNamed(AppRouter.getRevies());
  }

  void onBookings() {
    Get.delete<BookingsController>(force: true);
    Get.toNamed(AppRouter.getBookings());
  }

  void onForgotPassword() {
    Get.delete<ForgotPasswordController>(force: true);
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
    Get.toNamed(AppRouter.getLanguage());
  }

  void onChatScreen() {
    Get.delete<ChatScreenController>(force: true);
    Get.toNamed(AppRouter.getChatScreen());
  }

  void onAddCategory() {
    Get.delete<AddCategoryController>(force: true);
    Get.toNamed(AppRouter.getAddCategory());
  }

  void onFoodScreen() {
    Get.delete<FoodsScreenController>(force: true);
    Get.toNamed(AppRouter.getFoodScreen());
  }

  void onEditProfile() {
    Get.delete<EditProfileController>(force: true);
    Get.toNamed(AppRouter.getEditProfile());
  }

  void onTabs() {
    Get.find<TabsController>().updateTabId(0);
    // Get.toNamed(AppRouter.getTab());
  }

  void onLogin() {
    Get.offAndToNamed(AppRouter.getInitialRoute());
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
      onLogin();
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
