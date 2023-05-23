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
import 'package:vender/app/controller/tab_controller.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/helper/router.dart';
import 'package:vender/app/util/theme.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (value) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: ThemeProvider.appColor),
              accountName: Text(
                value.storeName,
                style: const TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                value.address,
                style: const TextStyle(color: Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: FadeInImage(
                    height: 90,
                    width: 90,
                    image: NetworkImage(
                        '${Environments.apiBaseURL}storage/images/${value.cover}'),
                    placeholder: const AssetImage("assets/images/error.png"),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/error.png',
                          fit: BoxFit.fitWidth);
                    },
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: Text('Home'.tr),
              onTap: () {
                Navigator.of(context).pop(true);

                Get.find<TabsController>().updateTabId(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text('Profile'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.find<TabsController>().updateTabId(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.translate),
              title: Text('Languages'.tr),
              onTap: () {
                Navigator.of(context).pop(true);

                Get.toNamed(
                  AppRouter.getLanguage(),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.mail_outline),
              title: Text('Contact Us'.tr),
              onTap: () {
                Navigator.of(context).pop(true);

                Get.toNamed(
                  AppRouter.getContactUs(),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text('About Us'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onAppPages('About Us', '1');
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag_outlined),
              title: Text('FAQs'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onAppPages('FAQs'.tr, '5');
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text('Terms & Conditions'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onAppPages('Terms & Conditions'.tr, '3');
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock_open),
              title: Text('Privacy Policy'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onAppPages('Privacy Policy'.tr, '2');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: Text('Help'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onAppPages('Help'.tr, '6');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Log Out'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.logout();
              },
            ),
          ],
        ),
      );
    });
  }
}
