/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/controller/choose_location_controller.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:get/get.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseLocationController>(builder: (value) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Access Your'.tr),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Location'.tr,
                style: const TextStyle(
                    color: ThemeProvider.appColor,
                    fontSize: 20,
                    fontFamily: 'semi-bold'),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/location.png',
                height: 80,
                width: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  value.getLocation();
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
                  'USE CURRENT LOCATION'.tr,
                  style: const TextStyle(
                      color: ThemeProvider.whiteColor,
                      fontSize: 14,
                      letterSpacing: 1.1),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  value.onCategory();
                },
                child: Text(
                  'CHOOSE LOCATION'.tr,
                  style: const TextStyle(
                      color: ThemeProvider.appColor, letterSpacing: 1.1),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
