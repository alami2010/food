/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/models/address_model.dart';
import 'package:foodies_user/app/backend/models/offers_model.dart';
import 'package:foodies_user/app/backend/models/payment_models.dart';
import 'package:foodies_user/app/backend/models/store_models.dart';
import 'package:foodies_user/app/backend/parse/checkout_parse.dart';
import 'package:foodies_user/app/controller/coupens_controller.dart';
import 'package:foodies_user/app/controller/delivery_address_controller.dart';
import 'package:foodies_user/app/controller/my_cart_controller.dart';
import 'package:foodies_user/app/controller/stripe_pay_controller.dart';
import 'package:foodies_user/app/controller/tab_controller.dart';
import 'package:foodies_user/app/controller/web_payment_controller.dart';
import 'package:foodies_user/app/env.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/util/constant.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:foodies_user/app/util/toast.dart';

class CheckoutController extends GetxController implements GetxService {
  final CheckoutParse parser;
  int method = 1;
  bool isWalletChecked = false;

  bool haveAddress = false;
  bool apiCalled = false;

  String offerId = '';
  String offerName = '';
  String address = '';

  AddressModel _addressInfo = AddressModel();
  AddressModel get addressInfo => _addressInfo;

  List<AddressModel> _addressList = <AddressModel>[];
  List<AddressModel> get addressList => _addressList;

  List<PaymentModel> _paymentList = <PaymentModel>[];
  List<PaymentModel> get paymentList => _paymentList;

  late OffersModel _selectedCoupon = OffersModel();
  OffersModel get selectedCoupon => _selectedCoupon;

  double _discount = 0.0;
  double get discount => _discount;

  double _orderTax = 0.0;
  double get orderTax => _orderTax;

  double _shippingPrice = 0.0;
  double get shippingPrice => _shippingPrice;

  double _deliveryPrice = 0.0;
  double get deliveryPrice => _deliveryPrice;

  double _freeShipping = 0.0;
  double get freeShipping => _freeShipping;

  StoreModal _storeInfo = StoreModal();
  StoreModal get storeInfo => _storeInfo;

  int _shippingMethod = AppConstants.defaultShippingMethod;
  int get shippingMethod => _shippingMethod;

  double _grandTotal = 0.0;
  double get grandTotal => _grandTotal;

  int orderTo = 0; // 0 = home /// 1 = self

  int paymentId = 0;
  String payMethodName = '';
  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  bool haveFairDeliveryRadius = false;

