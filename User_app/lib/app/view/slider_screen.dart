/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/controller/slider_screen_controller.dart';
import 'package:upgrade/app/util/constant.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:get/get.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  Widget getLanguages() {
    return PopupMenuButton(
      onSelected: (value) {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: IconButton(
          icon: const Icon(Icons.translate),
          color: ThemeProvider.appColor,
          onPressed: () {},
        ),
      ),
      itemBuilder: (context) => AppConstants.languages
          .map((e) => PopupMenuItem<String>(
                value: e.languageCode.toString(),
                onTap: () {
                  var locale = Locale(e.languageCode.toString());
                  Get.updateLocale(locale);
                  Get.find<SliderScreenController>()
                      .saveLanguage(e.languageCode);
                },
                child: Text(e.languageName.toString()),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderScreenController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.whiteColor,
          elevation: 0,
          actions: <Widget>[getLanguages()],
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: value.controller,
                itemCount: value.contents.length,
                onPageChanged: (int index) {
                  value.updateSliderIndex(index);
                },
                itemBuilder: (_, i) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        value.contents[i].image.toString(),
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        children: [
                          Text(
                            value.contents[i].title.toString().tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'bold', fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: Text(
                              value.contents[i].description.toString().tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: ThemeProvider.greyColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                value.contents.length,
                (index) => Container(
                  height: 10,
                  width: value.currentIndex == index ? 25 : 10,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ThemeProvider.appColor),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        value.onChooseLocation();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ThemeProvider.appColor,
                        elevation: 0,
                        onPrimary: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Skip'.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'medium',
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (value.currentIndex == value.contents.length - 1) {
                          value.onChooseLocation();
                        }
                        value.controller.nextPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceIn);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ThemeProvider.appColor,
                        elevation: 0,
                        onPrimary: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        value.currentIndex == value.contents.length - 1
                            ? "Continue".tr
                            : "Next".tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'medium',
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
