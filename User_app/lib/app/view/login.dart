/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:upgrade/app/controller/login_controller.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (value) {
      return Scaffold(
        body: value.loginVersion == 0
            ? SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 60, bottom: 20, left: 20, right: 20),
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
                        labelText: 'Email Address'.tr,
                      ),
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
                            style:
                                const TextStyle(color: ThemeProvider.appColor),
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
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'By Clicking Sign In you certify that you agree to our '
                                    .tr,
                            style: const TextStyle(
                              fontFamily: 'regular',
                              fontSize: 14,
                              color: ThemeProvider.greyColor,
                            ),
                          ),
                          TextSpan(
                            text: ' Privacy Policy'.tr,
                            style: const TextStyle(
                              fontFamily: 'medium',
                              fontSize: 14,
                              color: ThemeProvider.appColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                value.onAppPages('2', 'Privacy Policy'.tr);
                              },
                          ),
                          TextSpan(
                            text: ' and '.tr,
                            style: const TextStyle(
                              fontFamily: 'regular',
                              fontSize: 14,
                              color: ThemeProvider.greyColor,
                            ),
                          ),
                          TextSpan(
                            text: ' Terms and Condition'.tr,
                            style: const TextStyle(
                              fontFamily: 'medium',
                              fontSize: 14,
                              color: ThemeProvider.appColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                value.onAppPages('3', 'Terms & Conditions'.tr);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : value.loginVersion == 1
                ? SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        top: 60, bottom: 20, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Log In'.tr,
                          style:
                              const TextStyle(fontFamily: 'bold', fontSize: 22),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: ThemeProvider.greyColor))),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 12),
                                  child: InkWell(
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        exclude: <String>['KN', 'MF'],
                                        showPhoneCode: true,
                                        showWorldWide: false,
                                        onSelect: (Country country) {
                                          debugPrint(country.phoneCode);
                                          value.saveCountryCode(
                                              country.phoneCode);
                                        },
                                        countryListTheme: CountryListThemeData(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(40.0),
                                            topRight: Radius.circular(40.0),
                                          ),
                                          inputDecoration: InputDecoration(
                                            labelText: 'Search'.tr,
                                            hintText:
                                                'Start typing to search'.tr,
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: const Color(0xFF8C98A8)
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(value.countryCode),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 10,
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  controller: value.mobileNo,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Phone Number'.tr),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: value.passwordTextEditor,
                          obscureText: value.passwordVisible,
                          textInputAction: TextInputAction.next,
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
                                style: const TextStyle(
                                    color: ThemeProvider.appColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            value.loginWithPhonePassword();
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
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'By Clicking Sign In you certify that you agree to our '
                                        .tr,
                                style: const TextStyle(
                                  fontFamily: 'regular',
                                  fontSize: 14,
                                  color: ThemeProvider.greyColor,
                                ),
                              ),
                              TextSpan(
                                text: ' Privacy Policy'.tr,
                                style: const TextStyle(
                                  fontFamily: 'medium',
                                  fontSize: 14,
                                  color: ThemeProvider.appColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    value.onAppPages('2', 'Privacy Policy'.tr);
                                  },
                              ),
                              TextSpan(
                                text: ' and '.tr,
                                style: const TextStyle(
                                  fontFamily: 'regular',
                                  fontSize: 14,
                                  color: ThemeProvider.greyColor,
                                ),
                              ),
                              TextSpan(
                                text: ' Terms and Condition'.tr,
                                style: const TextStyle(
                                  fontFamily: 'medium',
                                  fontSize: 14,
                                  color: ThemeProvider.appColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    value.onAppPages(
                                        '3', 'Terms & Conditions'.tr);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : value.loginVersion == 2
                    ? SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            top: 60, bottom: 20, left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Log In'.tr,
                              style: const TextStyle(
                                  fontFamily: 'bold', fontSize: 22),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ThemeProvider.greyColor))),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 12),
                                      child: InkWell(
                                        onTap: () {
                                          showCountryPicker(
                                            context: context,
                                            exclude: <String>['KN', 'MF'],
                                            showPhoneCode: true,
                                            showWorldWide: false,
                                            onSelect: (Country country) {
                                              debugPrint(country.phoneCode);
                                              value.saveCountryCode(
                                                  country.phoneCode);
                                            },
                                            countryListTheme:
                                                CountryListThemeData(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(40.0),
                                                topRight: Radius.circular(40.0),
                                              ),
                                              inputDecoration: InputDecoration(
                                                labelText: 'Search'.tr,
                                                hintText:
                                                    'Start typing to search'.tr,
                                                prefixIcon:
                                                    const Icon(Icons.search),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:
                                                        const Color(0xFF8C98A8)
                                                            .withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(value.countryCode),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: TextField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      controller: value.mobileNo,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Phone Number'.tr),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
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
                                    style: const TextStyle(
                                        color: ThemeProvider.appColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                value.loginWithPhoneOTP();
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
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'By Clicking Sign In you certify that you agree to our '
                                            .tr,
                                    style: const TextStyle(
                                      fontFamily: 'regular',
                                      fontSize: 14,
                                      color: ThemeProvider.greyColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Privacy Policy'.tr,
                                    style: const TextStyle(
                                      fontFamily: 'medium',
                                      fontSize: 14,
                                      color: ThemeProvider.appColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        value.onAppPages(
                                            '2', 'Privacy Policy'.tr);
                                      },
                                  ),
                                  TextSpan(
                                    text: ' and '.tr,
                                    style: const TextStyle(
                                      fontFamily: 'regular',
                                      fontSize: 14,
                                      color: ThemeProvider.greyColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Terms and Condition'.tr,
                                    style: const TextStyle(
                                      fontFamily: 'medium',
                                      fontSize: 14,
                                      color: ThemeProvider.appColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        value.onAppPages(
                                            '3', 'Terms & Conditions'.tr);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'New user? '.tr,
                  style: const TextStyle(
                    fontFamily: 'regular',
                    fontSize: 14,
                    color: ThemeProvider.greyColor,
                  ),
                ),
                TextSpan(
                  text: ' Sign Up'.tr,
                  style: const TextStyle(
                    fontFamily: 'medium',
                    fontSize: 16,
                    color: ThemeProvider.appColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      value.onRegister();
                    },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
