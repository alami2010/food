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
import 'package:skeletons/skeletons.dart';
import 'package:vender/app/controller/order_screen_controller.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/helper/navbar.dart';
import 'package:vender/app/util/constant.dart';
import 'package:vender/app/util/theme.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ScrollController _scrollControllerNew = ScrollController();
  final ScrollController _scrollControllerOngoing = ScrollController();
  final ScrollController _scrollControllerOld = ScrollController();
  final GlobalKey<RefreshIndicatorState> refreshKeyNew =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshKeyOngoing =
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

    _scrollControllerOngoing.addListener(() {
      if (_scrollControllerOngoing.position.pixels ==
          _scrollControllerOngoing.position.maxScrollExtent) {
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
        length: 3,
        child: Scaffold(
          drawer: const NavBar(),
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            bottom: PreferredSize(
              preferredSize: value.apiCalled == true
                  ? const Size.fromHeight(50.0)
                  : const Size.fromHeight(0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: value.apiCalled == true
                    ? TabBar(
                        labelColor: ThemeProvider.appColor,
                        labelStyle: const TextStyle(fontFamily: 'semibold'),
                        unselectedLabelColor: Colors.black,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                        indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(
                              width: 2.0, color: ThemeProvider.appColor),
                        ),
                        tabs: [
                          Tab(
                            text: 'New Order'.tr,
                          ),
                          Tab(
                            text: 'Ongoing Order'.tr,
                          ),
                          Tab(
                            text: 'Past Order'.tr,
                          ),
                        ],
                      )
                    : const SizedBox(),
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
                        child: value.lastestOrder.isEmpty
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
                                  for (var item in value.lastestOrder)
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
                                                          item.createdAt
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: ThemeProvider
                                                                  .greyColor),
                                                        ),
                                                        Text(
                                                            '${'ORDER ID :'.tr} ${item.id}')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: ThemeProvider
                                                          .appColor),
                                                  child: Text(
                                                    AppConstants.orderStatus[
                                                            item.status as int]
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: ThemeProvider
                                                            .whiteColor),
                                                  ),
                                                )
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
                                                                    Text(
                                                                      item.items![productIndex].name.toString().length >
                                                                              30
                                                                          ? '${item.items![productIndex].name.toString().substring(0, 30)}...'
                                                                          : item
                                                                              .items![productIndex]
                                                                              .name
                                                                              .toString(),
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'bold',
                                                                          fontSize:
                                                                              14),
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
                                                                        Get.find<OrderScreenController>().currencySide ==
                                                                                'left'
                                                                            ? Get.find<OrderScreenController>().currencySymbol +
                                                                                item.items![productIndex].savedVariationsList[varintIndex].price.toString()
                                                                            : item.items![productIndex].savedVariationsList[varintIndex].price.toString() + Get.find<OrderScreenController>().currencySymbol,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12),
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
                      key: refreshKeyOngoing,
                      onRefresh: () async {
                        await value.onRefresh();
                      },
                      child: SingleChildScrollView(
                        controller: _scrollControllerOngoing,
                        padding: const EdgeInsets.all(16),
                        child: value.ongoingOrder.isEmpty
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
                                      'No Ongoing Orders Found'.tr,
                                      style: const TextStyle(
                                        color: ThemeProvider.appColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  for (var item in value.ongoingOrder)
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
                                                          item.createdAt
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: ThemeProvider
                                                                  .greyColor),
                                                        ),
                                                        Text(
                                                            '${'ORDER ID :'} ${item.id}')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: ThemeProvider
                                                          .appColor),
                                                  child: Text(
                                                    AppConstants.orderStatus[
                                                            item.status as int]
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: ThemeProvider
                                                            .whiteColor),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              value.onOrderDetails(
                                                  item.id as int);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: ThemeProvider
                                                          .greyColor.shade200),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(
                                                      item.items!.length,
                                                      (productIndex) => Column(
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
                                                                    top: 10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                item.items![productIndex]
                                                                            .veg ==
                                                                        2
                                                                    ? Image.asset(
                                                                        'assets/images/non.png',
                                                                        height:
                                                                            10,
                                                                        width:
                                                                            10,
                                                                      )
                                                                    : Image.asset(
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
                                                                        .items![
                                                                            productIndex]
                                                                        .quantity
                                                                        .toString()),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    const Text(
                                                                        'X'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  item.items![productIndex].name
                                                                              .toString()
                                                                              .length >
                                                                          30
                                                                      ? '${item.items![productIndex].name.toString().substring(0, 30)}...'
                                                                      : item
                                                                          .items![
                                                                              productIndex]
                                                                          .name
                                                                          .toString(),
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'bold',
                                                                      fontSize:
                                                                          14),
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
                                                            children:
                                                                List.generate(
                                                              item
                                                                  .items![
                                                                      productIndex]
                                                                  .savedVariationsList
                                                                  .length,
                                                              (varintIndex) =>
                                                                  Row(
                                                                children: [
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  const Text(
                                                                      '-'),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    item
                                                                        .items![
                                                                            productIndex]
                                                                        .savedVariationsList[
                                                                            varintIndex]
                                                                        .title
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  const Text(
                                                                      '-'),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    Get.find<OrderScreenController>().currencySide ==
                                                                            'left'
                                                                        ? Get.find<OrderScreenController>().currencySymbol +
                                                                            item.items![productIndex].savedVariationsList[varintIndex].price
                                                                                .toString()
                                                                        : item.items![productIndex].savedVariationsList[varintIndex].price.toString() +
                                                                            Get.find<OrderScreenController>().currencySymbol,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12),
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
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                MainAxisAlignment.spaceBetween,
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
                        child: value.olderOrder.isEmpty
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
                                      'No Old Orders Found'.tr,
                                      style: const TextStyle(
                                        color: ThemeProvider.appColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  for (var item in value.olderOrder)
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
                                                          item.createdAt
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: ThemeProvider
                                                                  .greyColor),
                                                        ),
                                                        Text(
                                                            '${'ORDER ID :'} ${item.id}')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: ThemeProvider
                                                          .appColor),
                                                  child: Text(
                                                    AppConstants.orderStatus[
                                                            item.status as int]
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: ThemeProvider
                                                            .whiteColor),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              value.onOrderDetails(
                                                  item.id as int);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: ThemeProvider
                                                          .greyColor.shade200),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(
                                                      item.items!.length,
                                                      (productIndex) => Column(
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
                                                                    top: 10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                item.items![productIndex]
                                                                            .veg ==
                                                                        2
                                                                    ? Image.asset(
                                                                        'assets/images/non.png',
                                                                        height:
                                                                            10,
                                                                        width:
                                                                            10,
                                                                      )
                                                                    : Image.asset(
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
                                                                        .items![
                                                                            productIndex]
                                                                        .quantity
                                                                        .toString()),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    const Text(
                                                                        'X'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  item.items![productIndex].name
                                                                              .toString()
                                                                              .length >
                                                                          30
                                                                      ? '${item.items![productIndex].name.toString().substring(0, 30)}...'
                                                                      : item
                                                                          .items![
                                                                              productIndex]
                                                                          .name
                                                                          .toString(),
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'bold',
                                                                      fontSize:
                                                                          14),
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
                                                            children:
                                                                List.generate(
                                                              item
                                                                  .items![
                                                                      productIndex]
                                                                  .savedVariationsList
                                                                  .length,
                                                              (varintIndex) =>
                                                                  Row(
                                                                children: [
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  const Text(
                                                                      '-'),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    item
                                                                        .items![
                                                                            productIndex]
                                                                        .savedVariationsList[
                                                                            varintIndex]
                                                                        .title
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  const Text(
                                                                      '-'),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    Get.find<OrderScreenController>().currencySide ==
                                                                            'left'
                                                                        ? Get.find<OrderScreenController>().currencySymbol +
                                                                            item.items![productIndex].savedVariationsList[varintIndex].price
                                                                                .toString()
                                                                        : item.items![productIndex].savedVariationsList[varintIndex].price.toString() +
                                                                            Get.find<OrderScreenController>().currencySymbol,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12),
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
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                MainAxisAlignment.spaceBetween,
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
