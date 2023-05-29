/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/models/redeem_model.dart';
import 'package:foodies_user/app/backend/parse/refer_earn_parse.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/env.dart';
import 'package:foodies_user/app/util/toast.dart';

class ReferEarnController extends GetxController implements GetxService {
  final ReferEarnParse parser;
  bool apiCalled = false;
  RedeemModel _referralData = RedeemModel();
  RedeemModel get referralData => _referralData;
  String myCode = '';
  String userName = '';
  bool haveReferral = false;
  ReferEarnController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    userName = parser.getName();
    getMyCode();
  }

  Future<void> getMyCode() async {
    Response response = await parser.getMyCode();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != null &&
          myMap['data'] != '' &&
          myMap['referral'] != null &&
          myMap['referral'] != '') {
        haveReferral = true;
        dynamic body = myMap["data"];
        myCode = body['code'];
        RedeemModel referralCode = RedeemModel.fromJson(myMap["referral"]);
        _referralData = referralCode;
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> share() async {
    String title =
        '${'Your friend'.tr} $userName ${'has invited you to'.tr} ${Environments.appName}';
    String message =
        '${'Hey Buddy download'.tr} ${Environments.appName} ${'from app store and use my code'.tr} $myCode${'while sign up we both will get'.tr} ${referralData.amount} ${'wallet amount'.tr}';
    await FlutterShare.share(
        title: title,
        text: message,
        linkUrl: Environments.websiteURL,
        chooserTitle: 'Share with buddies'.tr);
  }

  void copyToClipBoard() {
    Clipboard.setData(ClipboardData(text: myCode)).then((_) {
      successToast('Copied to clipboard');
    });
  }
}
