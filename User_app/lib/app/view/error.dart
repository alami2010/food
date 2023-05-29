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
import 'package:foodies_user/app/helper/router.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset(
                "assets/images/error.png",
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Text('Connection Failed'.tr),
            ),
            Center(
              child: Text('Could not connect to network,'.tr),
            ),
            Center(
              child: Text('Please check and try again.'.tr),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 13),
                    blurRadius: 25,
                    color: const Color(0xFF5666C2).withOpacity(0.17),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Get.offNamed(AppRouter.getInitialRoute());
                },
                child: Text(
                  "retry".tr.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
