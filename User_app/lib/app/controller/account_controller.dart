/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/parse/account_parse.dart';
import 'package:upgrade/app/controller/app_pages_controller.dart';
import 'package:upgrade/app/controller/chat_screen_controller.dart';
import 'package:upgrade/app/controller/my_favorites_controller.dart';
import 'package:upgrade/app/controller/refer_earn_controller.dart';
import 'package:upgrade/app/controller/saved_address_controller.dart';
import 'package:upgrade/app/controller/tab_controller.dart';
import 'package:upgrade/app/controller/table_list_controller.dart';
import 'package:upgrade/app/controller/wallet_controller.dart';
import 'package:upgrade/app/helper/router.dart';
import 'package:get/get.dart';
import 'package:upgrade/app/util/theme.dart';

class AccountController extends GetxController implements GetxService {
  final AccountParse parser;

  String cover = '';
  String firstName = '';
  String lastName = '';
  String email = '';

  bool haveAccount = false;

  AccountController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    haveAccount = parser.haveLoggedIn();
    if (haveAccount == true) {
      getData();
    }
    debugPrint(haveAccount.toString());
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

  void onSavedAddress() {
    Get.delete<SavedAddressController>(force: true);
    Get.toNamed(AppRouter.getSavedAddress());
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
      // Navigator.of(context).pop(true);
      parser.clearAccount();
      // Get.find<OrderController>().getOrder();
      haveAccount = false;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onLogin() {
    Get.toNamed(AppRouter.getLogin());
  }

  void onContactUs() {
    Get.toNamed(AppRouter.getContactUs());
  }

  void onMyFavorite() {
    Get.delete<MyFavoritesController>(force: true);
    Get.toNamed(AppRouter.getMyFavorite());
  }

  void onAppPages(String id, String name) {
    Get.delete<AppPagesController>(force: true);
    Get.toNamed(AppRouter.getAppPages(), arguments: [id, name]);
  }

  void onHistory() {
    Get.find<TabsController>().updateIndex(1);
  }

  void onWallet() {
    Get.delete<WalletController>(force: true);
    Get.toNamed(AppRouter.getWallet());
  }

  void onReferEarn() {
    Get.delete<ReferEarnController>(force: true);
    Get.toNamed(AppRouter.getReferEarn());
  }

  void onChangePass() {
    Get.toNamed(AppRouter.getForgotPassword());
  }

  void onLanguage() {
    Get.toNamed(AppRouter.getLangauge());
  }

  void onChatScreen() {
    Get.delete<ChatScreenController>(force: true);
    Get.toNamed(AppRouter.getChatScreen());
  }

  void onEditProfile() {
    Get.toNamed(AppRouter.getEditProfile());
  }

  void onTableList() {
    Get.delete<TableListController>(force: true);
    Get.toNamed(AppRouter.getTableList());
  }
}
