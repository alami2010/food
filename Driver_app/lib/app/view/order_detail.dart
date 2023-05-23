/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/controller/order_detail_controller.dart';
import 'package:driver/app/env.dart';
import 'package:driver/app/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            title: Text(
              '${'Order Detail'.tr} #${value.orderId}',
              style: const TextStyle(
                  fontFamily: 'bold',
                  fontSize: 18,
                  color: ThemeProvider.whiteColor),
            ),
          ),
          body: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Orders'.tr,
                            style: const TextStyle(fontFamily: 'bold'),
                          ),
                          const SizedBox(
                            height: 10,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              value
                                                          .orderInfo
                                                          .items![productIndex]
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
                                                  Text(value
                                                      .orderInfo
                                                      .items![productIndex]
                                                      .quantity
                                                      .toString()),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text('X'),
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
                                                        .items![productIndex]
                                                        .name
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontFamily: 'bold'),
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
                                                              style: const TextStyle(
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
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'bold'),
                                                            )
                                                      : const SizedBox()
                                                ],
                                              ),
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
                                                        .items![productIndex]
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
                                                    value.currencySide == 'left'
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
                                              ),
                                            ),
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
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Item Total'.tr),
                              Text(
                                Get.find<OrderDetailController>()
                                            .currencySide ==
                                        'left'
                                    ? Get.find<OrderDetailController>()
                                            .currencySymbol +
                                        value.orderInfo.total.toString()
                                    : value.orderInfo.total.toString() +
                                        Get.find<OrderDetailController>()
                                            .currencySymbol,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Taxes & charges'.tr),
                              Text(
                                Get.find<OrderDetailController>()
                                            .currencySide ==
                                        'left'
                                    ? Get.find<OrderDetailController>()
                                            .currencySymbol +
                                        value.orderInfo.serviceTax.toString()
                                    : value.orderInfo.serviceTax.toString() +
                                        Get.find<OrderDetailController>()
                                            .currencySymbol,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Cost'.tr),
                              Text(
                                Get.find<OrderDetailController>()
                                            .currencySide ==
                                        'left'
                                    ? Get.find<OrderDetailController>()
                                            .currencySymbol +
                                        value.orderInfo.deliveryCharge
                                            .toString()
                                    : value.orderInfo.deliveryCharge
                                            .toString() +
                                        Get.find<OrderDetailController>()
                                            .currencySymbol,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Discount'.tr),
                              Text(
                                Get.find<OrderDetailController>()
                                            .currencySide ==
                                        'left'
                                    ? Get.find<OrderDetailController>()
                                            .currencySymbol +
                                        value.orderInfo.discount.toString()
                                    : value.orderInfo.discount
                                            .toString()
                                            .toString() +
                                        Get.find<OrderDetailController>()
                                            .currencySymbol,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Wallet Discount'.tr),
                              const Text('NA'),
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
                                Get.find<OrderDetailController>()
                                            .currencySide ==
                                        'left'
                                    ? Get.find<OrderDetailController>()
                                            .currencySymbol +
                                        value.orderInfo.grandTotal.toString()
                                    : value.orderInfo.grandTotal
                                            .toString()
                                            .toString() +
                                        Get.find<OrderDetailController>()
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
                                'Order ID'.tr,
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
                                'Payment Method'.tr,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(value
                                  .payment[value.orderInfo.payMethod as int]
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
                                'Delivery On'.tr,
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
                                'Delivery To'.tr,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(value.titles[value.orderInfo.orderTo as int]
                                  .toString()),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            decoration: bottomBorder(),
                            child:
                                Text('Store Information'.tr, style: boldText()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              value.openActionModal(
                                  value.storeInfo.name.toString(),
                                  value.storeInfo.mobile.toString(),
                                  value.storeInfo.uid.toString(),
                                  'store',
                                  'none');
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: FadeInImage(
                                        height: 40,
                                        width: 40,
                                        image: NetworkImage(
                                            '${Environments.apiBaseURL}storage/images/${value.storeInfo.cover}'),
                                        placeholder: const AssetImage(
                                            "assets/images/error.png"),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              'assets/images/error.png',
                                              fit: BoxFit.cover);
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value.storeInfo.name.toString(),
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            value.storeInfo.address.toString(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: ThemeProvider.greyColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  value.orderInfo.status == 1 ||
                                          value.orderInfo.status == 2 ||
                                          value.orderInfo.status == 3
                                      ? IconButton(
                                          onPressed: () {
                                            value.openTrackingFromStore();
                                          },
                                          icon: const Icon(Icons.near_me_sharp,
                                              color: ThemeProvider.orangeColor))
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            decoration: bottomBorder(),
                            child:
                                Text('User Information'.tr, style: boldText()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              value.openActionModal(
                                  '${value.userInfo.firstName} ${value.userInfo.lastName}',
                                  value.userInfo.mobile.toString(),
                                  value.userInfo.id.toString(),
                                  'user',
                                  value.userInfo.email.toString());
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: FadeInImage(
                                        height: 40,
                                        width: 40,
                                        image: NetworkImage(
                                            '${Environments.apiBaseURL}storage/images/${value.userInfo.cover}'),
                                        placeholder: const AssetImage(
                                            "assets/images/error.png"),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              'assets/images/error.png',
                                              fit: BoxFit.cover);
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${value.userInfo.firstName} ${value.userInfo.lastName}',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            value.orderInfo.address!.address
                                                .toString(),
                                            style: const TextStyle(
                                                color: ThemeProvider.greyColor,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  value.orderInfo.status == 1 ||
                                          value.orderInfo.status == 2 ||
                                          value.orderInfo.status == 3
                                      ? IconButton(
                                          onPressed: () {
                                            value.openTrackingFromUser();
                                          },
                                          icon: const Icon(Icons.near_me_sharp,
                                              color: ThemeProvider.orangeColor))
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: value.apiCalled == false
              ? const SizedBox()
              : value.haveActionButton == false
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration:
                            const BoxDecoration(color: ThemeProvider.appColor),
                        child: Text(
                          value.orderActionName,
                          style: const TextStyle(
                              color: ThemeProvider.whiteColor,
                              fontFamily: 'medium'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton(
                              isExpanded: true,
                              value: value.selectedStatus,
                              icon: const Icon(Icons.arrow_drop_down),
                              items: value.ordersStatusList.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                value.updateOrderStatusNumber(
                                    newValue.toString());
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                value.updateOrderStatus();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: ThemeProvider.greenColor,
                                onPrimary: ThemeProvider.whiteColor,
                                minimumSize: const Size.fromHeight(45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Update Status'.tr,
                                style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
        );
      },
    );
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
}
