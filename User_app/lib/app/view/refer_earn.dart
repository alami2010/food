/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/controller/refer_earn_controller.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:get/get.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({Key? key}) : super(key: key);

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReferEarnController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          title: Text(
            'Refer & Earn'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/gift.png',
                      height: 80,
                      width: 80,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      value.referralData.title.toString(),
                      style: const TextStyle(fontFamily: 'bold', fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      value.referralData.message.toString(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: ThemeProvider.greyColor.shade400),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: value.myCode.toString(),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                value.copyToClipBoard();
                              },
                              icon: const Icon(Icons.copy))
                        ],
                      ),
                    )
                  ],
                ),
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              value.share();
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
              'Invite Friends'.tr.toUpperCase(),
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
