/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies_user/app/controller/splash_screen_controller.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:foodies_user/app/util/toast.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    print("hello world");

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    print("hello _connectivitySubscription");
    Get.find<SplashScreenController>().initSharedData();
    print("hello initSharedData");
    _routing();
    print("hello _routing");
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  void _routing() {
    Get.find<SplashScreenController>().getConfigData().then((isSuccess) {
      print(isSuccess);
      if (isSuccess) {
        if (Get.find<SplashScreenController>().getLanguageCode() != '') {
          var locale = Get.find<SplashScreenController>().getLanguageCode();
          Get.updateLocale(Locale(locale));
        } else {
          var locale =
              Get.find<SplashScreenController>().defaultLanguage.languageCode !=
                          '' &&
                      Get.find<SplashScreenController>()
                              .defaultLanguage
                              .languageCode !=
                          ''
                  ? Locale(Get.find<SplashScreenController>()
                      .defaultLanguage
                      .languageCode
                      .toString())
                  : const Locale('en');
          Get.updateLocale(locale);
        }

        if (Get.find<SplashScreenController>().parser.isNewUser() == false) {
          Get.find<SplashScreenController>().parser.saveWelcome(true);
          Get.offNamed(AppRouter.getSliderScreen());
        } else {
          Get.find<SplashScreenController>().parser.saveWelcome(true);
          Get.offNamed(AppRouter.getChooseLocation());
        }
      } else {
        Get.toNamed(AppRouter.getErroRoutes());
      }
    });
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      e;
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    bool isNotConnected = result != ConnectivityResult.wifi &&
        result != ConnectivityResult.mobile;

    if (isNotConnected) {
      showToast('No Internet Connection'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.whiteColor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash.gif',
                fit: BoxFit.cover,
                height: 400,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator(
                color: ThemeProvider.appColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Please wait'.tr,
                style: const TextStyle(
                    color: ThemeProvider.appColor, fontFamily: 'bold'),
              )
            ],
          ),
        ),
      );
    });
  }
}
