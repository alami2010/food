/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:foodies_user/app/controller/restaurant_detail_controller.dart';
import 'package:foodies_user/app/controller/search_controller.dart';
import 'package:foodies_user/app/env.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchxController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            title: Row(
              children: [
                Flexible(
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      controller: value.searchController,
                      onChanged: value.searchProducts,
                      style: const TextStyle(color: ThemeProvider.blackColor),
                      decoration: InputDecoration(
                        hintText: 'Restaurant Name'.tr,
                        prefixIcon: const Icon(Icons.search),
                        hintStyle:
                            const TextStyle(color: ThemeProvider.greyColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: ThemeProvider.whiteColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: ThemeProvider.whiteColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: ThemeProvider.whiteColor,
                          ),
                        ),
                        filled: true,
                        fillColor: ThemeProvider.whiteColor,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                      ),
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close))
            ],
            automaticallyImplyLeading: false,
          ),
          body: value.isEmpty.isFalse && value.result.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(children: [
                    for (var i in value.result)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Get.delete<RestaurantDetailController>(force: true);
                            Get.toNamed(AppRouter.getRestaurantDetail(),
                                arguments: [i.uid.toString()]);
                          },
                          child: ListTile(
                            leading: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 44,
                                  minHeight: 44,
                                  maxWidth: 64,
                                  maxHeight: 64,
                                ),
                                child: FadeInImage(
                                  image: NetworkImage(
                                      '${Environments.apiBaseURL}storage/images/${i.cover}'),
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
                            title: Text(
                              i.name.toString(),
                              style: const TextStyle(fontSize: 10.0),
                            ),
                          ),
                        ),
                      )
                  ]),
                )
              : Container(),
        );
      },
    );
  }
}
