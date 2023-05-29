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
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/models/stripe_model.dart';
import 'package:foodies_user/app/backend/parse/stripe_pay_parse.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/controller/add_card_controller.dart';
import 'package:foodies_user/app/controller/checkout_controller.dart';
import 'package:foodies_user/app/controller/my_cart_controller.dart';
import 'package:foodies_user/app/controller/tab_controller.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:foodies_user/app/util/constant.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:foodies_user/app/util/toast.dart';

class StripePayController extends GetxController implements GetxService {
  final StripePayParse parser;
  bool apiCalled = false;
  bool cardsListCalled = false;
  List<StripeCardsModel> _cards = <StripeCardsModel>[];
  List<StripeCardsModel> get cards => _cards;
  String stripeKey = '';
  String selectedCard = '';

  double grandTotal = 0.0;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencyCode = '';
  StripePayController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    grandTotal = Get.arguments[0];
    currencyCode = Get.arguments[1];
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getProfile();
  }

  Future<void> getProfile() async {
    Response response = await parser.getProfile();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body != null && body != '') {
        stripeKey = body['stripe_key'] ?? '';
        getStringCards();
        update();
      }
    } else {
      cardsListCalled = true;
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  Future<void> getStringCards() async {
    if (stripeKey != '' && stripeKey.isNotEmpty) {
      Response response = await parser.getStripeCards(stripeKey);
      cardsListCalled = true;
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["success"];
        _cards = [];
        body['data'].forEach((data) {
          StripeCardsModel datas = StripeCardsModel.fromJson(data);
          _cards.add(datas);
        });
      } else {
        cardsListCalled = true;
        ApiChecker.checkApi(response);
        update();
      }
      update();
    } else {
      cardsListCalled = true;
      update();
    }
  }

  void onAddCard() {
    Get.delete<AddCardController>(force: true);
    Get.toNamed(AppRouter.getAddCard());
  }

  void saveCardToPay(String id) {
    selectedCard = id;
    update();
  }

  void createPayment() {
    if (selectedCard != '' && selectedCard.isNotEmpty) {
      Get.generalDialog(
          pageBuilder: (context, __, ___) => AlertDialog(
                title: Text('Are you sure?'.tr),
                content: Text(
                    "Orders once placed cannot be cancelled and are non-refundable"
                        .tr),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel'.tr,
                      style: const TextStyle(
                          color: ThemeProvider.blackColor,
                          fontFamily: 'medium'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      makePayment();
                    },
                    child: Text(
                      'Yes, Place Order'.tr,
                      style: const TextStyle(
                          color: ThemeProvider.appColor, fontFamily: 'bold'),
                    ),
                  )
                ],
              ));
    } else {
      showToast('Please select card');
    }
  }

  Future<void> makePayment() async {
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
    var param = {
      'amount': grandTotal.toInt() * 100,
      'currency': currencyCode,
      'customer': stripeKey,
      'card': selectedCard
    };
    Response response = await parser.checkout(param);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic successResponse = myMap["success"];
      createOrder(successResponse);
    } else {
      Get.back();
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  Future<void> createOrder(dynamic paymentInfo) async {
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
      "grand_total": grandTotal,
      "pay_method": Get.find<CheckoutController>().paymentId,
      "paid": jsonEncode(paymentInfo),
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
                  'Back To Home'.tr.toUpperCase(),
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
    Get.offAllNamed(AppRouter.getTab());
    Get.find<TabsController>().updateIndex(0);
  }

  void backOrders() {
    Get.find<MyCartController>().clearCart();
    Get.offAllNamed(AppRouter.getTab());
    Get.find<TabsController>().updateIndex(1);
  }
}
