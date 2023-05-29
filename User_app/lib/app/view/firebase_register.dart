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
import 'package:foodies_user/app/controller/firebase_register_controller.dart';
import 'package:foodies_user/app/util/constant.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FirebaseRegisterScreen extends StatefulWidget {
  const FirebaseRegisterScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseRegisterScreen> createState() => _FirebaseRegisterScreenState();
}

class _FirebaseRegisterScreenState extends State<FirebaseRegisterScreen> {
  bool isLoading = true;

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final WebViewController controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('success_verified')) {
              Get.find<FirebaseRegisterController>().onLogin(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(
          '${Get.find<FirebaseRegisterController>().apiURL}${AppConstants.openFirebaseVerification}mobile=${Get.find<FirebaseRegisterController>().countryCode}${Get.find<FirebaseRegisterController>().phoneNumber}'));
    _controller = controller;
  }

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
            WebViewWidget(controller: _controller),
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
