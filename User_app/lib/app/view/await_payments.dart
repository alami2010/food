/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upgrade/app/controller/await_payments_controller.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AwaitPaymentScreen extends StatefulWidget {
  const AwaitPaymentScreen({Key? key}) : super(key: key);

  @override
  State<AwaitPaymentScreen> createState() => _AwaitPaymentScreenState();
}

class _AwaitPaymentScreenState extends State<AwaitPaymentScreen> {
  bool isLoading = true;
  bool recallAPI = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AwaitPaymentsController>(builder: (value) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              WebView(
                initialUrl: value.paymentURL,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {},
                onProgress: (int progress) {},
                navigationDelegate: (NavigationRequest request) {
                  checkCallback(request.url);
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  checkCallback(url);
                },
                onPageFinished: (String url) {
                  setState(() {
                    isLoading = false;
                  });
                  checkCallback(url);
                },
                gestureNavigationEnabled: true,
                backgroundColor: ThemeProvider.whiteColor,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: ThemeProvider.appColor,
                      ),
                    )
                  : Stack(),
            ],
          ),
        ),
      );
    });
  }

  void checkCallback(String callback) {
    debugPrint(callback);
    if (recallAPI == true) {
      if (callback.contains('success_payments') ||
          callback.contains('failed_payments') ||
          callback.contains('status=authorized') ||
          callback.contains('status=failed') ||
          callback.contains('success') ||
          callback.contains('close') ||
          callback.contains('redirect_callback') ||
          callback.contains('paytm-webCallback') ||
          callback.contains('instaMOJOWebSuccess')) {
        setState(() {
          recallAPI = false;
        });
        FocusScope.of(context).requestFocus(FocusNode());
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        if (callback.contains('success_payments') ||
            callback.contains('status=authorized') ||
            callback.contains('success') ||
            callback.contains('close') ||
            callback.contains('redirect_callback') ||
            callback.contains('paytm-webCallback') ||
            callback.contains('instaMOJOWebSuccess')) {
          Get.find<AwaitPaymentsController>().successPayments();
        }
      }
    }
  }
}
