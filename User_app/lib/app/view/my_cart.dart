/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/controller/my_cart_controller.dart';
import 'package:upgrade/app/env.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:get/get.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCartController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          automaticallyImplyLeading: false,
          title: Text(
            'My Cart'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.savedInCart.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        "assets/images/no-data.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'No Items In Cart'.tr,
                      style: const TextStyle(
                        color: ThemeProvider.appColor,
                      ),
                    )
                  ],
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                value.totalItemsInCart.toString() + 'items,'.tr,
                            style: const TextStyle(
                              fontFamily: 'semi-bold',
                              fontSize: 16,
                              color: ThemeProvider.blackColor,
                            ),
                          ),
                          TextSpan(
                            text: 'in your cart'.tr,
                            style: const TextStyle(
                              fontFamily: 'regular',
                              fontSize: 16,
                              color: ThemeProvider.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: List.generate(
                        value.savedInCart.length,
                        (index) => Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: ThemeProvider.whiteColor,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(0, 1),
                                    blurRadius: 3),
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  width: 90,
                                  height: 90,
                                  image: NetworkImage(
                                      '${Environments.apiBaseURL}storage/images/${value.savedInCart[index].cover}'),
                                  placeholder: const AssetImage(
                                      "assets/images/error.png"),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/error.png',
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.fitWidth);
                                  },
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              value.savedInCart[index].name
                                                  .toString(),
                                              softWrap: false,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: 16),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              value.removeItemFromCart(index);
                                            },
                                            child: const Icon(
                                              Icons.delete_outline,
                                              color: ThemeProvider.appColor,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            value.savedInCart[index]
                                                .savedVariationsList.length,
                                            (subIndex) => Row(
                                                  children: [
                                                    Text(value
                                                        .savedInCart[index]
                                                        .savedVariationsList[
                                                            subIndex]
                                                        .title
                                                        .toString()
                                                        .toUpperCase()),
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
                                                                  .savedInCart[
                                                                      index]
                                                                  .savedVariationsList[
                                                                      subIndex]
                                                                  .price
                                                                  .toString()
                                                          : value
                                                                  .savedInCart[
                                                                      index]
                                                                  .savedVariationsList[
                                                                      subIndex]
                                                                  .price
                                                                  .toString() +
                                                              value
                                                                  .currencySymbol,
                                                    )
                                                  ],
                                                )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          value.savedInCart[index]
                                                  .savedVariationsList.isEmpty
                                              ? Row(
                                                  children: [
                                                    value.savedInCart[index]
                                                                .discount! >=
                                                            1
                                                        ? Text(
                                                            value.currencySide ==
                                                                    'left'
                                                                ? value.currencySymbol +
                                                                    value
                                                                        .savedInCart[
                                                                            index]
                                                                        .price
                                                                        .toString()
                                                                : value
                                                                        .savedInCart[
                                                                            index]
                                                                        .price
                                                                        .toString() +
                                                                    value
                                                                        .currencySymbol,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'medium',
                                                                fontSize: 16,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          )
                                                        : Text(
                                                            Get.find<MyCartController>()
                                                                        .currencySide ==
                                                                    'left'
                                                                ? Get.find<MyCartController>()
                                                                        .currencySymbol +
                                                                    value
                                                                        .savedInCart[
                                                                            index]
                                                                        .price
                                                                        .toString()
                                                                : value
                                                                        .savedInCart[
                                                                            index]
                                                                        .price
                                                                        .toString() +
                                                                    Get.find<
                                                                            MyCartController>()
                                                                        .currencySymbol,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'bold',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    value.savedInCart[index]
                                                                .discount! >=
                                                            1
                                                        ? Text(
                                                            Get.find<MyCartController>()
                                                                        .currencySide ==
                                                                    'left'
                                                                ? Get.find<MyCartController>()
                                                                        .currencySymbol +
                                                                    value
                                                                        .savedInCart[
                                                                            index]
                                                                        .discount
                                                                        .toString()
                                                                : value
                                                                        .savedInCart[
                                                                            index]
                                                                        .discount
                                                                        .toString() +
                                                                    Get.find<
                                                                            MyCartController>()
                                                                        .currencySymbol,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'bold',
                                                              fontSize: 16,
                                                            ),
                                                          )
                                                        : const SizedBox()
                                                  ],
                                                )
                                              : const SizedBox(),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  value.removeProductQuantity(
                                                      index);
                                                },
                                                child: const Icon(Icons
                                                    .remove_circle_outline),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                value
                                                    .savedInCart[index].quantity
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontFamily: 'bold',
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  value.addProductQuantity(
                                                      index);
                                                },
                                                child: const Icon(
                                                    Icons.add_circle_outline),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    value.savedInCart.isNotEmpty
                        ? TextField(
                            controller: value.notesController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Notes'.tr),
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                          )
                        : const SizedBox()
                  ],
                ),
              ),
        bottomNavigationBar: value.savedInCart.isNotEmpty
            ? Container(
                padding: const EdgeInsets.only(
                    bottom: 20, left: 16, right: 16, top: 40),
                decoration: BoxDecoration(
                  color: ThemeProvider.whiteColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 1),
                        blurRadius: 3),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Price'.tr,
                                style: const TextStyle(
                                    color: ThemeProvider.greyColor),
                              ),
                              Text(
                                Get.find<MyCartController>().currencySide ==
                                        'left'
                                    ? Get.find<MyCartController>()
                                            .currencySymbol +
                                        value.totalPrice.toString()
                                    : value.totalPrice.toString() +
                                        Get.find<MyCartController>()
                                            .currencySymbol,
                                style: const TextStyle(
                                    fontFamily: 'bold', fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              // value.onMyCart();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: ThemeProvider.appColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: InkWell(
                                onTap: () {
                                  value.onCheckout();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'CHECKOUT'.tr,
                                      style: const TextStyle(
                                          color: ThemeProvider.whiteColor,
                                          fontFamily: 'medium',
                                          fontSize: 16),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_right,
                                      color: ThemeProvider.whiteColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      );
    });
  }
}
