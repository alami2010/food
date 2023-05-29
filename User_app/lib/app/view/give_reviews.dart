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
import 'package:foodies_user/app/controller/give_reviews_controller.dart';
import 'package:foodies_user/app/util/theme.dart';

class GiveReviewScreen extends StatefulWidget {
  const GiveReviewScreen({Key? key}) : super(key: key);

  @override
  State<GiveReviewScreen> createState() => _GiveReviewScreenState();
}

class _GiveReviewScreenState extends State<GiveReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiveReviewsController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            value.displayName,
            style: ThemeProvider.titleStyle,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close_outlined,
                color: ThemeProvider.whiteColor,
              ),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : AbsorbPointer(
                absorbing: value.isLogin.value == false ? false : true,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              value.updateRate(1);
                            },
                            child: Icon(Icons.star,
                                color: value.rate >= 1
                                    ? ThemeProvider.orangeColor
                                    : ThemeProvider.greyColor,
                                size: 30),
                          ),
                          InkWell(
                            onTap: () {
                              value.updateRate(2);
                            },
                            child: Icon(Icons.star,
                                color: value.rate >= 2
                                    ? ThemeProvider.orangeColor
                                    : ThemeProvider.greyColor,
                                size: 30),
                          ),
                          InkWell(
                            onTap: () {
                              value.updateRate(3);
                            },
                            child: Icon(Icons.star,
                                color: value.rate >= 3
                                    ? ThemeProvider.orangeColor
                                    : ThemeProvider.greyColor,
                                size: 30),
                          ),
                          InkWell(
                            onTap: () {
                              value.updateRate(4);
                            },
                            child: Icon(Icons.star,
                                color: value.rate >= 4
                                    ? ThemeProvider.orangeColor
                                    : ThemeProvider.greyColor,
                                size: 30),
                          ),
                          InkWell(
                            onTap: () {
                              value.updateRate(5);
                            },
                            child: Icon(Icons.star,
                                color: value.rate >= 5
                                    ? ThemeProvider.orangeColor
                                    : ThemeProvider.greyColor,
                                size: 30),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: value.comment,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            maxLines: 10,
                            decoration: InputDecoration(
                              labelText: 'Comments'.tr,
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          value.submitData();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 13.0),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                              color: ThemeProvider.appColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              value.isLogin.value == true
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Submit'.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: 'bold'),
                                    ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
              ),
      );
    });
  }
}
