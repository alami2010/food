/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/controller/profile_controller.dart';
import 'package:driver/app/env.dart';
import 'package:driver/app/helper/navbar.dart';
import 'package:driver/app/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (value) {
      return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: const BoxDecoration(color: ThemeProvider.appColor),
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
                          placeholder:
                              const AssetImage("assets/images/error.png"),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/error.png',
                                fit: BoxFit.fitWidth);
                          },
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${value.firstName}  ${value.lastName}',
                              style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontSize: 18,
                                  fontFamily: 'semi-bold'),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              value.email,
                              style: const TextStyle(
                                  color: ThemeProvider.whiteColor),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ThemeProvider.whiteColor),
                              child: InkWell(
                                onTap: () {
                                  value.onEditProfile();
                                },
                                child: Text(
                                  'Edit Profile'.tr,
                                  style:
                                      const TextStyle(fontFamily: 'semi-bold'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    accountOptions(Icons.calendar_month, 'Orders'.tr, () {
                      value.onTabs();
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
