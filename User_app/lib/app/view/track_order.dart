/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:foodies_user/app/controller/track_order_controller.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/util/theme.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackOrderController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.whiteColor,
          iconTheme: const IconThemeData(color: ThemeProvider.blackColor),
          title: Text(
            'Track Order'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
      );
    });
  }
}
