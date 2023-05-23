/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/parse/app_pages_screen.dart';

import 'package:get/get.dart';

class AppPagesController extends GetxController implements GetxService {
  final AppPagesParse parser;
  String pageName = '';
  String pageId = '';
  String content = '';
  bool apiCalled = false;
  AppPagesController({required this.parser});

  @override
  void onInit() async {
    super.onInit();
    pageName = Get.arguments[1];
    pageId = Get.arguments[0];
    update();
    getContent();
  }

  Future<void> getContent() async {
    Response response = await parser.getContentById(pageId);
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body['content'] != '' && body['content'] != null) {
        content = body['content'];
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }
}
