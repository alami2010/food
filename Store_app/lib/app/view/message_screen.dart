/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vender/app/controller/message_screen_controller.dart';
import 'package:vender/app/util/theme.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      Get.find<MessageScreenController>().getChatList();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageScreenController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            value.name,
            style: ThemeProvider.titleStyle,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeProvider.whiteColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(
                color: ThemeProvider.appColor,
              ))
            : SingleChildScrollView(
                controller: value.scrollController,
                reverse: true,
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(value.chatList.length, (index) {
                      return value.chatList[index].senderId.toString() !=
                              value.uid.toString()
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              width: MediaQuery.of(context).size.width - 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              )),
                                          child: Text(
                                            value.chatList[index].message
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: ThemeProvider
                                                              .appColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                          )),
                                                  child: Text(
                                                    value
                                                        .chatList[index].message
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                value.yourMessage == true &&
                                                        (value.chatList.length -
                                                                1) ==
                                                            index
                                                    ? Container(
                                                        height: 15,
                                                        width: 15,
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: 8,
                                                            left: 30,
                                                            right: 30),
                                                        child: const CircularProgressIndicator(
                                                            color: ThemeProvider
                                                                .appColor),
                                                      )
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                    })),
              ),
        bottomNavigationBar: SingleChildScrollView(
          reverse: true,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300))),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)),
                    child: TextField(
                      controller: value.message,
                      keyboardType: TextInputType.text,
                      maxLines: 2,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Message...'.tr),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    value.sendMessage();
                  },
                  child: const Icon(
                    Icons.send,
                    color: ThemeProvider.appColor,
                    size: 30,
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
