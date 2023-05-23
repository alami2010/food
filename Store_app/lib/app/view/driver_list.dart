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
import 'package:vender/app/controller/driver_list_controller.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/util/theme.dart';

class DriverList extends StatefulWidget {
  const DriverList({Key? key}) : super(key: key);

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverListController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          automaticallyImplyLeading: false,
          title: Text(
            'Select Driver'.tr,
            style: const TextStyle(
                fontFamily: 'bold',
                fontSize: 18,
                color: ThemeProvider.whiteColor),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: List.generate(
                value.driverList.length,
                (index) => Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: InkWell(
                        onTap: () {
                          value.onSaveDriver(value.driverList[index].id as int);
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage(
                                height: 40,
                                width: 40,
                                image: NetworkImage(
                                    '${Environments.apiBaseURL}storage/images/${value.driverList[index].cover.toString()}'),
                                placeholder:
                                    const AssetImage("assets/images/error.png"),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset('assets/images/error.png',
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.fitWidth);
                                },
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${value.driverList[index].firstName} ${value.driverList[index].lastName}',
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: 'medium'),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      // '12345.56 KM',
                                      '${value.driverList[index].distance} KM',
                                      style: const TextStyle(
                                          color: ThemeProvider.greyColor,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Icon(
                              value.selectedDriverId !=
                                      value.driverList[index].id
                                  ? Icons.circle_outlined
                                  : Icons.radio_button_checked,
                              color: ThemeProvider.greyColor,
                            )
                          ],
                        ),
                      ),
                    )),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    value.onBack();
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
                    'Cancel'.tr,
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
                    value.onSaveAndExit();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ThemeProvider.greenColor,
                    onPrimary: ThemeProvider.whiteColor,
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Select',
                    style: TextStyle(
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
    });
  }
}
