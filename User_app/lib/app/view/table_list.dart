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
import 'package:upgrade/app/controller/table_list_controller.dart';
import 'package:upgrade/app/env.dart';
import 'package:upgrade/app/util/theme.dart';

class TableList extends StatefulWidget {
  const TableList({Key? key}) : super(key: key);

  @override
  State<TableList> createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TableListController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            title: Text(
              'Table List'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      for (var item in value.tableList)
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
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
                                    '#' + item.id.toString(),
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: ThemeProvider.greyColor))),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: FadeInImage(
                                          height: 40,
                                          width: 40,
                                          image: NetworkImage(
                                              '${Environments.apiBaseURL}storage/images/${item.storeInfo?.cover.toString()}'),
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
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.storeInfo!.name.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'bold'),
                                            ),
                                            Text(
                                              item.storeInfo!.address
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Toatal Guest -'.tr +
                                          item.totalGuest.toString(),
                                      style:
                                          const TextStyle(fontFamily: 'bold'),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Booking Date -'.tr +
                                          item.savedDate.toString(),
                                      style: const TextStyle(
                                          color: ThemeProvider.greyColor,
                                          fontFamily: 'medium'),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Guest Name -'.tr +
                                          item.guestName.toString(),
                                      style: const TextStyle(
                                          color: ThemeProvider.appColor),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Guest Email -'.tr +
                                          item.email.toString(),
                                      style: const TextStyle(
                                          color: ThemeProvider.appColor),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Guest Mobile -'.tr +
                                          item.mobile.toString(),
                                      style: const TextStyle(
                                          color: ThemeProvider.appColor),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: ThemeProvider.appColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      value.status[
                                          item.storeInfo?.status as int],
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
      },
    );
  }
}
