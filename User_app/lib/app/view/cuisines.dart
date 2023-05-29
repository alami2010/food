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
import 'package:foodies_user/app/controller/cuisines_controller.dart';
import 'package:foodies_user/app/env.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:get/get.dart';

class CusinesScreen extends StatefulWidget {
  const CusinesScreen({Key? key}) : super(key: key);

  @override
  State<CusinesScreen> createState() => _CusinesScreenState();
}

class _CusinesScreenState extends State<CusinesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CuisinesController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            title: Text(
              'Cuisines'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                value.apiCalled == false
                    ? GridView.count(
                        crossAxisCount: 3,
                        primary: false,
                        shrinkWrap: true,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 85 / 100,
                        children: List.generate(
                            10,
                            (index) => const SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      height: 96, width: 72),
                                )),
                      )
                    : GridView.count(
                        crossAxisCount: 3,
                        primary: false,
                        shrinkWrap: true,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 85 / 100,
                        children: List.generate(
                          value.categoryList.length,
                          (index) => GestureDetector(
                            onTap: () {
                              value.onGetByCategories(
                                  value.categoryList[index].id.toString(),
                                  value.categoryList[index].name.toString());
                            },
                            child: Container(
                              width: 100,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                  color: ThemeProvider.whiteColor,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: const Offset(0, 1),
                                        blurRadius: 3),
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FadeInImage(
                                    width: 50,
                                    height: 50,
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.categoryList[index].cover}'),
                                    placeholder: const AssetImage(
                                        "assets/images/error.png"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/error.png',
                                          fit: BoxFit.fitWidth);
                                    },
                                    fit: BoxFit.fitWidth,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    value.categoryList[index].name.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
