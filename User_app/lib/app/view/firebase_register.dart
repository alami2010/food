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
import 'package:upgrade/app/controller/firebase_register_controller.dart';
import 'package:upgrade/app/util/constant.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FirebaseRegisterScreen extends StatefulWidget {
  const FirebaseRegisterScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseRegisterScreen> createState() => _FirebaseRegisterScreenState();
}

class _FirebaseRegisterScreenState extends State<FirebaseRegisterScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirebaseRegisterController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          centerTitle: false,
          title: Text('Verify your phone number'.tr,
              style: ThemeProvider.titleStyle),
        ),
        body: Stack(
          children: <Widget>[
            WebView(
              initialUrl:
                  '${value.apiURL}${AppConstants.openFirebaseVerification}mobile=${value.countryCode}${value.phoneNumber}',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {},
              onProgress: (int progress) {},
              navigationDelegate: (NavigationRequest request) {
                if (request.url.contains('success_verified')) {
                  value.onLogin(context);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {
                setState(() {
                  isLoading = false;
                });
              },
              gestureNavigationEnabled: true,
              backgroundColor: ThemeProvider.appColor,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ThemeProvider.whiteColor,
                    ),
                  )
                : Stack(),
          ],
        ),
      );
    });
  }
}
