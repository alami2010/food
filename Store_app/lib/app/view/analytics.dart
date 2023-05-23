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
import 'package:vender/app/controller/analytics_controller.dart';
import 'package:vender/app/util/constant.dart';
import 'package:vender/app/util/theme.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyticsController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeProvider.whiteColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Get Orders With Dates'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    value.openTimePicker();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(color: ThemeProvider.greyColor)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Open Time'.tr),
                            Text(value.openTime)
                          ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    value.closeTimePicker();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(color: ThemeProvider.greyColor)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Close Time'.tr),
                            Text(value.closeTime)
                          ]),
                    ),
                  ),
                ),
                Container(
                    height: 45,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        color: Colors.white),
                    child: ElevatedButton(
                        onPressed: () {
                          value.getResult();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: ThemeProvider.appColor,
                          onPrimary: ThemeProvider.whiteColor,
                          elevation: 0,
                        ),
                        child: Text(
                          'Get Results'.tr,
                          style: const TextStyle(
                              fontFamily: 'regular', fontSize: 16),
                        ))),
                value.haveData == true
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                AppConstants.appName,
                                style: TextStyle(
                                    color: ThemeProvider.secondaryAppColor,
                                    fontSize: 14,
                                    fontFamily: 'bold'),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${value.openTime} ${'to'.tr} ${value.closeTime}',
                                  style: const TextStyle(
                                      color: ThemeProvider.appColor,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    value.storeName,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: ThemeProvider.secondaryAppColor,
                                        fontSize: 9,
                                        fontFamily: 'bold'),
                                  ),
                                  Text(
                                    value.storeAddress,
                                    style: const TextStyle(
                                        color: ThemeProvider.blackColor,
                                        fontSize: 9,
                                        fontFamily: 'bold'),
                                  ),
                                  Text(
                                    value.storeZipcode,
                                    style: const TextStyle(
                                        color: ThemeProvider.blackColor,
                                        fontSize: 9,
                                        fontFamily: 'bold'),
                                  ),
                                  Text(
                                    value.storeEmail,
                                    style: const TextStyle(
                                        color: ThemeProvider.blackColor,
                                        fontSize: 9,
                                        fontFamily: 'bold'),
                                  ),
                                  Text(
                                    value.storeMobile,
                                    style: const TextStyle(
                                        color: ThemeProvider.blackColor,
                                        fontSize: 9,
                                        fontFamily: 'bold'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  value.todaysDate,
                                  style: const TextStyle(
                                      color: ThemeProvider.secondaryAppColor,
                                      fontFamily: 'bold',
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Total'.tr,
                                      style: const TextStyle(
                                          color:
                                              ThemeProvider.secondaryAppColor,
                                          fontSize: 10,
                                          fontFamily: 'bold'),
                                    ),
                                    Text(
                                      'Commission'.tr,
                                      style: const TextStyle(
                                          color:
                                              ThemeProvider.secondaryAppColor,
                                          fontSize: 10,
                                          fontFamily: 'bold'),
                                    ),
                                    Text(
                                      'Amount Received'.tr,
                                      style: const TextStyle(
                                          color:
                                              ThemeProvider.secondaryAppColor,
                                          fontSize: 10,
                                          fontFamily: 'bold'),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      value.currencySide == 'left'
                                          ? value.currencySymbol +
                                              value.totalAmount.toString()
                                          : value.totalAmount.toString() +
                                              value.currencySymbol,
                                      style: const TextStyle(
                                          color: ThemeProvider.blackColor,
                                          fontSize: 10,
                                          fontFamily: 'bold'),
                                    ),
                                    Text(
                                      value.currencySide == 'left'
                                          ? value.currencySymbol +
                                              value.commisionAmount.toString()
                                          : value.commisionAmount.toString() +
                                              value.currencySymbol,
                                      style: const TextStyle(
                                          color: ThemeProvider.blackColor,
                                          fontSize: 10,
                                          fontFamily: 'bold'),
                                    ),
                                    Text(
                                      value.currencySide == 'left'
                                          ? value.currencySymbol +
                                              value.commisionAmount.toString()
                                          : value.commisionAmount.toString() +
                                              value.currencySymbol,
                                      style: const TextStyle(
                                          color: ThemeProvider.blackColor,
                                          fontSize: 10,
                                          fontFamily: 'bold'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Id'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: ThemeProvider.secondaryAppColor,
                                        fontSize: 10),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Order on'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: ThemeProvider.secondaryAppColor,
                                        fontSize: 10),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Items'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: ThemeProvider.secondaryAppColor,
                                        fontSize: 10),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Total'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: ThemeProvider.secondaryAppColor,
                                        fontSize: 10),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Commission'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: ThemeProvider.secondaryAppColor,
                                        fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (var item in value.productList)
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: ThemeProvider.greyColor.withOpacity(0.3),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.id.toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: ThemeProvider.blackColor,
                                                fontSize: 8),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            item.createdAt.toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: ThemeProvider.blackColor,
                                                fontSize: 8),
                                          ),
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                                children: List.generate(
                                                    item.items!.length,
                                                    (index) {
                                              return TextSpan(
                                                text: (item.items!.length -
                                                            1) !=
                                                        index
                                                    ? '${item.items![index].name} , '
                                                    : item.items![index].name
                                                        .toString(),
                                                style: const TextStyle(
                                                    color: ThemeProvider
                                                        .blackColor,
                                                    fontSize: 8),
                                              );
                                            })),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            value.currencySide == 'left'
                                                ? value.currencySymbol +
                                                    item.grandTotal.toString()
                                                : item.grandTotal.toString() +
                                                    value.currencySymbol,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: ThemeProvider.blackColor,
                                                fontSize: 8),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            value.currencySide == 'left'
                                                ? value.currencySymbol +
                                                    value
                                                        .getCommission(
                                                            item.grandTotal)
                                                        .toString()
                                                : value
                                                        .getCommission(
                                                            item.grandTotal)
                                                        .toString() +
                                                    value.currencySymbol,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: ThemeProvider.blackColor,
                                                fontSize: 8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
