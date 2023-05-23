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
import 'package:upgrade/app/controller/delivery_address_controller.dart';
import 'package:upgrade/app/util/theme.dart';

class DeliveryAdrress extends StatefulWidget {
  const DeliveryAdrress({Key? key}) : super(key: key);

  @override
  State<DeliveryAdrress> createState() => _DeliveryAdrressState();
}

class _DeliveryAdrressState extends State<DeliveryAdrress> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryAddressController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            title: Text(
              'Delivery Address'.tr,
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
              ? SkeletonListView()
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
                              Text(
                                value.titles[item.title as int].toString(),
                                style: const TextStyle(
                                    fontFamily: 'medium', fontSize: 16),
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
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      value.saveDeliveryAddress(item.id as int);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: ThemeProvider.appColor),
                                      child: Text(
                                        'Delivered Here'.tr,
                                        style: const TextStyle(
                                            color: ThemeProvider.whiteColor),
                                      ),
                                    ),
                                  ),
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
