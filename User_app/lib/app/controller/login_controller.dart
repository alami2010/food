/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/parse/login_parse.dart';
import 'package:foodies_user/app/controller/account_controller.dart';
import 'package:foodies_user/app/controller/app_pages_controller.dart';
import 'package:foodies_user/app/controller/history_controller.dart';
import 'package:foodies_user/app/controller/home_controller.dart';
import 'package:foodies_user/app/controller/my_cart_controller.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/util/constant.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:foodies_user/app/util/toast.dart';

class LoginController extends GetxController implements GetxService {
  final LoginParse parser;

  final emailTextEditor = TextEditingController();
  final passwordTextEditor = TextEditingController();

  String countryCode = '+91';
  final mobileNo = TextEditingController();
  bool passwordVisible = false;
  int loginVersion = AppConstants.userLogin;
  String smsName = AppConstants.defaultSMSGateway;
  int smsId = 1;
  String otpCode = '';
  LoginController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    smsName = parser.getSMSName();
    loginVersion = parser.getUserLoginMethod();
    emailTextEditor.text = '';
    passwordTextEditor.text = '';
  }

  Future<void> onLogin() async {
    if (emailTextEditor.text == '' ||
        emailTextEditor.text.isEmpty ||
        passwordTextEditor.text == '' ||
        passwordTextEditor.text.isEmpty) {
      showToast('All fields are required');
      return;
    }
    if (!GetUtils.isEmail(emailTextEditor.text)) {
      showToast("Email is not valid");
      return;
    }
    var body = {
      "email": emailTextEditor.text,
      "password": passwordTextEditor.text
    };
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);

    var response = await parser.onLogin(body);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['user'] != '' &&
          myMap['token'] != '' &&
          myMap['user']['type'] == 1) {
        if (myMap['user']['status'] == 1) {
          debugPrint(myMap['user']['id'].toString());
          debugPrint(myMap['user']['email'].toString());
          debugPrint(myMap['user']['first_name'].toString());
          debugPrint(myMap['user']['last_name'].toString());
          debugPrint(myMap['user']['cover'].toString());

          parser.saveInfo(
            myMap['token'].toString(),
            myMap['user']['id'].toString(),
            myMap['user']['first_name'].toString(),
            myMap['user']['last_name'].toString(),
            myMap['user']['email'].toString(),
            myMap['user']['cover'].toString(),
            myMap['user']['mobile'].toString(),
          );
          var updateParam = {
            "id": myMap['user']['id'].toString(),
            'fcm_token': parser.getFcmToken(),
          };
          await parser.updateProfile(updateParam, myMap['token']);
          Get.delete<HomeController>(force: true);
          Get.delete<HistoryController>(force: true);
          Get.delete<LoginController>(force: true);
          Get.delete<AccountController>(force: true);
          Get.find<MyCartController>().getCart();
          Get.offNamed(AppRouter.getTab());
        } else {
          showToast('Your account is suspended');
        }
      } else {
        showToast('Something went wrong while signup');
      }
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  void onRegister() {
    Get.toNamed(AppRouter.getRegister());
  }

  void onForgotPassword() {
    Get.toNamed(AppRouter.getForgotPassword());
  }

  void onChooseLocation() {
    Get.toNamed(AppRouter.getChooseLocation());
  }

  void onAppPages(String id, String name) {
    Get.delete<AppPagesController>(force: true);
    Get.toNamed(AppRouter.getAppPages(), arguments: [id, name]);
  }

  void togglePasswordBtn() {
    passwordVisible = !passwordVisible;
    update();
  }

  void saveCountryCode(String code) {
    countryCode = '+$code';
    update();
  }

  Future<void> loginWithPhonePassword() async {
    if (mobileNo.text == '' || passwordTextEditor.text == '') {
      showToast('All fields are required');
      return;
    }
    update();
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);

    var param = {
      'country_code': countryCode,
      'mobile': mobileNo.text,
      'password': passwordTextEditor.text
    };
    Response response = await parser.loginWithPhonePasswordPost(param);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['user'] != '' &&
          myMap['token'] != '' &&
          myMap['user']['type'] == 1) {
        if (myMap['user']['status'] == 1) {
          debugPrint(myMap['user']['id'].toString());
          debugPrint(myMap['user']['email'].toString());
          debugPrint(myMap['user']['first_name'].toString());
          debugPrint(myMap['user']['last_name'].toString());
          debugPrint(myMap['user']['cover'].toString());

          parser.saveInfo(
            myMap['token'].toString(),
            myMap['user']['id'].toString(),
            myMap['user']['first_name'].toString(),
            myMap['user']['last_name'].toString(),
            myMap['user']['email'].toString(),
            myMap['user']['cover'].toString(),
            myMap['user']['mobile'].toString(),
          );
          var updateParam = {
            "id": myMap['user']['id'].toString(),
            'fcm_token': parser.getFcmToken(),
          };
          await parser.updateProfile(updateParam, myMap['token']);
          Get.delete<HomeController>(force: true);
          Get.delete<HistoryController>(force: true);
          Get.delete<LoginController>(force: true);
          Get.delete<AccountController>(force: true);
          Get.find<MyCartController>().getCart();
          Get.offNamed(AppRouter.getTab());
        } else {
          showToast('Your account is suspended');
        }
      } else {
        showToast('Something went wrong while signup');
      }
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  Future<void> loginWithPhoneOTP() async {
    if (mobileNo.text == '') {
      showToast('Phone Number is required');
      return;
    }

    if (smsName == '2') {
      Get.dialog(
          SimpleDialog(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const CircularProgressIndicator(
                    color: ThemeProvider.appColor,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                      child: Text(
                    "Please wait".tr,
                    style: const TextStyle(fontFamily: 'bold'),
                  )),
                ],
              )
            ],
          ),
          barrierDismissible: false);

      var param = {'country_code': countryCode, 'mobile': mobileNo.text};

      Response response = await parser.verifyPhoneWithFirebase(param);
      Get.back();
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['data'] != '' && myMap['data'] == true) {
          FocusManager.instance.primaryFocus?.unfocus();
          Get.toNamed(AppRouter.getFirebaseVerificationRoutes(),
              arguments: [countryCode, mobileNo.text]);
        } else {
          showToast('Something went wrong while signup');
        }
        update();
      } else if (response.statusCode == 401) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['error'] != '') {
          showToast(myMap['error']);
        } else {
          showToast('Something went wrong');
        }
        update();
      } else if (response.statusCode == 500) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['error'] != '') {
          showToast(myMap['error']);
        } else {
          showToast('Something went wrong');
        }
        update();
      } else {
        ApiChecker.checkApi(response);
        update();
      }
      update();
    } else {
      Get.dialog(
          SimpleDialog(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const CircularProgressIndicator(
                    color: ThemeProvider.appColor,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                      child: Text(
                    "Please wait".tr,
                    style: const TextStyle(fontFamily: 'bold'),
                  )),
                ],
              )
            ],
          ),
          barrierDismissible: false);

      var param = {'country_code': countryCode, 'mobile': mobileNo.text};
      Response response = await parser.verifyPhone(param);
      Get.back();
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['data'] != '' && myMap['data'] == true) {
          smsId = myMap['otp_id'];
          FocusManager.instance.primaryFocus?.unfocus();
          var context = Get.context as BuildContext;
          // ignore: use_build_context_synchronously
          openOTPModal(
              context, countryCode.toString() + mobileNo.text.toString());
        } else {
          showToast('Something went wrong while signup');
        }
        update();
      } else if (response.statusCode == 401) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['error'] != '') {
          showToast(myMap['error']);
        } else {
          showToast('Something went wrong');
        }
        update();
      } else if (response.statusCode == 500) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['error'] != '') {
          showToast(myMap['error']);
        } else {
          showToast('Something went wrong');
        }
        update();
      } else {
        ApiChecker.checkApi(response);
        update();
      }
      update();
    }
  }

  void openOTPModal(context, String text) {
    showDialog(
        context: context,
        barrierColor: ThemeProvider.appColor,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(0.0),
            title: Text(
              "Verification".tr,
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Column(
                children: [
                  Text(
                    'We have sent verification code on'.tr,
                    style: const TextStyle(fontSize: 12, fontFamily: 'medium'),
                  ),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 12, fontFamily: 'medium'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: ThemeProvider.greyColor,
                    keyboardType: TextInputType.number,
                    focusedBorderColor: ThemeProvider.appColor,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      otpCode = verificationCode;
                      onOtpSubmit(context);
                    }, // end onSubmit
                  ),
                  // OTP
                ],
              )),
            ),
            actions: [
              Container(
                  height: 45,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      color: Colors.white),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (otpCode != '' && otpCode.length >= 6) {
                          onOtpSubmit(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: ThemeProvider.whiteColor,
                        backgroundColor: ThemeProvider.appColor,
                        elevation: 0,
                      ),
                      child: Text(
                        'Verify'.tr,
                        style: const TextStyle(
                            fontFamily: 'regular', fontSize: 16),
                      )))
            ],
          );
        });
  }

  Future<void> onOtpSubmit(context) async {
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    var param = {'id': smsId, 'otp': otpCode};
    Response response = await parser.verifyOTP(param);
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != '' && myMap['success'] == true) {
        Navigator.of(context).pop(true);
        loginWithPhoneToken();
      } else {
        showToast('Something went wrong while signup');
      }
      update();
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> loginWithPhoneToken() async {
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    var param = {'country_code': countryCode, 'mobile': mobileNo.text};
    Response response = await parser.loginWithPhoneToken(param);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['user'] != '' &&
          myMap['token'] != '' &&
          myMap['user']['type'] == 1) {
        if (myMap['user']['status'] == 1) {
          debugPrint(myMap['user']['id'].toString());
          debugPrint(myMap['user']['email'].toString());
          debugPrint(myMap['user']['first_name'].toString());
          debugPrint(myMap['user']['last_name'].toString());
          debugPrint(myMap['user']['cover'].toString());

          parser.saveInfo(
            myMap['token'].toString(),
            myMap['user']['id'].toString(),
            myMap['user']['first_name'].toString(),
            myMap['user']['last_name'].toString(),
            myMap['user']['email'].toString(),
            myMap['user']['cover'].toString(),
            myMap['user']['mobile'].toString(),
          );
          var updateParam = {
            "id": myMap['user']['id'].toString(),
            'fcm_token': parser.getFcmToken(),
          };
          await parser.updateProfile(updateParam, myMap['token']);
          Get.delete<HomeController>(force: true);
          Get.delete<HistoryController>(force: true);
          Get.delete<LoginController>(force: true);
          Get.delete<AccountController>(force: true);
          Get.find<MyCartController>().getCart();
          Get.offNamed(AppRouter.getTab());
        } else {
          showToast('Your account is suspended');
        }
      } else {
        showToast('Something went wrong while signup');
      }
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }
}
