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
import 'package:skeletons/skeletons.dart';
import 'package:vender/app/controller/reviews_controller.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/util/theme.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewsController>(builder: (value) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: ThemeProvider.appColor,
              title: Text(
                'Reviews'.tr,
                style: const TextStyle(
                    fontFamily: 'bold',
                    fontSize: 18,
                    color: ThemeProvider.whiteColor),
              ),
              bottom: PreferredSize(
                preferredSize: value.apiCalled == true
                    ? const Size.fromHeight(50.0)
                    : const Size.fromHeight(0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: value.apiCalled == true
                      ? TabBar(
                          labelColor: ThemeProvider.appColor,
                          labelStyle: const TextStyle(fontFamily: 'semibold'),
                          unselectedLabelColor: Colors.black,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                          indicator: const UnderlineTabIndicator(
                            borderSide: BorderSide(
                                width: 2.0, color: ThemeProvider.appColor),
                          ),
                          tabs: [
                            Tab(
                              text: 'Your Reviews'.tr,
                            ),
                            Tab(
                              text: 'Products Reviews'.tr,
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
              )),
          body: value.apiCalled == false
              ? SkeletonListView()
              : TabBarView(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: value.stores.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                      "assets/images/no-data.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'No Reviews Found'.tr,
                                    style: const TextStyle(
                                      color: ThemeProvider.appColor,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Column(
                              children: List.generate(
                                  value.stores.length,
                                  (index) => Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: FadeInImage(
                                                height: 60,
                                                width: 60,
                                                image: NetworkImage(
                                                    '${Environments.apiBaseURL}storage/images/${value.stores[index].cover.toString()}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/error.png"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return Image.asset(
                                                      height: 60,
                                                      width: 60,
                                                      'assets/images/error.png',
                                                      fit: BoxFit.fitWidth);
                                                },
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${value.stores[index].firstName} ${value.stores[index].lastName}',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'medium'),
                                                    ),
                                                    Text(
                                                        value.stores[index].msg
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'medium')),
                                                    Text(
                                                      value.stores[index]
                                                          .createdAt
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: ThemeProvider
                                                              .greyColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                            ),
                    ),
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: value.products.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                      "assets/images/no-data.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'No Reviews Found'.tr,
                                    style: const TextStyle(
                                      color: ThemeProvider.appColor,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Column(
                              children: List.generate(
                                  value.products.length,
                                  (index) => Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: FadeInImage(
                                                height: 60,
                                                width: 60,
                                                image: NetworkImage(
                                                    '${Environments.apiBaseURL}storage/images/${value.products[index].productCover.toString()}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/error.png"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return Image.asset(
                                                      height: 60,
                                                      width: 60,
                                                      'assets/images/error.png',
                                                      fit: BoxFit.fitWidth);
                                                },
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      value.products[index]
                                                          .productName
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: ThemeProvider
                                                              .greyColor),
                                                    ),
                                                    Text(
                                                      '${value.products[index].firstName} ${value.products[index].lastName}',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'medium'),
                                                    ),
                                                    Text(
                                                        value
                                                            .products[index].msg
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'medium')),
                                                    Text(
                                                      value.products[index]
                                                          .createdAt
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: ThemeProvider
                                                              .greyColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                            ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
