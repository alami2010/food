/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:foodies_user/app/controller/chat_screen_controller.dart';
import 'package:foodies_user/app/env.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatScreenController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Chats'.tr,
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
            ? SkeletonListView(
                itemCount: 5,
              )
            : value.chatList.isEmpty
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset(
                            "assets/images/no-data.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: List.generate(value.chatList.length, (index) {
                        return value.chatList[index].senderId.toString() ==
                                value.uid
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade300))),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: InkWell(
                                  onTap: () {
                                    value.onChat(
                                        value.chatList[index].receiverId
                                            .toString(),
                                        '${value.chatList[index].receiverName} ${value.chatList[index].receiverLastName}');
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: FittedBox(
                                            child: FadeInImage(
                                          image: NetworkImage(
                                              '${Environments.apiBaseURL}storage/images/${value.chatList[index].receiverCover}'),
                                          placeholder: const AssetImage(
                                              "assets/images/error.png"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/images/error.png',
                                                fit: BoxFit.fitWidth);
                                          },
                                          fit: BoxFit.fitWidth,
                                        )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${value.chatList[index].receiverName} ${value.chatList[index].receiverLastName}',
                                                    style: const TextStyle(
                                                        fontFamily: 'medium'),
                                                  ),
                                                  const Icon(
                                                      Icons.chevron_right)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade300))),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: InkWell(
                                  onTap: () {
                                    value.onChat(
                                        value.chatList[index].senderId
                                            .toString(),
                                        '${value.chatList[index].senderFirstName} ${value.chatList[index].senderLastName}');
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: FittedBox(
                                            child: FadeInImage(
                                          image: NetworkImage(
                                              '${Environments.apiBaseURL}storage/images/${value.chatList[index].senderCover}'),
                                          placeholder: const AssetImage(
                                              "assets/images/error.png"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/images/error.png',
                                                fit: BoxFit.fitWidth);
                                          },
                                          fit: BoxFit.fitWidth,
                                        )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${value.chatList[index].senderFirstName} ${value.chatList[index].senderLastName}',
                                                    style: const TextStyle(
                                                        fontFamily: 'medium'),
                                                  ),
                                                  const Icon(
                                                      Icons.chevron_right)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      }),
                      // children: [

                      // ],
                    ),
                  )),
      );
    });
  }
}
