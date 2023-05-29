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
import 'package:foodies_user/app/backend/parse/await_payments_parse.dart';
import 'package:foodies_user/app/controller/tab_controller.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:foodies_user/app/util/theme.dart';

class AwaitPaymentsController extends GetxController implements GetxService {
  final AwaitPaymentsParser parser;
  String payMethod = '';
  String paymentURL = '';
  String apiURL = '';
  AwaitPaymentsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    apiURL = parser.apiService.appBaseUrl;
    payMethod = Get.arguments[0];
    if (payMethod == 'instamojo') {
      paymentURL = Get.arguments[1];
    } else {
      paymentURL = apiURL + Get.arguments[1];
    }
    debugPrint(paymentURL);
    debugPrint('paymethod name$payMethod');
    update();
  }

  void successPayments() {
    Get.defaultDialog(
      title: '',
      contentPadding: const EdgeInsets.all(20),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ThemeProvider.appColor,
                  borderRadius: BorderRadius.circular(100)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Thank You!'.tr,
              style: const TextStyle(fontFamily: 'bold', fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'For Your Order'.tr,
              style: const TextStyle(fontFamily: 'semi-bold', fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'
                  .tr,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                backOrders();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: ThemeProvider.whiteColor,
                backgroundColor: ThemeProvider.appColor,
                minimumSize: const Size.fromHeight(45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Track My Order'.tr.toUpperCase(),
                style: const TextStyle(
                  color: ThemeProvider.whiteColor,
                  fontSize: 14,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                backOrders();
              },
              child: Text(
                'Back To Home'.tr.toString(),
                style: const TextStyle(color: ThemeProvider.appColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void backOrders() {
    Get.offAllNamed(AppRouter.getTab());
    Get.find<TabsController>().updateIndex(1);
  }
}
