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
import 'package:upgrade/app/controller/saved_address_controller.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:get/get.dart';

class SavedAddress extends StatefulWidget {
  const SavedAddress({Key? key}) : super(key: key);

  @override
  State<SavedAddress> createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedAddressController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          title: Text(
            'Address'.tr,
            style: ThemeProvider.titleStyle,
          ),
          actions: [
            TextButton(
              onPressed: () {
                value.onAddNewAddress();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: ThemeProvider.whiteColor,
                  ),
                  Text(
                    'Add New'.tr,
                    style: const TextStyle(color: ThemeProvider.whiteColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: value.apiCalled == false
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: SkeletonListView(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    for (var item in value.addressList)
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300, blurRadius: 30),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  value.titles[item.title as int].toString(),
                                  style: const TextStyle(
                                      fontFamily: 'medium', fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color:
                                              ThemeProvider.secondaryAppColor),
                                      child: InkWell(
                                        onTap: () {
                                          value.updateAddress(item.id as int);
                                        },
                                        child: Text(
                                          'Edit'.tr,
                                          style: const TextStyle(
                                              color: ThemeProvider.whiteColor),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: ThemeProvider.appColor),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                contentPadding:
                                                    const EdgeInsets.all(20),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/delete.png',
                                                        fit: BoxFit.cover,
                                                        height: 80,
                                                        width: 80,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        'Are you sure'.tr,
                                                        style: const TextStyle(
                                                            fontSize: 24,
                                                            fontFamily:
                                                                'semi-bold'),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text('to delete Address ?'
                                                          .tr),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary:
                                                                    ThemeProvider
                                                                        .greyColor,
                                                                onPrimary:
                                                                    ThemeProvider
                                                                        .whiteColor,
                                                                minimumSize:
                                                                    const Size
                                                                        .fromHeight(35),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                'Cancel'.tr,
                                                                style:
                                                                    const TextStyle(
                                                                  color: ThemeProvider
                                                                      .whiteColor,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Expanded(
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                Get.find<
                                                                        SavedAddressController>()
                                                                    .deleteAddress(
                                                                        item.id
                                                                            as int);
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary:
                                                                    ThemeProvider
                                                                        .appColor,
                                                                onPrimary:
                                                                    ThemeProvider
                                                                        .whiteColor,
                                                                minimumSize:
                                                                    const Size
                                                                        .fromHeight(35),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                'Delete'.tr,
                                                                style:
                                                                    const TextStyle(
                                                                  color: ThemeProvider
                                                                      .whiteColor,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Delete'.tr,
                                          style: const TextStyle(
                                              color: ThemeProvider.whiteColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Text(item.address.toString() +
                                  ' ' +
                                  item.house.toString() +
                                  ' ' +
                                  item.landmark.toString() +
                                  ' ' +
                                  item.optionalPhone.toString()),
                            ),
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
