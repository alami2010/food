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
import 'package:vender/app/controller/insights_controller.dart';
import 'package:vender/app/helper/navbar.dart';
import 'package:vender/app/helper/router.dart';
import 'package:vender/app/util/constant.dart';
import 'package:vender/app/util/theme.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({Key? key}) : super(key: key);

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> refreshKeyNew =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InsightsController>(builder: (value) {
      return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          title: Text(
            'Business Insights'.tr,
            style: const TextStyle(
                fontFamily: 'bold',
                fontSize: 18,
                color: ThemeProvider.whiteColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                value.onAnalytics();
              },
              icon: const Icon(Icons.segment),
            ),
          ],
        ),
        body: RefreshIndicator(
          key: refreshKeyNew,
          onRefresh: () async {
            await value.onRefresh();
          },
          child: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Deliverd Orders'.tr,
                              style: const TextStyle(
                                  fontFamily: 'medium',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRouter.getStatsChartsRoutes());
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'See More'.tr,
                                    style: const TextStyle(
                                        color: ThemeProvider.appColor),
                                  ),
                                  const Icon(
                                    Icons.arrow_right,
                                    color: ThemeProvider.appColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          // margin: const EdgeInsets.only(right: 20),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF0594aa),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Today'.tr,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Text(
                                        value.currencySide == 'left'
                                            ? value.currencySymbol +
                                                value.todayStates.total
                                                    .toString()
                                            : value.todayStates.total
                                                    .toString() +
                                                value.currencySymbol,
                                        style: const TextStyle(
                                            fontFamily: 'medium',
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '${value.todayStates.totalSold} ${'Orders'.tr}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.white, width: 1))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${'This Week :'.tr} ${value.weeekStates.label}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              value.currencySide == 'left'
                                                  ? value.currencySymbol +
                                                      value.weeekStates.total
                                                          .toString()
                                                  : value.weeekStates.total
                                                          .toString() +
                                                      value.currencySymbol,
                                              style: const TextStyle(
                                                  fontFamily: 'medium',
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              '${value.weeekStates.totalSold} ${' Orders'.tr}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${'This Month :'.tr} ${value.monthStats.label}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              value.currencySide == 'left'
                                                  ? value.currencySymbol +
                                                      value.monthStats.total
                                                          .toString()
                                                  : value.monthStats.total
                                                          .toString() +
                                                      value.currencySymbol,
                                              style: const TextStyle(
                                                  fontFamily: 'medium',
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              '${value.monthStats.totalSold} ${' Orders'.tr}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF394a84),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${'Get more orders from'.tr} ${AppConstants.appName}',
                                style: const TextStyle(
                                    fontFamily: 'medium',
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Items with grocery images lead to more orders compared to items without them.Add photos to your menu items to get more orders.'
                                    .tr,
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rejected Orders'.tr,
                              style: const TextStyle(
                                  fontFamily: 'medium',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRouter.getStatsChartsRoutes());
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'See More'.tr,
                                    style: const TextStyle(
                                        color: ThemeProvider.appColor),
                                  ),
                                  const Icon(
                                    Icons.arrow_right,
                                    color: ThemeProvider.appColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text('Lost sale from orders rejected by you'.tr),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Today'.tr,
                                      style: const TextStyle(
                                          color: ThemeProvider.whiteColor,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      value.currencySide == 'left'
                                          ? value.currencySymbol +
                                              value.todayStatesRejected.total
                                                  .toString()
                                          : value.todayStatesRejected.total
                                                  .toString() +
                                              value.currencySymbol,
                                      style: const TextStyle(
                                        fontFamily: 'medium',
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                        '${value.todayStatesRejected.totalSold} ${'Orders'.tr}'),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey.shade400,
                                            width: 1))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${'This Week :'.tr} ${value.weeekStatesRejected.label}',
                                            style: const TextStyle(
                                                color: ThemeProvider.whiteColor,
                                                fontSize: 10),
                                          ),
                                          Text(
                                            value.currencySide == 'left'
                                                ? value.currencySymbol +
                                                    value.weeekStatesRejected
                                                        .total
                                                        .toString()
                                                : value.weeekStatesRejected
                                                        .total
                                                        .toString() +
                                                    value.currencySymbol,
                                            style: const TextStyle(
                                              fontFamily: 'medium',
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                              '${value.weeekStatesRejected.totalSold} ${'Orders'.tr}'),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${'This Month :'.tr} ${value.monthStatsRejected.label}',
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.whiteColor,
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              value.currencySide == 'left'
                                                  ? value.currencySymbol +
                                                      value.monthStatsRejected
                                                          .total
                                                          .toString()
                                                  : value.monthStatsRejected
                                                          .total
                                                          .toString() +
                                                      value.currencySymbol,
                                              style: const TextStyle(
                                                fontFamily: 'medium',
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                                '${value.monthStatsRejected.totalSold} ${'Orders'.tr}'),
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
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF394a84),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (value.monthStatsRejected.totalSold! > 10)
                                Text(
                                  'Improve yourself'.tr,
                                  style: const TextStyle(
                                      fontFamily: 'medium',
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              if (value.monthStatsRejected.totalSold! <= 2 ||
                                  value.monthStatsRejected.totalSold == 0)
                                Text(
                                  'Great Work!'.tr,
                                  style: const TextStyle(
                                      fontFamily: 'medium',
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (value.monthStatsRejected.totalSold! > 10)
                                Text(
                                  "You have some rejected and cancelled orders on your current month's stats, this will impact on your future sells, improve your self"
                                      .tr,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              if (value.monthStatsRejected.totalSold! <= 2 ||
                                  value.monthStatsRejected.totalSold == 0)
                                Text(
                                  "You have accepted all orders till now in this month"
                                      .tr,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Customer Complaints'.tr,
                          style: const TextStyle(
                              fontFamily: 'medium',
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        Row(
                          children: [
                            Text('Details from'.tr),
                            const SizedBox(
                              width: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  value.monthStats.label.toString(),
                                  style: const TextStyle(
                                      color: ThemeProvider.appColor),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: ThemeProvider.appColor,
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var item in value.complaintsList)
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade300))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              value.reasonList[
                                                      item.reasonId as int]
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              '#${item.orderId}',
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        ),
                                        Text(item.shortMessage.toString(),
                                            style: const TextStyle(
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Top Items in your menu'.tr,
                          style: const TextStyle(
                              fontFamily: 'medium',
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        Row(
                          children: [
                            Text('Details from'.tr),
                            const SizedBox(
                              width: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  value.monthStats.label.toString(),
                                  style: const TextStyle(
                                      color: ThemeProvider.appColor),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: ThemeProvider.appColor,
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      'Menu items'.tr,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Quantity Sold'.tr,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            for (var item in value.topOrders)
                              dishMenu(item.items!.name.toString(),
                                  item.counts.toString())
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }

  Widget dishMenu(String left, String right) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              // ,
              left.length > 25
                  ? '${left.substring(0, 25)}...'
                  : left.toString(),
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: Text(
              right,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
