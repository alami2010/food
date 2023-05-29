/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/parse/web_payment_parse.dart';
import 'package:foodies_user/app/controller/checkout_controller.dart';
import 'package:foodies_user/app/controller/my_cart_controller.dart';
import 'package:foodies_user/app/controller/tab_controller.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:foodies_user/app/util/theme.dart';

class WebPaymentController extends GetxController implements GetxService {
  final WebPaymentParse parser;
  String payMethod = '';
  String paymentURL = '';
  String apiURL = '';
  WebPaymentController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    apiURL = parser.apiService.appBaseUrl;
    payMethod = Get.arguments[0];
    if (payMethod != 'instamojo') {
      paymentURL = apiURL + Get.arguments[1];
    } else {
      paymentURL = Get.arguments[1];
    }
    update();
  }

  Future<void> createOrder(String orderId) async {
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);

    var param = {
      "uid": parser.getUID(),
      "store_id": Get.find<CheckoutController>().storeInfo.uid,
      "address": Get.find<CheckoutController>().orderTo == 0
          ? jsonEncode(Get.find<CheckoutController>().addressInfo)
          : 'NA',
      "items": jsonEncode(Get.find<MyCartController>().savedInCart),
      "coupon_id": Get.find<CheckoutController>().selectedCoupon.code != null
          ? Get.find<CheckoutController>().selectedCoupon.id
          : 0,
      "coupon": Get.find<CheckoutController>().selectedCoupon.code != null
          ? jsonEncode(Get.find<CheckoutController>().selectedCoupon)
          : 'NA',
      "driver_id": 0,
      "delivery_charge": Get.find<CheckoutController>().deliveryPrice,
      "discount": Get.find<CheckoutController>().discount,
      "total": Get.find<MyCartController>().totalPrice,
      "serviceTax": Get.find<CheckoutController>().orderTax,
      "grand_total": Get.find<CheckoutController>().grandTotal,
      "pay_method": Get.find<CheckoutController>().paymentId,
      "paid": orderId,
      "notes": Get.find<MyCartController>().notesController.text != ''
          ? Get.find<MyCartController>().notesController.text
          : 'NA',
      "status": 0,
      "order_to": Get.find<CheckoutController>().orderTo,
      'wallet_used': Get.find<CheckoutController>().isWalletChecked == true &&
              Get.find<CheckoutController>().walletDiscount > 0
          ? 1
          : 0,
      'wallet_price': Get.find<CheckoutController>().isWalletChecked == true &&
              Get.find<CheckoutController>().walletDiscount > 0
          ? Get.find<CheckoutController>().walletDiscount
          : 0
    };
    debugPrint(param.toString());
    var response = await parser.createOrder(param);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      var notificationParam = {
        "title": "New Order",
        "message": "New Order is created",
        "id": Get.find<CheckoutController>().storeInfo.uid
      };
      await parser.sendNotification(notificationParam);
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
                  backHome();
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
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void backHome() {
    Get.find<MyCartController>().clearCart();
    Get.delete<MyCartController>(force: true);
    Get.offAllNamed(AppRouter.getTab());
    Get.find<TabsController>().updateIndex(0);
  }

  void backOrders() {
    Get.find<MyCartController>().clearCart();
    Get.delete<MyCartController>(force: true);
    Get.offAllNamed(AppRouter.getTab());
    Get.find<TabsController>().updateIndex(1);
  }

  Future<void> verifyRazorpayPurchase(String payKey) async {
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Creating Order".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    Response response = await parser.verifyPurchase(payKey);
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["success"];
      if (body['status'] == 'captured') {
        Get.back();
        createOrder(jsonEncode(body));
      }
    } else {
      Get.back();
      ApiChecker.checkApi(response);
    }
    update();
  }
}
