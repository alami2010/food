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
import 'package:vender/app/controller/bookings_controller.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/util/theme.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingsController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          title: Text(
            'Bookings'.tr,
            style: const TextStyle(
                fontFamily: 'bold',
                fontSize: 18,
                color: ThemeProvider.whiteColor),
          ),
        ),
        body: value.apiCalled == false
            ? SkeletonListView()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    for (var item in value.bookingList)
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 3),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '#${item.id}',
                                  style: const TextStyle(
                                      color: ThemeProvider.greyColor),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: FadeInImage(
                                      height: 40,
                                      width: 40,
                                      image: NetworkImage(
                                          '${Environments.apiBaseURL}storage/images/${item.userInfo?.cover.toString()}'),
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
                                    child: Text(
                                        '${item.userInfo!.firstName} ${item.userInfo!.lastName}'),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${'Total Guest'.tr} - ${item.totalGuest}',
                                    style: const TextStyle(fontFamily: 'bold'),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${'Book Date'} - ${item.savedDate}',
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontFamily: 'medium'),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${'Guest Name'} - ${item.guestName}',
                                    style: const TextStyle(
                                        color: ThemeProvider.appColor),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${'Guest Email'} - ${item.email}',
                                    style: const TextStyle(
                                        color: ThemeProvider.appColor),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${'Guest Email'} - ${item.mobile}',
                                    style: const TextStyle(
                                        color: ThemeProvider.appColor),
                                  ),
                                ],
                              ),
                            ),
                            item.status == 0 || item.status == 1
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      item.status == 0
                                          ? GestureDetector(
                                              onTap: () {
                                                value.updateBookingInfo(
                                                    item.id as int, 1);
                                              },
                                              child: Container(
                                                width: 85,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: ThemeProvider
                                                        .greenColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  'Accept'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .whiteColor),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      item.status == 0
                                          ? GestureDetector(
                                              onTap: () {
                                                value.updateBookingInfo(
                                                    item.id as int, 3);
                                              },
                                              child: Container(
                                                width: 85,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color:
                                                        ThemeProvider.appColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  'Reject'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .whiteColor),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      GestureDetector(
                                        onTap: () {
                                          value.updateBookingInfo(
                                              item.id as int, 2);
                                        },
                                        child: Container(
                                          width: 85,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: ThemeProvider.greyColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            'Complete'.tr,
                                            textAlign: TextAlign.center,
                                            // value.status[item.storeInfo?.status as int],
                                            style: const TextStyle(
                                                color:
                                                    ThemeProvider.whiteColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: ThemeProvider.appColor),
                                        child: Text(
                                          item.status == 3
                                              ? 'Rejected'.tr
                                              : 'Completed'.tr,
                                          style: const TextStyle(
                                              color: ThemeProvider.whiteColor),
                                        ),
                                      )
                                    ],
                                  )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
      );
    });
  }
}
