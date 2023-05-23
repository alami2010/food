/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/controller/order_screen_controller.dart';
import 'package:driver/app/helper/navbar.dart';
import 'package:driver/app/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../env.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ScrollController _scrollControllerNew = ScrollController();
  final ScrollController _scrollControllerOld = ScrollController();
  final GlobalKey<RefreshIndicatorState> refreshKeyNew =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshKeyOld =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    _scrollControllerNew.addListener(() {
      if (_scrollControllerNew.position.pixels ==
          _scrollControllerNew.position.maxScrollExtent) {
        Get.find<OrderScreenController>().increment();
      }
    });

    _scrollControllerOld.addListener(() {
      if (_scrollControllerOld.position.pixels ==
          _scrollControllerOld.position.maxScrollExtent) {
        Get.find<OrderScreenController>().increment();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderScreenController>(builder: (value) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: const NavBar(),
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: TabBar(
                  labelColor: ThemeProvider.appColor,
                  labelStyle: const TextStyle(fontFamily: 'semibold'),
                  unselectedLabelColor: Colors.black,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  indicator: const UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 2.0, color: ThemeProvider.appColor),
                  ),
                  tabs: [
                    Tab(
                      text: 'Current Order'.tr,
                    ),
                    Tab(
                      text: 'Past Order'.tr,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : TabBarView(
                  children: [
                    RefreshIndicator(
                      key: refreshKeyNew,
                      onRefresh: () async {
                        await value.onRefresh();
                      },
                      child: SingleChildScrollView(
                        controller: _scrollControllerNew,
                        padding: const EdgeInsets.all(16),
                        child: value.orderList.isEmpty
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
                                      'No New Orders Found'.tr,
                                      style: const TextStyle(
                                        color: ThemeProvider.appColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  for (var item in value.orderList)
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: ThemeProvider.whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            offset: const Offset(0, 1),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: ThemeProvider
                                                            .greyColor
                                                            .shade300))),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  width: 40,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: FadeInImage(
                                                      height: 40,
                                                      width: 40,
                                                      image: NetworkImage(
                                                          '${Environments.apiBaseURL}storage/images/${item.storeCover.toString()}'),
                                                      placeholder: const AssetImage(
                                                          "assets/images/error.png"),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          item.storeName
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                        Text(
                                                          item.storeAddress
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color:
                                                                  ThemeProvider
                                                                      .greyColor,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                            '${'ORDER ID :'.tr} ${item.id}')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              value.onOrderDetails(
                                                  item.id as int);
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color: ThemeProvider
                                                              .greyColor
                                                              .shade200),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: List.generate(
                                                          item.items!.length,
                                                          (productIndex) =>
                                                              Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    item.items![productIndex].veg ==
                                                                            2
                                                                        ? Image
                                                                            .asset(
                                                                            'assets/images/non.png',
                                                                            height:
                                                                                10,
                                                                            width:
                                                                                10,
                                                                          )
                                                                        : Image
                                                                            .asset(
                                                                            'assets/images/veg.png',
                                                                            height:
                                                                                10,
                                                                            width:
                                                                                10,
                                                                          ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(item
                                                                            .items![productIndex]
                                                                            .quantity
                                                                            .toString()),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        const Text(
                                                                            'X'),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          item.items![productIndex].name.toString().length > 30
                                                                              ? '${item.items![productIndex].name.toString().substring(0, 30)}...'
                                                                              : item.items![productIndex].name.toString(),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'bold',
                                                                              fontSize: 12),
                                                                        ),
                                                                        item.items![productIndex].savedVariationsList.isEmpty
                                                                            ? const SizedBox(
                                                                                width: 10,
                                                                              )
                                                                            : const SizedBox(),
                                                                        item.items![productIndex].savedVariationsList.isEmpty
                                                                            ? const Text('-')
                                                                            : const SizedBox(),
                                                                        item.items![productIndex].savedVariationsList.isEmpty
                                                                            ? const SizedBox(
                                                                                width: 5,
                                                                              )
                                                                            : const SizedBox(),
                                                                        item.items![productIndex].savedVariationsList.isEmpty
                                                                            ? item.items![productIndex].discount! > 0
                                                                                ? Text(
                                                                                    value.currencySide == 'left' ? value.currencySymbol + item.items![productIndex].discount.toString() : item.items![productIndex].discount.toString() + value.currencySymbol,
                                                                                    style: const TextStyle(fontFamily: 'bold'),
                                                                                  )
                                                                                : Text(
                                                                                    value.currencySide == 'left' ? value.currencySymbol + item.items![productIndex].price.toString() : item.items![productIndex].price.toString() + value.currencySymbol,
                                                                                    style: const TextStyle(fontFamily: 'bold'),
                                                                                  )
                                                                            : const SizedBox()
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: List
                                                                    .generate(
                                                                  item
                                                                      .items![
                                                                          productIndex]
                                                                      .savedVariationsList
                                                                      .length,
                                                                  (varintIndex) =>
                                                                      Row(
                                                                    children: [
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      const Text(
                                                                          '-'),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        item
                                                                            .items![productIndex]
                                                                            .savedVariationsList[varintIndex]
                                                                            .title
                                                                            .toString()
                                                                            .toUpperCase(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      const Text(
                                                                          '-'),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        value.currencySide ==
                                                                                'left'
                                                                            ? value.currencySymbol +
                                                                                item.items![productIndex].savedVariationsList[varintIndex].price.toString()
                                                                            : item.items![productIndex].savedVariationsList[varintIndex].price.toString() + value.currencySymbol,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                10),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'ORDERED ON'.tr,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      item.createdAt.toString(),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'TOTAL AMOUNT'.tr,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      Get.find<OrderScreenController>()
                                                                  .currencySide ==
                                                              'left'
                                                          ? Get.find<OrderScreenController>()
                                                                  .currencySymbol +
                                                              item.grandTotal
                                                                  .toString()
                                                          : item.grandTotal
                                                                  .toString() +
                                                              Get.find<
                                                                      OrderScreenController>()
                                                                  .currencySymbol,
                                                      style: const TextStyle(
                                                          fontFamily: 'bold'),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(
                                                        color: ThemeProvider
                                                            .greyColor
                                                            .shade300))),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  width: 40,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: FadeInImage(
                                                      height: 40,
                                                      width: 40,
                                                      image: NetworkImage(
                                                          '${Environments.apiBaseURL}storage/images/${item.userCover.toString()}'),
                                                      placeholder: const AssetImage(
                                                          "assets/images/error.png"),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Image.asset(
                                                            'assets/images/error.png',
                                                            fit: BoxFit
                                                                .fitWidth);
                                                      },
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${item.firstName} ${item.lastName}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                        Text(
                                                          item.address!.address
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color:
                                                                  ThemeProvider
                                                                      .greyColor,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  value.loadMore == true
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: ThemeProvider.appColor,
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                      ),
                    ),
                    RefreshIndicator(
                      key: refreshKeyOld,
                      onRefresh: () async {
                        await value.onRefresh();
                      },
                      child: SingleChildScrollView(
                        controller: _scrollControllerOld,
                        padding: const EdgeInsets.all(16),
                        child: value.orderOlder.isEmpty
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
                                      'No New Orders Found'.tr,
                                      style: const TextStyle(
                                        color: ThemeProvider.appColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  for (var item in value.orderOlder)
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: ThemeProvider.whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            offset: const Offset(0, 1),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: ThemeProvider
                                                            .greyColor
                                                            .shade300))),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  width: 40,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: FadeInImage(
                                                      height: 40,
                                                      width: 40,
                                                      image: NetworkImage(
                                                          '${Environments.apiBaseURL}storage/images/${item.storeCover.toString()}'),
                                                      placeholder: const AssetImage(
                                                          "assets/images/error.png"),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          item.storeName
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                        Text(
                                                          item.storeAddress
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color:
                                                                  ThemeProvider
                                                                      .greyColor,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                            '${'ORDER ID :'.tr} ${item.id}')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              value.onOrderDetails(
                                                  item.id as int);
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color: ThemeProvider
                                                              .greyColor
                                                              .shade200),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: List.generate(
                                                          item.items!.length,
                                                          (productIndex) =>
                                                              Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    item.items![productIndex].veg ==
                                                                            2
                                                                        ? Image
                                                                            .asset(
                                                                            'assets/images/non.png',
                                                                            height:
                                                                                10,
                                                                            width:
                                                                                10,
                                                                          )
                                                                        : Image
                                                                            .asset(
                                                                            'assets/images/veg.png',
                                                                            height:
                                                                                10,
                                                                            width:
                                                                                10,
                                                                          ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(item
                                                                            .items![productIndex]
                                                                            .quantity
                                                                            .toString()),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        const Text(
                                                                            'X'),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          item.items![productIndex].name.toString().length > 30
                                                                              ? '${item.items![productIndex].name.toString().substring(0, 30)}...'
                                                                              : item.items![productIndex].name.toString(),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'bold',
                                                                              fontSize: 12),
                                                                        ),
                                                                        item.items![productIndex].savedVariationsList.isEmpty
                                                                            ? const SizedBox(
                                                                                width: 10,
                                                                              )
                                                                            : const SizedBox(),
                                                                        item.items![productIndex].savedVariationsList.isEmpty
                                                                            ? const Text('-')
                                                                            : const SizedBox(),
                                                                        item.items![productIndex].savedVariationsList.isEmpty
                                                                            ? const SizedBox(
                                                                                width: 5,
                                                                              )
                                                                            : const SizedBox(),
                                                                        item.items![productIndex].savedVariationsList.isEmpty
                                                                            ? item.items![productIndex].discount! > 0
                                                                                ? Text(
                                                                                    value.currencySide == 'left' ? value.currencySymbol + item.items![productIndex].discount.toString() : item.items![productIndex].discount.toString() + value.currencySymbol,
                                                                                    style: const TextStyle(fontFamily: 'bold'),
                                                                                  )
                                                                                : Text(
                                                                                    value.currencySide == 'left' ? value.currencySymbol + item.items![productIndex].price.toString() : item.items![productIndex].price.toString() + value.currencySymbol,
                                                                                    style: const TextStyle(fontFamily: 'bold'),
                                                                                  )
                                                                            : const SizedBox()
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: List
                                                                    .generate(
                                                                  item
                                                                      .items![
                                                                          productIndex]
                                                                      .savedVariationsList
                                                                      .length,
                                                                  (varintIndex) =>
                                                                      Row(
                                                                    children: [
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      const Text(
                                                                          '-'),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        item
                                                                            .items![productIndex]
                                                                            .savedVariationsList[varintIndex]
                                                                            .title
                                                                            .toString()
                                                                            .toUpperCase(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      const Text(
                                                                          '-'),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        value.currencySide ==
                                                                                'left'
                                                                            ? value.currencySymbol +
                                                                                item.items![productIndex].savedVariationsList[varintIndex].price.toString()
                                                                            : item.items![productIndex].savedVariationsList[varintIndex].price.toString() + value.currencySymbol,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                10),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'ORDERED ON'.tr,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      item.createdAt.toString(),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'TOTAL AMOUNT',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      Get.find<OrderScreenController>()
                                                                  .currencySide ==
                                                              'left'
                                                          ? Get.find<OrderScreenController>()
                                                                  .currencySymbol +
                                                              item.grandTotal
                                                                  .toString()
                                                          : item.grandTotal
                                                                  .toString() +
                                                              Get.find<
                                                                      OrderScreenController>()
                                                                  .currencySymbol,
                                                      style: const TextStyle(
                                                          fontFamily: 'bold'),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(
                                                        color: ThemeProvider
                                                            .greyColor
                                                            .shade300))),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  width: 40,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: FadeInImage(
                                                      height: 40,
                                                      width: 40,
                                                      image: NetworkImage(
                                                          '${Environments.apiBaseURL}storage/images/${item.userCover.toString()}'),
                                                      placeholder: const AssetImage(
                                                          "assets/images/error.png"),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Image.asset(
                                                            'assets/images/error.png',
                                                            fit: BoxFit
                                                                .fitWidth);
                                                      },
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${item.firstName} ${item.lastName}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                        Text(
                                                          item.address!.address
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color:
                                                                  ThemeProvider
                                                                      .greyColor,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  value.loadMore == true
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: ThemeProvider.appColor,
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
