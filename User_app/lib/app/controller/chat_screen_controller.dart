/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/models/conversion_model.dart';
import 'package:foodies_user/app/backend/parse/chat_screen_parse.dart';
import 'package:foodies_user/app/controller/message_controll.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController implements GetxService {
  final ChatScreenParse parser;
  String uid = '';
  bool apiCalled = false;
  List<ChatConversionModel> _chatList = <ChatConversionModel>[];
  List<ChatConversionModel> get chatList => _chatList;
  ChatScreenController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    uid = parser.getUID();
    getChatConversion();
  }

  Future<void> getChatConversion() async {
    Response response = await parser.getChatConversion(uid);
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      _chatList = [];
      body.forEach((data) {
        ChatConversionModel datas = ChatConversionModel.fromJson(data);
        _chatList.add(datas);
      });
      debugPrint(chatList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onChat(String uid, String name) {
    Get.delete<MessageController>(force: true);
    Get.toNamed(AppRouter.getMessage(), arguments: [uid, name]);
  }

  void onMessage() {
    Get.toNamed(AppRouter.getMessage());
  }
}
