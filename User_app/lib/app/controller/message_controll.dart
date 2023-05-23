/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/models/chat_list_model.dart';
import 'package:upgrade/app/backend/parse/message_parse.dart';
import 'package:get/get.dart';

import '../helper/message_data.dart';

class MessageController extends GetxController implements GetxService {
  final MessageParse parser;

  String receiverId = '';
  String uid = '';
  String name = '';
  bool apiCalled = false;
  bool yourMessage = false;
  int roomId = 0;
  final message = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<ChatListModel> _chatList = <ChatListModel>[];
  List<ChatListModel> get chatList => _chatList;
  MessageController({required this.parser});

  List<Item> messages = <Item>[
    Item('left', 'Hey there! What\'s up>?'.tr),
    Item('right',
        'Nothing. Just chilling and watching youtube What about you?'.tr),
    Item('left', 'Same here! Been watching youtube for last 5 hours'.tr),
    Item('right', 'Yeah i know. I am in same position'.tr),
    Item('left', 'It\'s hard to be productive man '.tr),
    Item('right', 'Sure thankyou'.tr),
  ];

  @override
  void onInit() {
    super.onInit();
    receiverId = Get.arguments[0].toString();
    name = Get.arguments[1].toString();
    uid = parser.getUID();
    debugPrint(name);
    getChatRooms();
  }

  Future<void> getChatRooms() async {
    Response response = await parser.getChatRooms(uid, receiverId);

    if (response.statusCode == 200) {
      apiCalled = true;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic data1 = myMap["data"];
      dynamic data2 = myMap["data2"];
      if (data1 != null &&
          data1 != '' &&
          data1['id'] != null &&
          data1['id'] != '') {
        roomId = data1['id'];
      } else if (data2 != null &&
          data2 != '' &&
          data2['id'] != null &&
          data2['id'] != '') {
        roomId = data2['id'];
      }
      getChatList();
    } else if (response.statusCode == 404) {
      createChatRooms();
    } else {
      apiCalled = true;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> createChatRooms() async {
    Response response = await parser.createChatRooms(uid, receiverId);
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body != null && body != '') {
        roomId = body['id'];
        getChatList();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getChatList() async {
    debugPrint('calling API');
    if (roomId != 0) {
      Response response = await parser.getChatList(roomId);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        _chatList = [];
        body.forEach((data) {
          ChatListModel datas = ChatListModel.fromJson(data);
          _chatList.add(datas);
        });
        update();
        scrollDown();
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  Future<void> sendMessage() async {
    String msg = message.text;
    message.clear();
    yourMessage = true;
    update();
    var param = {
      'room_id': roomId,
      'uid': uid,
      'sender_id': uid,
      'message': msg,
      'message_type': 0,
      'reported': 0,
      'status': 1,
    };
    Response response = await parser.sendMessage(param);
    yourMessage = false;
    update();
    if (response.statusCode == 200) {
      getChatList();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void scrollDown() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    update();
  }
}
