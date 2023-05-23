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
import 'package:vender/app/controller/login_controller.dart';
import 'package:vender/app/util/constant.dart';
import 'package:vender/app/util/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  Get.find<LoginController>().saveLanguage(e.languageCode);
                },
                child: Text(e.languageName.toString()),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.transParent,
          elevation: 0,
          actions: <Widget>[getLanguages()],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log In'.tr,
                style: const TextStyle(fontFamily: 'bold', fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: value.emailTextEditor,
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Email Address'.tr),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: value.passwordTextEditor,
                obscureText: value.passwordVisible,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Password'.tr,
                  suffixIcon: IconButton(
                    onPressed: () {
                      value.togglePasswordBtn();
                    },
                    icon: Icon(
                      value.passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      value.onForgotPassword();
                    },
                    child: Text(
                      'Forgot Password?'.tr,
                      style: const TextStyle(color: ThemeProvider.appColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  value.onLogin();
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
                  'SIGN IN'.tr,
                  style: const TextStyle(
                    color: ThemeProvider.whiteColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
