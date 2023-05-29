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
import 'package:foodies_user/app/controller/order_details_controller.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:foodies_user/app/env.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          title: Text(
            'Order Details'.tr,
            style: ThemeProvider.titleStyle,
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  value.launchInBrowser();
                },
                icon: const Icon(Icons.print_outlined)),
            IconButton(
                onPressed: () {
                  value.openHelpModal();
                },
                icon: const Icon(Icons.question_mark_outlined))
          ],
        ),
        bottomNavigationBar: value.apiCalled == false
            ? const SizedBox()
            : value.orderInfo.status == 0
                ? InkWell(
                    onTap: () {
                      value.cancelOrder();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration:
                            const BoxDecoration(color: ThemeProvider.appColor),
                        child: Text(
                          'Cancel Order'.tr,
                          style: const TextStyle(
                              color: ThemeProvider.whiteColor,
                              fontFamily: 'medium'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : value.isDelivered == true
                    ? InkWell(
                        onTap: () {
                          debugPrint('rate order');
                          value.openRatingModal();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                                color: ThemeProvider.appColor),
                            child: Text(
                              'Rate Order'.tr,
                              style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontFamily: 'medium'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          if (value.orderInfo.status == 8) {
                            value.onWebPaymnets();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                                color: ThemeProvider.appColor),
                            child: Text(
                              value.orderActionName,
                              style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontFamily: 'medium'),
                              textAlign: TextAlign.center,
                            ),
                          ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.storeInfo.name.toString(),
                          style: const TextStyle(
                              fontFamily: 'medium', fontSize: 18),
                        ),
                        Text(
                          value.storeInfo.address.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(color: Colors.grey.shade300),
                            bottom: BorderSide(color: Colors.grey.shade300),
                          )),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    value.orderInfo.items!.length,
                                    (productIndex) => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            value.orderInfo.items![productIndex]
                                                        .veg ==
                                                    2
                                                ? Image.asset(
                                                    'assets/images/non.png',
                                                    height: 10,
                                                    width: 10,
                                                  )
                                                : Image.asset(
                                                    'assets/images/veg.png',
                                                    height: 10,
                                                    width: 10,
                                                  ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  value
                                                      .orderInfo
                                                      .items![productIndex]
                                                      .quantity
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily: 'bold'),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const Text(
                                                  'X',
                                                  style: TextStyle(
                                                      fontFamily: 'bold'),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  value
                                                              .orderInfo
                                                              .items![
                                                                  productIndex]
                                                              .name
                                                              .toString()
                                                              .length >
                                                          30
                                                      ? '${value.orderInfo.items![productIndex].name.toString().substring(0, 30)}...'
                                                      : value
                                                          .orderInfo
                                                          .items![productIndex]
                                                          .name
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 12),
                                                ),
                                                value
                                                        .orderInfo
                                                        .items![productIndex]
                                                        .savedVariationsList
                                                        .isEmpty
                                                    ? const SizedBox(
                                                        width: 10,
                                                      )
                                                    : const SizedBox(),
                                                value
                                                        .orderInfo
                                                        .items![productIndex]
                                                        .savedVariationsList
                                                        .isEmpty
                                                    ? const Text('-')
                                                    : const SizedBox(),
                                                value
                                                        .orderInfo
                                                        .items![productIndex]
                                                        .savedVariationsList
                                                        .isEmpty
                                                    ? const SizedBox(
                                                        width: 5,
                                                      )
                                                    : const SizedBox(),
                                                value
                                                        .orderInfo
                                                        .items![productIndex]
                                                        .savedVariationsList
                                                        .isEmpty
                                                    ? value
                                                                .orderInfo
                                                                .items![
                                                                    productIndex]
                                                                .discount! >
                                                            0
                                                        ? Text(
                                                            value.currencySide ==
                                                                    'left'
                                                                ? value.currencySymbol +
                                                                    value
                                                                        .orderInfo
                                                                        .items![
                                                                            productIndex]
                                                                        .discount
                                                                        .toString()
                                                                : value
                                                                        .orderInfo
                                                                        .items![
                                                                            productIndex]
                                                                        .discount
                                                                        .toString() +
                                                                    value
                                                                        .currencySymbol,
                                                            style:
                                                                const TextStyle(
                                                                    fontFamily:
                                                                        'bold'),
                                                          )
                                                        : Text(
                                                            value.currencySide ==
                                                                    'left'
                                                                ? value.currencySymbol +
                                                                    value
                                                                        .orderInfo
                                                                        .items![
                                                                            productIndex]
                                                                        .price
                                                                        .toString()
                                                                : value
                                                                        .orderInfo
                                                                        .items![
                                                                            productIndex]
                                                                        .price
                                                                        .toString() +
                                                                    value
                                                                        .currencySymbol,
                                                            style:
                                                                const TextStyle(
                                                                    fontFamily:
                                                                        'bold'),
                                                          )
                                                    : const SizedBox()
                                              ],
                                            ),
                                            // Text(
                                            //   value.orderInfo
                                            //       .items![productIndex].name
                                            //       .toString(),
                                            //   style: const TextStyle(
                                            //       fontFamily: 'bold'),
                                            // ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                              value
                                                  .orderInfo
                                                  .items![productIndex]
                                                  .savedVariationsList
                                                  .length,
                                              (varintIndex) => Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text('-'),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        value
                                                            .orderInfo
                                                            .items![
                                                                productIndex]
                                                            .savedVariationsList[
                                                                varintIndex]
                                                            .title
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text('-'),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        value.currencySide ==
                                                                'left'
                                                            ? value.currencySymbol +
                                                                value
                                                                    .orderInfo
                                                                    .items![
                                                                        productIndex]
                                                                    .savedVariationsList[
                                                                        varintIndex]
                                                                    .price
                                                                    .toString()
                                                            : value
                                                                    .orderInfo
                                                                    .items![
                                                                        productIndex]
                                                                    .savedVariationsList[
                                                                        varintIndex]
                                                                    .price
                                                                    .toString() +
                                                                value
                                                                    .currencySymbol,
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      )
                                                    ],
                                                  )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Item Total'.tr),
                            Text(
                              Get.find<OrderDetailsController>().currencySide ==
                                      'left'
                                  ? Get.find<OrderDetailsController>()
                                          .currencySymbol +
                                      value.orderInfo.total.toString()
                                  : value.orderInfo.total.toString() +
                                      Get.find<OrderDetailsController>()
                                          .currencySymbol,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Taxes & charges'.tr),
                            Text(
                              Get.find<OrderDetailsController>().currencySide ==
                                      'left'
                                  ? Get.find<OrderDetailsController>()
                                          .currencySymbol +
                                      value.orderInfo.serviceTax.toString()
                                  : value.orderInfo.serviceTax.toString() +
                                      Get.find<OrderDetailsController>()
                                          .currencySymbol,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery Cost'.tr),
                            Text(
                              Get.find<OrderDetailsController>().currencySide ==
                                      'left'
                                  ? Get.find<OrderDetailsController>()
                                          .currencySymbol +
                                      value.orderInfo.deliveryCharge.toString()
                                  : value.orderInfo.deliveryCharge.toString() +
                                      Get.find<OrderDetailsController>()
                                          .currencySymbol,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Discount'.tr),
                            Text(
                              Get.find<OrderDetailsController>().currencySide ==
                                      'left'
                                  ? Get.find<OrderDetailsController>()
                                          .currencySymbol +
                                      value.orderInfo.discount.toString()
                                  : value.orderInfo.discount.toString() +
                                      Get.find<OrderDetailsController>()
                                          .currencySymbol,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Wallet Discount'.tr),
                            Text(
                              Get.find<OrderDetailsController>().currencySide ==
                                      'left'
                                  ? Get.find<OrderDetailsController>()
                                          .currencySymbol +
                                      value.walletPrice.toString()
                                  : value.walletPrice.toString() +
                                      Get.find<OrderDetailsController>()
                                          .currencySymbol,
                            ),
                          ],
                        ),
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
                              Get.find<OrderDetailsController>().currencySide ==
                                      'left'
                                  ? Get.find<OrderDetailsController>()
                                          .currencySymbol +
                                      value.orderInfo.grandTotal.toString()
                                  : value.orderInfo.grandTotal.toString() +
                                      Get.find<OrderDetailsController>()
                                          .currencySymbol,
                              style: const TextStyle(
                                  fontFamily: 'semi-bold', fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Number'.tr.toUpperCase(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(value.orderInfo.id.toString()),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment'.tr.toUpperCase(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(value.payment[value.orderInfo.payMethod as int]
                                .toString()),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery'.tr.toUpperCase(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(value.orderInfo.createdAt.toString()),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Deliver To'.tr.toUpperCase(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(value.titles[value.orderInfo.orderTo as int]
                                .toString()),
                          ],
                        ),
                        value.storeInfo.name != null
                            ? const SizedBox(
                                height: 16,
                              )
                            : const SizedBox(),
                        value.storeInfo.name != null
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                decoration: bottomBorder(),
                                child: Text('Store Information'.tr,
                                    style: boldText()),
                              )
                            : const SizedBox(),
                        value.storeInfo.name != null
                            ? InkWell(
                                onTap: () {
                                  value.openActionModal(
                                      value.storeInfo.name.toString(),
                                      value.storeInfo.mobile.toString(),
                                      value.storeInfo.uid.toString(),
                                      'store',
                                      'none');
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          ClipRRect(
                                            // borderRadius: BorderRadius.circular(100),
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(30),
                                              child: FadeInImage(
                                                image: NetworkImage(
                                                    '${Environments.apiBaseURL}storage/images/${value.storeInfo.cover}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/error.png"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return Image.asset(
                                                      'assets/images/error.png',
                                                      fit: BoxFit.fitWidth);
                                                },
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${value.storeInfo.name}',
                                                  style: boldText(),
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: <Widget>[
                                                    const Icon(
                                                        Icons.location_history,
                                                        size: 17),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child: Text(
                                                        value.storeInfo.address
                                                            .toString(),
                                                        softWrap: true,
                                                        maxLines: 3,
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: <Widget>[
                                                    const Icon(Icons.call,
                                                        size: 17),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(value.storeInfo.mobile
                                                        .toString()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      value.orderInfo.status == 1 ||
                                              value.orderInfo.status == 2 ||
                                              value.orderInfo.status == 3
                                          ? IconButton(
                                              onPressed: () {
                                                value.trackOrderWithStore();
                                              },
                                              icon: const Icon(
                                                  Icons.near_me_sharp,
                                                  color: ThemeProvider
                                                      .orangeColor))
                                          : const SizedBox()
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        value.driverInfo.firstName != null
                            ? const SizedBox(
                                height: 16,
                              )
                            : const SizedBox(),
                        value.driverInfo.firstName != null
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                decoration: bottomBorder(),
                                child: Text('Driver Information'.tr,
                                    style: boldText()),
                              )
                            : const SizedBox(),
                        value.driverInfo.firstName != null
                            ? InkWell(
                                onTap: () {
                                  value.openActionModal(
                                      '${value.driverInfo.firstName} ${value.driverInfo.lastName}',
                                      value.driverInfo.mobile.toString(),
                                      value.driverInfo.id.toString(),
                                      'driver',
                                      value.driverInfo.email.toString());
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          ClipRRect(
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(30),
                                              child: FadeInImage(
                                                image: NetworkImage(
                                                    '${Environments.apiBaseURL}storage/images/${value.driverInfo.cover}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/error.png"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return Image.asset(
                                                      'assets/images/error.png',
                                                      fit: BoxFit.fitWidth);
                                                },
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${value.driverInfo.firstName} ${value.driverInfo.lastName}',
                                                  style: boldText(),
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: <Widget>[
                                                    const Icon(Icons.mail,
                                                        size: 17),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(value.driverInfo.email
                                                        .toString()),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: <Widget>[
                                                    const Icon(Icons.call,
                                                        size: 17),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(value.driverInfo.mobile
                                                        .toString()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      value.orderInfo.status == 1 ||
                                              value.orderInfo.status == 2 ||
                                              value.orderInfo.status == 3
                                          ? IconButton(
                                              onPressed: () {
                                                value.trackOrderWithDriver();
                                              },
                                              icon: const Icon(
                                                  Icons.near_me_sharp,
                                                  color: ThemeProvider
                                                      .orangeColor))
                                          : const SizedBox()
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
      );
    });
  }

  bottomBorder() {
    return BoxDecoration(
        border: Border(
            bottom:
                BorderSide(width: 1, color: ThemeProvider.greyColor.shade300)));
  }

  boldText() {
    return const TextStyle(fontSize: 14, fontFamily: 'bold');
  }

  greyFont() {
    return const TextStyle(color: Colors.grey, fontSize: 12);
  }

  darkFont() {
    return const TextStyle(fontFamily: 'bold', fontSize: 12);
  }
}
