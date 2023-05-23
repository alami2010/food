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
import 'package:vender/app/controller/tab_controller.dart';
import 'package:vender/app/util/theme.dart';
import 'package:vender/app/view/account.dart';
import 'package:vender/app/view/insights.dart';
import 'package:vender/app/view/order_screen.dart';

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
        length: 3,
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
                  Icons.fastfood,
                  color: value.currentIndex == 0
                      ? ThemeProvider.appColor
                      : ThemeProvider.greyColor,
                ),
                text: 'Orders'.tr,
              ),
              Tab(
                icon: Icon(
                  Icons.analytics_outlined,
                  color: value.currentIndex == 1
                      ? ThemeProvider.appColor
                      : ThemeProvider.greyColor,
                ),
                text: 'Analytics'.tr,
              ),
              Tab(
                icon: Icon(
                  Icons.person_outline,
                  color: value.currentIndex == 2
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
              OrderScreen(),
              InsightsScreen(),
              Account(),
            ],
          ),
        ),
      );
    });
  }
}
