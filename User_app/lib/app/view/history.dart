/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:upgrade/app/controller/history_controller.dart';
import 'package:upgrade/app/env.dart';
import 'package:upgrade/app/util/constant.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollControllerNew = ScrollController();
  final ScrollController _scrollControllerOld = ScrollController();
  final GlobalKey<RefreshIndicatorState> refreshKeyNew =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshKeyOld =
      GlobalKey<RefreshIndicatorState>();
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      tabController.animateTo(tabController.index,
          duration: const Duration(seconds: 3));
      debugPrint(tabController.index.toString());
    });

    _scrollControllerNew.addListener(() {
      if (_scrollControllerNew.position.pixels ==
          _scrollControllerNew.position.maxScrollExtent) {
        Get.find<HistoryController>().increment();
      }
    });

    _scrollControllerOld.addListener(() {
      if (_scrollControllerOld.position.pixels ==
          _scrollControllerOld.position.maxScrollExtent) {
        Get.find<HistoryController>().increment();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            title: Text(
              'My Orders'.tr,
              style: ThemeProvider.titleStyle,
            ),
            bottom: PreferredSize(
              preferredSize: value.parser.haveLoggedIn() == true
                  ? const Size.fromHeight(50.0)
                  : const Size.fromHeight(0),
              child: value.parser.haveLoggedIn() == true
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: ThemeProvider.greyColor.shade300),
                      ),
                      child: TabBar(
                        controller: tabController,
                        labelColor: Colors.black,
                        labelStyle: const TextStyle(fontFamily: 'semibold'),
                        unselectedLabelColor: Colors.black,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                        indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(
                              width: 3.0, color: ThemeProvider.appColor),
                        ),
                        tabs: [
                          Tab(
                            text: 'Ongoing orders'.tr,
                          ),
                          Tab(
                            text: 'Past Orders'.tr,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
          body: value.parser.haveLoggedIn() == false
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextButton(
                          onPressed: () {
                            value.onLogin();
                          },
                          child: Text(
                            'Sign In / Sign Up'.tr,
                            style: const TextStyle(
                              color: ThemeProvider.appColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : value.apiCalled == false
                  ? SkeletonListView()
                  : SizedBox(
                      child: TabBarView(
                        controller: tabController,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (var item in value.orderList)
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            decoration: BoxDecoration(
                                                color: ThemeProvider.whiteColor,
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      offset:
                                                          const Offset(0, 1),
                                                      blurRadius: 3),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: FadeInImage(
                                                          width: 40,
                                                          height: 40,
                                                          image: NetworkImage(
                                                              '${Environments.apiBaseURL}storage/images/${item.storeCover}'),
                                                          placeholder:
                                                              const AssetImage(
                                                                  "assets/images/error.png"),
                                                          imageErrorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                                'assets/images/error.png',
                                                                width: 40,
                                                                height: 40,
                                                                fit: BoxFit
                                                                    .fitWidth);
                                                          },
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: 220,
                                                                child: Text(
                                                                  item.storeName
                                                                      .toString(),
                                                                  softWrap:
                                                                      false,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'bold',
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 220,
                                                                child: Text(
                                                                  item.storeAddress
                                                                      .toString(),
                                                                  softWrap:
                                                                      false,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            color: ThemeProvider
                                                                .appColor),
                                                        child: Text(
                                                          AppConstants
                                                              .orderStatus[
                                                                  item.status
                                                                      as int]
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
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          top: BorderSide(
                                                              color: ThemeProvider
                                                                  .greyColor
                                                                  .shade300))),
                                                  child: InkWell(
                                                    onTap: () {
                                                      value.onOrderDetails(
                                                          item.id as int);
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children:
                                                                List.generate(
                                                              item.items!
                                                                  .length,
                                                              (productIndex) =>
                                                                  Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      item.items![productIndex].veg ==
                                                                              2
                                                                          ? Image
                                                                              .asset(
                                                                              'assets/images/non.png',
                                                                              height: 10,
                                                                              width: 10,
                                                                            )
                                                                          : Image
                                                                              .asset(
                                                                              'assets/images/veg.png',
                                                                              height: 10,
                                                                              width: 10,
                                                                            ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            item.items![productIndex].quantity.toString(),
                                                                            style:
                                                                                const TextStyle(fontFamily: 'bold'),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          const Text(
                                                                            'X',
                                                                            style:
                                                                                TextStyle(fontFamily: 'bold'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                              item.items![productIndex].name.toString().length > 30 ? item.items![productIndex].name.toString().substring(0, 30) + '...' : item.items![productIndex].name.toString(),
                                                                              style: const TextStyle(fontFamily: 'bold', fontSize: 12)),
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
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: List.generate(
                                                                        item.items![productIndex].savedVariationsList.length,
                                                                        (varintIndex) => Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                const Text('-'),
                                                                                const SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Text(
                                                                                  item.items![productIndex].savedVariationsList[varintIndex].title.toString().toUpperCase(),
                                                                                  style: const TextStyle(fontSize: 10),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                const Text('-'),
                                                                                const SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Text(
                                                                                  value.currencySide == 'left' ? value.currencySymbol + item.items![productIndex].savedVariationsList[varintIndex].price.toString() : item.items![productIndex].savedVariationsList[varintIndex].price.toString() + value.currencySymbol,
                                                                                  style: const TextStyle(fontSize: 10),
                                                                                )
                                                                              ],
                                                                            )),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  top: BorderSide(
                                                                      color: ThemeProvider
                                                                          .greyColor
                                                                          .shade300))),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(item
                                                                  .createdAt
                                                                  .toString()),
                                                              Text(
                                                                Get.find<HistoryController>()
                                                                            .currencySide ==
                                                                        'left'
                                                                    ? Get.find<HistoryController>()
                                                                            .currencySymbol +
                                                                        item.grandTotal
                                                                            .toString()
                                                                    : item.grandTotal
                                                                            .toString() +
                                                                        Get.find<HistoryController>()
                                                                            .currencySymbol,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        value.loadMore == true
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
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
                              child: value.olderOrderList.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                          const Text('No Old Orders Found',
                                              style: TextStyle(
                                                color: ThemeProvider.appColor,
                                              ))
                                        ],
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (var item in value.olderOrderList)
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            decoration: BoxDecoration(
                                                color: ThemeProvider.whiteColor,
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      offset:
                                                          const Offset(0, 1),
                                                      blurRadius: 3),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: FadeInImage(
                                                          width: 40,
                                                          height: 40,
                                                          image: NetworkImage(
                                                              '${Environments.apiBaseURL}storage/images/${item.storeCover}'),
                                                          placeholder:
                                                              const AssetImage(
                                                                  "assets/images/error.png"),
                                                          imageErrorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                                'assets/images/error.png',
                                                                width: 40,
                                                                height: 40,
                                                                fit: BoxFit
                                                                    .fitWidth);
                                                          },
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: 220,
                                                                child: Text(
                                                                  item.storeName
                                                                      .toString(),
                                                                  softWrap:
                                                                      false,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'bold',
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 220,
                                                                child: Text(
                                                                  item.storeAddress
                                                                      .toString(),
                                                                  softWrap:
                                                                      false,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            color: ThemeProvider
                                                                .appColor),
                                                        child: Text(
                                                          AppConstants
                                                              .orderStatus[
                                                                  item.status
                                                                      as int]
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
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          top: BorderSide(
                                                              color: ThemeProvider
                                                                  .greyColor
                                                                  .shade300))),
                                                  child: InkWell(
                                                    onTap: () {
                                                      value.onOrderDetails(
                                                          item.id as int);
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children:
                                                                List.generate(
                                                              item.items!
                                                                  .length,
                                                              (productIndex) =>
                                                                  Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      item.items![productIndex].veg ==
                                                                              2
                                                                          ? Image
                                                                              .asset(
                                                                              'assets/images/non.png',
                                                                              height: 10,
                                                                              width: 10,
                                                                            )
                                                                          : Image
                                                                              .asset(
                                                                              'assets/images/veg.png',
                                                                              height: 10,
                                                                              width: 10,
                                                                            ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            item.items![productIndex].quantity.toString(),
                                                                            style:
                                                                                const TextStyle(fontFamily: 'bold'),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          const Text(
                                                                            'X',
                                                                            style:
                                                                                TextStyle(fontFamily: 'bold'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            item.items![productIndex].name.toString().length > 30
                                                                                ? item.items![productIndex].name.toString().substring(0, 30) + '...'
                                                                                : item.items![productIndex].name.toString(),
                                                                            style:
                                                                                const TextStyle(fontFamily: 'bold', fontSize: 12),
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
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: List.generate(
                                                                        item.items![productIndex].savedVariationsList.length,
                                                                        (varintIndex) => Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                const Text('-'),
                                                                                const SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Text(
                                                                                  item.items![productIndex].savedVariationsList[varintIndex].title.toString().toUpperCase(),
                                                                                  style: const TextStyle(fontSize: 10),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                const Text('-'),
                                                                                const SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Text(
                                                                                  value.currencySide == 'left' ? value.currencySymbol + item.items![productIndex].savedVariationsList[varintIndex].price.toString() : item.items![productIndex].savedVariationsList[varintIndex].price.toString() + value.currencySymbol,
                                                                                  style: const TextStyle(fontSize: 10),
                                                                                )
                                                                              ],
                                                                            )),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  top: BorderSide(
                                                                      color: ThemeProvider
                                                                          .greyColor
                                                                          .shade300))),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(item
                                                                  .createdAt
                                                                  .toString()),
                                                              Text(
                                                                Get.find<HistoryController>()
                                                                            .currencySide ==
                                                                        'left'
                                                                    ? Get.find<HistoryController>()
                                                                            .currencySymbol +
                                                                        item.grandTotal
                                                                            .toString()
                                                                    : item.grandTotal
                                                                            .toString() +
                                                                        Get.find<HistoryController>()
                                                                            .currencySymbol,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        value.loadMore == true
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
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
      },
    );
  }
}
