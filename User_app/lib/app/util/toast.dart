/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:get/get.dart';

void showToast(String message, {bool isError = true}) {
  HapticFeedback.lightImpact();
  Get.showSnackbar(GetSnackBar(
    backgroundColor: isError ? Colors.red : Colors.black,
    message: message.tr,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}

void successToast(String message) {
  HapticFeedback.lightImpact();
  Get.showSnackbar(GetSnackBar(
    backgroundColor: Colors.green,
    message: message.tr,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}

Future<bool> clearCartAlert() async {
  HapticFeedback.lightImpact();
  bool clean = false;
  await Get.generalDialog(
      pageBuilder: (context, __, ___) => AlertDialog(
            title: const Text('Warning'),
            content: const Text(
                "You already have item's in cart with different grocery store"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  clean = false;
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: ThemeProvider.blackColor, fontFamily: 'medium'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  clean = true;
                },
                child: const Text(
                  'Clear Cart',
                  style: TextStyle(
                      color: ThemeProvider.appColor, fontFamily: 'bold'),
                ),
              )
            ],
          ));
  return clean;
}

Future<bool> notificationDialog(String title, String message) async {
  HapticFeedback.lightImpact();
  bool clean = false;
  await Get.generalDialog(
      pageBuilder: (context, __, ___) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  clean = true;
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: ThemeProvider.blackColor, fontFamily: 'medium'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  clean = true;
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: ThemeProvider.appColor, fontFamily: 'bold'),
                ),
              )
            ],
          ));
  return clean;
}
