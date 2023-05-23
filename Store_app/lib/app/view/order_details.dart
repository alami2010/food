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
import 'package:vender/app/controller/order_details_controller.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/util/theme.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            title: Text(
              '${'Order Details'} #${value.orderInfo.id}',
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
                                                    fontSize: 14),
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
                                                              .items![
                                                                  productIndex]
                                                              .savedVariationsList[
                                                                  varintIndex]
                                                              .title
                                                              .toString()
                                                              .toUpperCase(),
                                                          style:
                                                              const TextStyle(
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
                                                          Get.find<OrderDetailsController>()
                                                                      .currencySide ==
                                                                  'left'
                                                              ? Get.find<OrderDetailsController>()
                                                                      .currencySymbol +
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
                                                                  Get.find<
                                                                          OrderDetailsController>()
                                                                      .currencySymbol,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
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
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Item Total'.tr),
                              Text(
                                Get.find<OrderDetailsController>()
                                            .currencySide ==
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
                                Get.find<OrderDetailsController>()
                                            .currencySide ==
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
                                Get.find<OrderDetailsController>()
                                            .currencySide ==
                                        'left'
                                    ? Get.find<OrderDetailsController>()
                                            .currencySymbol +
                                        value.orderInfo.deliveryCharge
                                            .toString()
                                    : value.orderInfo.deliveryCharge
                                            .toString() +
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
                                Get.find<OrderDetailsController>()
                                            .currencySide ==
                                        'left'
                                    ? Get.find<OrderDetailsController>()
                                            .currencySymbol +
                                        value.orderInfo.discount.toString()
                                    : value.orderInfo.discount
                                            .toString()
                                            .toString() +
                                        Get.find<OrderDetailsController>()
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
                                Get.find<OrderDetailsController>()
                                            .currencySide ==
                                        'left'
                                    ? Get.find<OrderDetailsController>()
                                            .currencySymbol +
                                        value.orderInfo.grandTotal.toString()
                                    : value.orderInfo.grandTotal
                                            .toString()
                                            .toString()
                                            .toString() +
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
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'User Information'.tr,
                        style: const TextStyle(fontFamily: 'bold'),
                      ),
                      const SizedBox(
                        height: 10,
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
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color:
                                          ThemeProvider.greyColor.shade300))),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FadeInImage(
                                    height: 40,
                                    width: 40,
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.userInfo.cover.toString()}'),
                                    placeholder: const AssetImage(
                                        "assets/images/error.png"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/error.png',
                                          fit: BoxFit.fitWidth);
                                    },
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${value.userInfo.firstName} ${value.userInfo.lastName}',
                                        style: const TextStyle(
                                            fontSize: 16, fontFamily: 'bold'),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.mail_outline,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(value.userInfo.email.toString()),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.call_outlined,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              value.userInfo.mobile.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      value.haveDriver == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Driver Information'.tr,
                                  style: const TextStyle(fontFamily: 'bold'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    value.openActionModal(
                                        '${value.driverInfo.firstName} ${value.driverInfo.lastName}',
                                        value.driverInfo.mobile.toString(),
                                        value.driverInfo.id.toString(),
                                        'driver',
                                        value.driverInfo.email.toString());
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: ThemeProvider
                                                    .greyColor.shade300))),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: FadeInImage(
                                              height: 40,
                                              width: 40,
                                              image: NetworkImage(
                                                  '${Environments.apiBaseURL}storage/images/${value.driverInfo.cover.toString()}'),
                                              placeholder: const AssetImage(
                                                  "assets/images/error.png"),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    'assets/images/error.png',
                                                    fit: BoxFit.fitWidth);
                                              },
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${value.driverInfo.firstName} ${value.driverInfo.lastName}',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'bold'),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.mail_outline,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(value.driverInfo.email
                                                        .toString()),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.call_outlined,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(value.driverInfo.mobile
                                                        .toString()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
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
                  : value.orderInfo.status == 0
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    value.onInitialOrderStatus(6);
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
                                    'Reject'.tr,
                                    style: const TextStyle(
                                      color: ThemeProvider.whiteColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    value.onInitialOrderStatus(1);
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
                                    'Accept'.tr,
                                    style: const TextStyle(
                                      color: ThemeProvider.whiteColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            ],
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
                                  items: value.ordersStatusList
                                      .map((String items) {
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

  Widget alertDialogBox(value) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: Text('Choose Status'.tr),
      content: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.circle_outlined,
                    color: ThemeProvider.appColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Ongoing'.tr,
                    style: const TextStyle(color: ThemeProvider.appColor),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
