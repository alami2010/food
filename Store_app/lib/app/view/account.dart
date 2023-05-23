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
import 'package:vender/app/controller/account_controller.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/helper/navbar.dart';
import 'package:vender/app/util/theme.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (value) {
      return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/f5.jpg',
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: ThemeProvider.whiteColor, width: 4)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FadeInImage(
                          height: 80,
                          width: 80,
                          image: NetworkImage(
                              '${Environments.apiBaseURL}storage/images/${value.cover.toString()}'),
                          placeholder:
                              const AssetImage("assets/images/error.png"),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/error.png',
                                height: 80, width: 80, fit: BoxFit.fitWidth);
                          },
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      value.storeName,
                      style: const TextStyle(
                          fontFamily: 'semi-bold', fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: ThemeProvider.greyColor,
                        ),
                        Expanded(
                          child: Text(
                            value.address,
                            textAlign: TextAlign.center,
                            style:
                                const TextStyle(color: ThemeProvider.greyColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${value.openTime}-${value.closeTime}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: ThemeProvider.appColor, width: 2),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              value.onAddCategory();
                            },
                            child: Text(
                              'Your Category'.tr,
                              style: const TextStyle(
                                  fontSize: 16, fontFamily: 'semi-bold'),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: ThemeProvider.appColor,
                                      width: 2))),
                          child: InkWell(
                            onTap: () {
                              value.onFoodScreen();
                            },
                            child: Text(
                              'Your Food'.tr,
                              style: const TextStyle(
                                  fontSize: 16, fontFamily: 'semi-bold'),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: ThemeProvider.appColor,
                                      width: 2))),
                          child: InkWell(
                            onTap: () {
                              value.onEditProfile();
                            },
                            child: Text(
                              'Edit Profile'.tr,
                              style: const TextStyle(
                                  fontSize: 16, fontFamily: 'semi-bold'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    accountOptions(Icons.calendar_month, 'Orders'.tr, () {
                      value.onTabs();
                    }, value),
                    accountOptions(Icons.book_outlined, 'Bookings'.tr, () {
                      value.onBookings();
                    }, value),
                    accountOptions(Icons.reviews_outlined, 'Reviews'.tr, () {
                      value.onReviews();
                    }, value),
                    accountOptions(Icons.vpn_key_outlined, 'Change password'.tr,
                        () {
                      value.onForgotPassword();
                    }, value),
                    accountOptions(Icons.mail_outline, 'Contact Us'.tr, () {
                      value.onContactUs();
                    }, value),
                    accountOptions(Icons.translate, 'Languages'.tr, () {
                      value.onLanguage();
                    }, value),
                    accountOptions(Icons.chat_bubble_outline_sharp, 'Chats'.tr,
                        () {
                      value.onChatScreen();
                    }, value),
                    accountOptions(Icons.info_outline, 'About Us'.tr, () {
                      value.onAppPages('About Us', '1');
                    }, value),
                    accountOptions(Icons.flag_outlined, 'FAQs'.tr, () {
                      value.onAppPages('Frequently Asked Questions', '5');
                    }, value),
                    accountOptions(
                        Icons.privacy_tip_outlined, 'Terms & Conditions'.tr,
                        () {
                      value.onAppPages('Terms & Conditions', '3');
                    }, value),
                    accountOptions(Icons.lock_open, 'Privacy Policy'.tr, () {
                      value.onAppPages('Privacy Policy', '2');
                    }, value),
                    accountOptions(Icons.help_outline, 'Help'.tr, () {
                      value.onAppPages('Help', '6');
                    }, value),
                    accountOptions(Icons.logout, 'Log Out'.tr, () {
                      value.logout();
                    }, value),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget accountOptions(icon, text, route, value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
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
                  style: const TextStyle(fontSize: 16),
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
