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
import 'package:vender/app/controller/language_controller.dart';
import 'package:vender/app/util/constant.dart';
import 'package:vender/app/util/theme.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: true,
          title: Text('Languages'.tr, style: ThemeProvider.titleStyle),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeProvider.whiteColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            for (var language in AppConstants.languages)
              ListTile(
                title: Text(language.languageName),
                leading: Radio(
                    value: language.languageCode,
                    groupValue: value.languageCode,
                    onChanged: (e) {
                      value.saveLanguages(e.toString());
                    }),
              )
          ]),
        ),
      );
    });
  }
}
