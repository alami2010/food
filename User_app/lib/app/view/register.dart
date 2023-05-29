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
import 'package:foodies_user/app/controller/register_controller.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (value) {
      return Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          padding:
              const EdgeInsets.only(top: 60, bottom: 16, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create account'.tr,
                style: const TextStyle(fontFamily: 'bold', fontSize: 22),
              ),
              Text(
                'Please register to your account'.tr,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: value.firstName,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'First Name'.tr),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: value.lastName,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Last Name'.tr),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: value.emailTextEditor,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Email Address'.tr,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: ThemeProvider.greyColor))),
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
                                value.saveCountryCode(country.phoneCode);
                              },
                              countryListTheme: CountryListThemeData(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                                inputDecoration: InputDecoration(
                                  labelText: 'Search'.tr,
                                  hintText: 'Start typing to search'.tr,
                                  prefixIcon: const Icon(Icons.search),
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
                controller: value.password,
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
                height: 15,
              ),
              TextField(
                controller: value.confirmPassword,
                obscureText: value.confirmPasswordVisible,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Confirm Password'.tr,
                  suffixIcon: IconButton(
                    onPressed: () {
                      value.confirmPasswordBtn();
                    },
                    icon: Icon(
                      value.confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: value.referralCode,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Referral Code (Optional)'.tr,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  value.onRegister();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeProvider.appColor,
                  foregroundColor: ThemeProvider.whiteColor,
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Sign Up'.tr,
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
                          'By Clicking Sign up you certify that you agree to our '
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
                          value.onAppPages();
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
                          value.onAppPages();
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Already have an account '.tr,
                  style: const TextStyle(
                    fontFamily: 'regular',
                    fontSize: 14,
                    color: ThemeProvider.greyColor,
                  ),
                ),
                TextSpan(
                  text: ' Sign In'.tr,
                  style: const TextStyle(
                    fontFamily: 'medium',
                    fontSize: 16,
                    color: ThemeProvider.appColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      value.onLogin();
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
