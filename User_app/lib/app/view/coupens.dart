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
import 'package:skeletons/skeletons.dart';
import 'package:upgrade/app/controller/coupens_controller.dart';
import 'package:upgrade/app/util/theme.dart';

class Coupens extends StatefulWidget {
  const Coupens({Key? key}) : super(key: key);

  @override
  State<Coupens> createState() => _CoupensState();
}

class _CoupensState extends State<Coupens> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoupensController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          actions: [
            IconButton(
                onPressed: () {
                  value.onBack();
                },
                icon: const Icon(Icons.close))
          ],
          title: Text(
            'Coupens'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: SkeletonListView(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    for (var item in value.offersList)
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            value.selectOffer(
                                item.id.toString(), item.name.toString());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Use coupon code '.tr +
                                          item.name.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'bold', fontSize: 14),
                                    ),
                                    Text(
                                        item.shortDescriptions.toString() +
                                            ' - Valid until '.tr +
                                            item.expire.toString(),
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12))
                                  ],
                                ),
                              ),
                              Icon(
                                value.offerId == item.id.toString()
                                    ? Icons.radio_button_checked
                                    : Icons.circle_outlined,
                                color: value.offerId == item.id.toString()
                                    ? ThemeProvider.appColor
                                    : ThemeProvider.greyColor,
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              value.addCoupen();
            },
            style: ElevatedButton.styleFrom(
              primary: ThemeProvider.appColor,
              onPrimary: ThemeProvider.whiteColor,
              minimumSize: const Size.fromHeight(45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Apply'.tr,
              style: const TextStyle(
                color: ThemeProvider.whiteColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    });
  }
}
