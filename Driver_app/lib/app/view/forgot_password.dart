/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/controller/forgot_password_controller.dart';
import 'package:driver/app/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          title: Text(
            'Reset Password'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: AbsorbPointer(
          absorbing: value.isLogin.value == false ? false : true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: value.divNumber == 1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter your email address or phone number and we will send a verification code to generate a new password'
                            .tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: value.emailReset,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Email Address'.tr),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          value.sendMail();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: ThemeProvider.appColor,
                          onPrimary: ThemeProvider.whiteColor,
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: value.isLogin.value == true
                            ? const CircularProgressIndicator(
                                color: ThemeProvider.whiteColor,
                              )
                            : Text(
                                'Send OTP'.tr,
                                style: const TextStyle(
                                    fontFamily: 'regular', fontSize: 16),
                              ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Generate New Password'.tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: value.passwordReset,
                        textInputAction: TextInputAction.done,
                        obscureText:
                            value.passwordVisible.value == true ? false : true,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelText: 'New Password'.tr,
                            suffixIcon: InkWell(
                              onTap: () {
                                value.togglePassword();
                              },
                              child: Icon(
                                value.passwordVisible.value == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ThemeProvider.appColor,
                              ),
                            ),
                            labelStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'regular',
                                color: ThemeProvider.blackColor)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: value.confirmPasswordReset,
                        textInputAction: TextInputAction.done,
                        obscureText:
                            value.passwordVisible.value == true ? false : true,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelText: 'Confirm Password'.tr,
                            suffixIcon: InkWell(
                              onTap: () {
                                value.togglePassword();
                              },
                              child: Icon(
                                value.passwordVisible.value == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ThemeProvider.appColor,
                              ),
                            ),
                            labelStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'regular',
                                color: ThemeProvider.blackColor)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          value.updatePassword();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: ThemeProvider.appColor,
                          onPrimary: ThemeProvider.whiteColor,
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: value.isLogin.value == true
                            ? const CircularProgressIndicator(
                                color: ThemeProvider.whiteColor,
                              )
                            : Text(
                                'Update Password'.tr,
                                style: const TextStyle(
                                    fontFamily: 'regular', fontSize: 16),
                              ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
