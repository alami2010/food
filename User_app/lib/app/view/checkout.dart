/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/controller/checkout_controller.dart';
import 'package:upgrade/app/controller/my_cart_controller.dart';
import 'package:upgrade/app/env.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          title: Text(
            'Checkout'.tr,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 15),
                      decoration: BoxDecoration(
                          color: ThemeProvider.whiteColor,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 3),
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              value.onOrderChange(0);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/home.png',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      'At Home'.tr,
                                      style: const TextStyle(
                                          fontFamily: 'medium', fontSize: 16),
                                    ),
                                  ),
                                ),
                                Icon(
                                  value.orderTo == 0
                                      ? Icons.radio_button_checked
                                      : Icons.circle_outlined,
                                  color: ThemeProvider.appColor,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            onTap: () {
                              value.onOrderChange(1);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/store.png',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Self Pickup'.tr,
                                      style: const TextStyle(
                                          fontFamily: 'medium', fontSize: 16),
                                    ),
                                  ),
                                ),
                                Icon(
                                  value.orderTo == 1
                                      ? Icons.radio_button_checked
                                      : Icons.circle_outlined,
                                  color: ThemeProvider.appColor,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    value.orderTo == 0
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                                color: ThemeProvider.whiteColor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(0, 1),
                                      blurRadius: 3),
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivery Address'.tr,
                                  style: const TextStyle(
                                      fontSize: 18, fontFamily: 'bold'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                value.haveAddress == true
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              value.addressInfo.address
                                                      .toString() +
                                                  ' ' +
                                                  value.addressInfo.house
                                                      .toString() +
                                                  ' ' +
                                                  value.addressInfo.landmark
                                                      .toString() +
                                                  ' ' +
                                                  value.addressInfo.pincode
                                                      .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              value.onSavedAddress();
                                            },
                                            child: Text(
                                              'Change'.tr,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.appColor),
                                            ),
                                          )
                                        ],
                                      )
                                    : InkWell(
                                        onTap: () {
                                          value.onSavedAddress();
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(Icons.add),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text('Add New Address'.tr)
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                                color: ThemeProvider.whiteColor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(0, 1),
                                      blurRadius: 3),
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Store Information'.tr,
                                  style: const TextStyle(
                                      fontSize: 18, fontFamily: 'bold'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  child: Text(
                                    value.storeInfo.name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 14, fontFamily: 'bold'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  child: Text(
                                    value.storeInfo.address.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 15),
                      decoration: BoxDecoration(
                          color: ThemeProvider.whiteColor,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 3),
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(top: 15, bottom: 20),
                      child: InkWell(
                        onTap: () {
                          if (value.isWalletChecked == false) {
                            value.onCoupens(value.offerId, value.offerName);
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/coupen.png',
                              fit: BoxFit.cover,
                              height: 25,
                              width: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            value.offerName.isEmpty
                                ? Text(
                                    'Apply Coupon Code'.tr,
                                    style: const TextStyle(
                                        color: ThemeProvider.appColor),
                                  )
                                : Text('Coupon Applied :'.tr + value.offerName,
                                    style: const TextStyle(
                                        color: ThemeProvider.appColor))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      decoration: BoxDecoration(
                          color: ThemeProvider.whiteColor,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 3),
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: ThemeProvider.appColor,
                            value: value.isWalletChecked,
                            onChanged:
                                value.balance <= 0 || value.offerName.isNotEmpty
                                    ? null
                                    : (bool? status) {
                                        value.updateWalletChecked(status!);
                                      },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          value.currencySide == 'left'
                              ? Text(
                                  '${'Available Balance'.tr + value.currencySymbol}${value.balance}',
                                  style: const TextStyle(
                                      fontSize: 16, fontFamily: 'regular'),
                                )
                              : Text(
                                  '${'Available Balance'.tr + value.balance.toString()}${value.currencySymbol}',
                                  style: const TextStyle(
                                      fontSize: 16, fontFamily: 'regular'),
                                ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                          color: ThemeProvider.whiteColor,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 3),
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Item Total'.tr),
                              Text(
                                Get.find<CheckoutController>().currencySide ==
                                        'left'
                                    ? Get.find<CheckoutController>()
                                            .currencySymbol +
                                        Get.find<MyCartController>()
                                            .totalPrice
                                            .toString()
                                    : Get.find<MyCartController>()
                                            .totalPrice
                                            .toString() +
                                        Get.find<CheckoutController>()
                                            .currencySymbol,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Taxes & charges'.tr),
                              Text(
                                Get.find<CheckoutController>().currencySide ==
                                        'left'
                                    ? Get.find<CheckoutController>()
                                            .currencySymbol +
                                        value.orderTax.toString()
                                    : value.orderTax.toString() +
                                        Get.find<CheckoutController>()
                                            .currencySymbol,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Cost'.tr),
                              Text(
                                Get.find<CheckoutController>().currencySide ==
                                        'left'
                                    ? Get.find<CheckoutController>()
                                            .currencySymbol +
                                        value.deliveryPrice.toString()
                                    : value.deliveryPrice.toString() +
                                        Get.find<CheckoutController>()
                                            .currencySymbol,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Discount'.tr),
                              Text(
                                Get.find<CheckoutController>().currencySide ==
                                        'left'
                                    ? Get.find<CheckoutController>()
                                            .currencySymbol +
                                        value.discount.toString()
                                    : value.discount.toString() +
                                        Get.find<CheckoutController>()
                                            .currencySymbol,
                              ),
                            ],
                          ),
                          value.balance > 0 && value.isWalletChecked == true
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Wallet Discount'.tr),
                                    value.currencySide == 'left'
                                        ? Text(
                                            value.currencySymbol +
                                                value.balance.toString(),
                                            style: const TextStyle(
                                                color: Colors.red))
                                        : Text(
                                            value.balance.toString() +
                                                value.currencySymbol,
                                            style: const TextStyle(
                                                color: Colors.red)),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Grand Total'.tr,
                                style: const TextStyle(
                                    fontFamily: 'semi-bold', fontSize: 16),
                              ),
                              Text(
                                value.currencySide == 'left'
                                    ? value.currencySymbol +
                                        value.grandTotal.toString()
                                    : value.grandTotal.toString() +
                                        value.currencySymbol,
                                style: const TextStyle(
                                    fontFamily: 'semi-bold', fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                          color: ThemeProvider.whiteColor,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 3),
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Method'.tr,
                            style: const TextStyle(
                                fontSize: 18, fontFamily: 'bold'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          for (var item in value.paymentList)
                            value.apiCalled == false
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: ThemeProvider.appColor),
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 13),
                                    decoration: BoxDecoration(
                                        color: ThemeProvider.greyColor.shade200,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: GestureDetector(
                                      onTap: () {
                                        value.selectPaymentMethod(
                                            item.id as int);
                                      },
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: FadeInImage(
                                              width: 35,
                                              height: 35,
                                              image: NetworkImage(
                                                  '${Environments.apiBaseURL}storage/images/${item.cover}'),
                                              placeholder: const AssetImage(
                                                  "assets/images/error.png"),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    width: 35,
                                                    height: 35,
                                                    'assets/images/error.png',
                                                    fit: BoxFit.fitWidth);
                                              },
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                item.name.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeProvider
                                                        .blackColor),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            value.paymentId == item.id
                                                ? Icons.radio_button_checked
                                                : Icons.circle_outlined,
                                            color: value.paymentId == item.id
                                                ? ThemeProvider.appColor
                                                : ThemeProvider.greyColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: value.haveFairDeliveryRadius == true
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    value.onPayment();
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
                    'PLACE ORDER'.tr,
                    style: const TextStyle(
                      color: ThemeProvider.whiteColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      );
    });
  }
}
