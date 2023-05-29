/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:foodies_user/app/controller/account_controller.dart';
import 'package:foodies_user/app/env.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:get/get.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: Text(
            'Profile'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              value.haveAccount == true
                  ? Container(
                      color: ThemeProvider.appColor,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: FadeInImage(
                                      height: 80,
                                      width: 80,
                                      image: NetworkImage(
                                          '${Environments.apiBaseURL}storage/images/${value.cover}'),
                                      placeholder: const AssetImage(
                                          "assets/images/error.png"),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/images/error.png',
                                            fit: BoxFit.fitWidth);
                                      },
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${value.firstName}  ${value.lastName}',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                value.email,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                value.onEditProfile();
                                              },
                                              child: Container(
                                                width: 70,
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(50.0),
                                                    ),
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        ThemeProvider
                                                            .whiteColor,
                                                        ThemeProvider
                                                            .whiteColor,
                                                      ],
                                                    )),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: Center(
                                                  child: Text(
                                                    'Edit'.tr,
                                                    style: const TextStyle(
                                                        color: ThemeProvider
                                                            .appColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 1),
                              blurRadius: 3),
                        ],
                      ),
                      child: Column(
                        children: [
                          value.haveAccount == false
                              ? buildRow(
                                  Icons.login_rounded, 'Sign In / Sign Up'.tr,
                                  () {
                                  value.onLogin();
                                }, value)
                              : const SizedBox(),
                          value.haveAccount == true
                              ? buildRow(
                                  Icons.list_alt_outlined, 'My Orders'.tr, () {
                                  value.onHistory();
                                }, value)
                              : const SizedBox(),
                          value.haveAccount == true
                              ? buildRow(
                                  Icons.book_outlined, 'Table Booking'.tr, () {
                                  value.onTableList();
                                }, value)
                              : const SizedBox(),
                          value.haveAccount == true
                              ? buildRow(
                                  Icons.favorite_outline, 'My Favorites'.tr,
                                  () {
                                  value.onMyFavorite();
                                }, value)
                              : const SizedBox(),
                          value.haveAccount == true
                              ? buildRow(Icons.home_outlined, 'Your Address'.tr,
                                  () {
                                  value.onSavedAddress();
                                }, value)
                              : const SizedBox(),
                          value.haveAccount == true
                              ? buildRow(Icons.account_balance_wallet_outlined,
                                  'Wallet'.tr, () {
                                  value.onWallet();
                                }, value)
                              : const SizedBox(),
                          value.haveAccount == true
                              ? buildRow(Icons.wallet_giftcard_outlined,
                                  'Refer & Earn'.tr, () {
                                  value.onReferEarn();
                                }, value)
                              : const SizedBox(),
                          buildRow(Icons.password, 'Change Password'.tr, () {
                            value.onChangePass();
                          }, value),
                          buildRow(Icons.translate_outlined, 'Languages'.tr,
                              () {
                            value.onLanguage();
                          }, value),
                          value.haveAccount == true
                              ? buildRow(Icons.chat_bubble_outline, 'Chats'.tr,
                                  () {
                                  value.onChatScreen();
                                }, value)
                              : const SizedBox(),
                          buildRow(Icons.info_outline, 'Contact Us'.tr, () {
                            value.onContactUs();
                          }, value),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 1),
                              blurRadius: 3),
                        ],
                      ),
                      child: Column(
                        children: [
                          buildRow(Icons.call_outlined, 'Help & Support'.tr,
                              () {
                            value.onAppPages('6', 'Help & Support'.tr);
                          }, value),
                          buildRow(Icons.help_outline,
                              'Frequently Asked Questions'.tr, () {
                            value.onAppPages(
                                '5', 'Frequently Asked Questions'.tr);
                          }, value),
                          buildRow(
                              Icons.list_alt_outlined, 'Terms & Conditions'.tr,
                              () {
                            value.onAppPages('3', 'Terms & Conditions'.tr);
                          }, value),
                          buildRow(Icons.people_alt_outlined, 'About Us'.tr,
                              () {
                            value.onAppPages('1', 'About Us'.tr);
                          }, value),
                          value.haveAccount == true
                              ? buildRow(Icons.logout_outlined, 'Log Out'.tr,
                                  () {
                                  value.logout();
                                }, value)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget buildRow(icon, text, route, value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: ThemeProvider.greyColor.shade300))),
      child: InkWell(
        onTap: route,
        child: Row(
          children: [
            Icon(
              icon,
              color: ThemeProvider.appColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style: const TextStyle(fontFamily: 'medium', fontSize: 16),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: ThemeProvider.greyColor,
            )
          ],
        ),
      ),
    );
  }
}
