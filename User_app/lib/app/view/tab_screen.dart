/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:foodies_user/app/controller/tab_controller.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:foodies_user/app/view/account.dart';
import 'package:foodies_user/app/view/history.dart';
import 'package:foodies_user/app/view/home_screen.dart';
import 'package:foodies_user/app/view/my_cart.dart';
import 'package:get/get.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabsController>(builder: (value) {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: (TabBar(
            controller: value.tabController,
            labelColor: ThemeProvider.appColor,
            indicatorColor: ThemeProvider.appColor,
            unselectedLabelColor: ThemeProvider.greyColor,
            labelPadding: const EdgeInsets.symmetric(horizontal: 0),
            labelStyle: const TextStyle(
              fontFamily: 'regular',
              fontSize: 12,
            ),
            onTap: (int index) => value.updateIndex(index),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home_outlined,
                  color: value.currentIndex == 0
                      ? ThemeProvider.appColor
                      : ThemeProvider.greyColor,
                ),
                text: 'Home'.tr,
              ),
              Tab(
                icon: Icon(
                  Icons.history_outlined,
                  color: value.currentIndex == 1
                      ? ThemeProvider.appColor
                      : ThemeProvider.greyColor,
                ),
                text: 'History'.tr,
              ),
              Tab(
                icon: value.cartTotal > 0
                    ? badges.Badge(
                        badgeContent: Text(
                          value.cartTotal.toString(),
                          style:
                              const TextStyle(color: ThemeProvider.whiteColor),
                        ),
                        badgeStyle: const badges.BadgeStyle(
                          badgeColor: ThemeProvider.appColor,
                        ),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: value.currentIndex == 2
                              ? ThemeProvider.appColor
                              : ThemeProvider.greyColor,
                        ))
                    : Icon(
                        Icons.shopping_bag_outlined,
                        color: value.currentIndex == 2
                            ? ThemeProvider.appColor
                            : ThemeProvider.greyColor,
                      ),
                text: 'My Cart'.tr,
              ),
              Tab(
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: value.currentIndex == 3
                      ? ThemeProvider.appColor
                      : ThemeProvider.greyColor,
                ),
                text: 'Account'.tr,
              ),
            ],
          )),
          body: TabBarView(
            controller: value.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomeScreen(),
              HistoryScreen(),
              MyCartScreen(),
              AccountScreen(),
            ],
          ),
        ),
      );
    });
  }
}