  double balance = 0.0;
  double walletDiscount = 0.0;
  CheckoutController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    _shippingMethod = parser.getShippingMethod();
    _shippingPrice = parser.shippingPrice();
    _freeShipping = parser.freeOrderPrice();
    _orderTax = parser.taxOrderPrice();
    getMyWalletAmount();
    getSavedAddress();
    getStoreInfo();
    getPaymentMethods();
    calculateAllCharge();
  }

  void updateWalletChecked(bool status) {
    isWalletChecked = status;
    calculateAllCharge();
    update();
  }

  void onSaveCoupon(OffersModel offer) {
    _selectedCoupon = offer;
    update();
    calculateAllCharge();
  }

  Future<void> getMyWalletAmount() async {
    Response response = await parser.getMyWalletBalance();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body != null &&
          body != '' &&
          body['balance'] != null &&
          body['balance'] != '') {
        balance = double.tryParse(body['balance'].toString()) ?? 0.0;
        walletDiscount = double.tryParse(body['balance'].toString()) ?? 0.0;
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void calculateDistance() {
    if (addressInfo.lat != null &&
        addressInfo.lng != null &&
        storeInfo.lat != null &&
        storeInfo.lng != null) {
      double storeDistance = 0.0;
      double totalMeters = 0.0;
      storeDistance = Geolocator.distanceBetween(
        double.tryParse(addressInfo.lat.toString()) ?? 0.0,
        double.tryParse(addressInfo.lng.toString()) ?? 0.0,
        double.tryParse(storeInfo.lat.toString()) ?? 0.0,
        double.tryParse(storeInfo.lng.toString()) ?? 0.0,
      );
      totalMeters = totalMeters + storeDistance;
      double distance = double.parse((storeDistance / 1000).toStringAsFixed(2));
      debugPrint(distance.toString());
      if (distance > parser.getAllowedDeliveryRadius()) {
        haveFairDeliveryRadius = false;
        showToast(
            'Sorry we deliver the order near to ${parser.getAllowedDeliveryRadius()}KM');
      } else {
        if (shippingMethod == 0) {
          double distancePricer = distance * shippingPrice;
          _deliveryPrice = double.parse((distancePricer).toStringAsFixed(2));
        } else {
          _deliveryPrice = shippingPrice;
        }
        haveFairDeliveryRadius = true;
      }
      calculateAllCharge();
      update();
    }
  }

  void calculateAllCharge() {
    double totalPrice =
        Get.find<MyCartController>().totalPrice + orderTax + deliveryPrice;
    if (_selectedCoupon.discount != null && _selectedCoupon.discount != 0) {
      double percentage(numFirst, per) {
        return (numFirst / 100) * per;
      }

      _discount = percentage(Get.find<MyCartController>().totalPrice,
          _selectedCoupon.discount); // null
    }
    walletDiscount = balance;
    if (isWalletChecked == true) {
      if (totalPrice <= walletDiscount) {
        walletDiscount = totalPrice;
        totalPrice = totalPrice - walletDiscount;
      } else {
        totalPrice = totalPrice - walletDiscount;
      }
    } else {
      if (totalPrice <= discount) {
        _discount = totalPrice;
        totalPrice = totalPrice - discount;
      } else {
        totalPrice = totalPrice - discount;
      }
    }
    debugPrint('grand total $totalPrice');
    _grandTotal = double.parse((totalPrice).toStringAsFixed(2));
    update();
  }

  Future<void> getStoreInfo() async {
    var id = Get.find<MyCartController>().savedInCart[0].storeId;
    Response response = await parser.getStoreInfo(id);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _storeInfo = StoreModal();
      var body = myMap['data'];
      StoreModal datas = StoreModal.fromJson(body);
      _storeInfo = datas;
      calculateDistance();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getSavedAddress() async {
    var param = {"id": parser.getUID()};
    Response response = await parser.getSavedAddress(param);
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _addressInfo = AddressModel();
      var address = myMap['data'];
      _addressList = [];
      if (address.length > 0) {
        haveAddress = true;
        update();
        AddressModel addressData = AddressModel.fromJson(address[0]);
        _addressInfo = addressData;
        _addressList = [];
        address.forEach((add) {
          AddressModel adds = AddressModel.fromJson(add);
          _addressList.add(adds);
        });
        calculateDistance();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getPaymentMethods() async {
    Response response = await parser.getPayments();
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var payment = myMap['data'];
      _paymentList = [];
      payment.forEach((pay) {
        PaymentModel pays = PaymentModel.fromJson(pay);
        _paymentList.add(pays);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onSavedAddress() {
    Get.delete<DeliveryAddressController>(force: true);
    Get.toNamed(AppRouter.getDeliveryAddress());
  }

  void saveDeliveryAddressId(int id) {
    debugPrint('got id from delivery address$id');
    _addressInfo = _addressList.firstWhere((element) => element.id == id);
    calculateDistance();
    update();
  }

  void selectPaymentMethod(int id) {
    paymentId = id;
    if (paymentId == 1) {
      payMethodName = 'cod';
    } else if (paymentId == 2) {
      payMethodName = 'stripe';
    } else if (paymentId == 3) {
      payMethodName = 'paypal';
    } else if (paymentId == 4) {
      payMethodName = 'paytm';
    } else if (paymentId == 5) {
      payMethodName = 'razorpay';
    } else if (paymentId == 6) {
      payMethodName = 'instamojo';
    } else if (paymentId == 7) {
      payMethodName = 'paystack';
    } else if (paymentId == 8) {
      payMethodName = 'flutterwave';
    }
    update();
  }

  void onPayment() {
    if (paymentId == 0) {
      showToast('Please select payment method');
      return;
    }
    Get.defaultDialog(
      title: '',
      contentPadding: const EdgeInsets.all(20),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/sure.png',
              fit: BoxFit.cover,
              height: 80,
              width: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Are you sure'.tr,
              style: const TextStyle(fontSize: 24, fontFamily: 'semi-bold'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                'Orders once placed cannot be cancelled and non-refundable'.tr),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      var context = Get.context as BuildContext;
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: ThemeProvider.whiteColor,
                      backgroundColor: ThemeProvider.greyColor,
                      minimumSize: const Size.fromHeight(35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Cancel'.tr,
                      style: const TextStyle(
                        color: ThemeProvider.whiteColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      var context = Get.context as BuildContext;
                      Navigator.pop(context);
                      onCheckout();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: ThemeProvider.whiteColor,
                      backgroundColor: ThemeProvider.appColor,
                      minimumSize: const Size.fromHeight(35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Place Order'.tr,
                      style: const TextStyle(
                        color: ThemeProvider.whiteColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onCheckout() {
    if (paymentId == 1) {
      createOrder();
      // cod
      //  Order API call
    } else if (paymentId == 2) {
      Get.delete<StripePayController>(force: true);
      var gateway = paymentList.firstWhereOrNull(
          (element) => element.id.toString() == paymentId.toString());
      // stripe payment
      Get.toNamed(AppRouter.getStripePay(),
          arguments: [grandTotal, gateway!.currencyCode.toString()]);
    } else if (paymentId == 3) {
      Get.delete<WebPaymentController>(force: true);
      var paymentURL = AppConstants.payPalPayLink + grandTotal.toString();
      Get.toNamed(AppRouter.getWebPayment(),
          arguments: [payMethodName, paymentURL]);
      // paypal
    } else if (paymentId == 4) {
      // paytm
      Get.delete<WebPaymentController>(force: true);
      var paymentURL = AppConstants.payTmPayLink + grandTotal.toString();
      Get.toNamed(AppRouter.getWebPayment(),
          arguments: [payMethodName, paymentURL]);
    } else if (paymentId == 5) {
      // razorpay
      Get.delete<WebPaymentController>(force: true);
      var paymentPayLoad = {
        'amount':
            double.parse((grandTotal * 100).toStringAsFixed(2)).toString(),
        'email': parser.getEmail(),
        'logo':
            '${parser.apiService.appBaseUrl}storage/images/${parser.getAppLogo()}',
        'name': parser.getName(),
        'app_color': '#f47878'
      };

      String queryString = Uri(queryParameters: paymentPayLoad).query;
      var paymentURL = AppConstants.razorPayLink + queryString;

      Get.toNamed(AppRouter.getWebPayment(),
          arguments: [payMethodName, paymentURL]);
    } else if (paymentId == 6) {
      payWithInstaMojo();
      // instamojo
    } else if (paymentId == 7) {
      var rng = Random();
      var paykey = List.generate(12, (_) => rng.nextInt(100));
      Get.delete<WebPaymentController>(force: true);
      var paymentPayLoad = {
        'email': parser.getEmail(),
        'amount':
            double.parse((grandTotal * 100).toStringAsFixed(2)).toString(),
        'first_name': parser.getFirstName(),
        'last_name': parser.getLastName(),
        'ref': paykey.join()
      };
      String queryString = Uri(queryParameters: paymentPayLoad).query;
      var paymentURL = AppConstants.paystackCheckout + queryString;

      Get.toNamed(AppRouter.getWebPayment(),
          arguments: [payMethodName, paymentURL]);
      // paystock
    } else if (paymentId == 8) {
      //flutterwave
      Get.delete<WebPaymentController>(force: true);
      var gateway = paymentList.firstWhereOrNull(
          (element) => element.id.toString() == paymentId.toString());
      var paymentPayLoad = {
        'amount': grandTotal.toString(),
        'email': parser.getEmail(),
        'phone': parser.getPhone(),
        'name': parser.getName(),
        'code': gateway!.currencyCode.toString(),
        'logo':
            '${parser.apiService.appBaseUrl}storage/images/${parser.getAppLogo()}',
        'app_name': Environments.appName
      };

      String queryString = Uri(queryParameters: paymentPayLoad).query;
      var paymentURL = AppConstants.flutterwaveCheckout + queryString;

      Get.toNamed(AppRouter.getWebPayment(),
          arguments: [payMethodName, paymentURL]);
    }
  }

  Future<void> payWithInstaMojo() async {
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
      'allow_repeated_payments': 'False',
      'amount': grandTotal,
      'buyer_name': parser.getName(),
      'purpose': 'Orders',
      'redirect_url': '${parser.apiService.appBaseUrl}/api/v1/success_payments',
      'phone': parser.getPhone() != '' ? parser.getPhone() : '8888888888888888',
      'send_email': 'True',
      'webhook': parser.apiService.appBaseUrl,
      'send_sms': 'True',
      'email': parser.getEmail()
    };
    Response response = await parser.getInstaMojoPayLink(param);
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["success"];
      if (body['payment_request'] != '' &&
          body['payment_request']['longurl'] != '') {
        Get.delete<WebPaymentController>(force: true);
        var paymentURL = body['payment_request']['longurl'];
        Get.toNamed(AppRouter.getWebPayment(),
            arguments: [payMethodName, paymentURL]);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> createOrder() async {
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
      "store_id": storeInfo.uid,
      "address": orderTo == 0 ? jsonEncode(addressInfo) : 'NA',
      "items": jsonEncode(Get.find<MyCartController>().savedInCart),
      "coupon_id": selectedCoupon.code != null ? selectedCoupon.id : 0,
      "coupon": selectedCoupon.code != null ? jsonEncode(selectedCoupon) : 'NA',
      "driver_id": 0,
      "delivery_charge": deliveryPrice,
      "discount": discount,
      "total": Get.find<MyCartController>().totalPrice,
      "serviceTax": orderTax,
      "grand_total": grandTotal,
      "pay_method": paymentId,
      "paid": "COD",
      "notes": Get.find<MyCartController>().notesController.text != ''
          ? Get.find<MyCartController>().notesController.text
          : 'NA',
      "status": 0,
      "order_to": orderTo,
      'wallet_used': isWalletChecked == true && walletDiscount > 0 ? 1 : 0,
      'wallet_price':
          isWalletChecked == true && walletDiscount > 0 ? walletDiscount : 0
    };
    var response = await parser.createOrder(param);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      var notificationParam = {
        "title": "New Order",
        "message": "New Order is created",
        "id": storeInfo.uid
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
    Get.offAllNamed(AppRouter.getTab());
    Get.find<TabsController>().updateIndex(0);
  }

  void backOrders() {
    Get.find<MyCartController>().clearCart();
    Get.offAllNamed(AppRouter.getTab());
    Get.find<TabsController>().updateIndex(1);
  }

  // void onCoupens() {
  //   Get.toNamed(AppRouter.getCoupens());
  // }

  void onCoupens(String offerId, String offerName) {
    Get.delete<CoupensController>(force: true);
    Get.toNamed(AppRouter.getCoupens(), arguments: [offerId, offerName]);
  }

  void savedCoupens(String id, String name) {
    offerId = id.toString();
    offerName = name.toString();
    calculateAllCharge();
    update();
  }

  void onOrderChange(int type) {
    orderTo = type;
    if (orderTo == 1) {
      _deliveryPrice = 0;
      haveFairDeliveryRadius = true;
      update();
      calculateAllCharge();
    } else {
      calculateDistance();
    }
    update();
  }
}
