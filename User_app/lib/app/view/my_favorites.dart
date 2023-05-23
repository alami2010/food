/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/controller/my_favorites_controller.dart';
import 'package:upgrade/app/env.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:get/get.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({Key? key}) : super(key: key);

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyFavoritesController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          title: Text(
            'My Favorites'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? value.getDummy()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: value.haveData == false
                    ? Column(
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
                          Text('No restaurants near your location'.tr,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'bold',
                              )),
                        ],
                      )
                    : Column(
                        children: List.generate(
                          value.restaurantList.length,
                          (restIndex) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                                color: ThemeProvider.whiteColor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(0, 1),
                                      blurRadius: 3),
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                value.onRestaurantDetail(value
                                    .restaurantList[restIndex].uid
                                    .toString());
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: FadeInImage(
                                          height: 120,
                                          width: double.infinity,
                                          image: NetworkImage(
                                              '${Environments.apiBaseURL}storage/images/${value.restaurantList[restIndex].cover}'),
                                          placeholder: const AssetImage(
                                              "assets/images/error.png"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                height: 120,
                                                width: double.infinity,
                                                'assets/images/error.png',
                                                fit: BoxFit.fitWidth);
                                          },
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          height: 25,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: const BoxDecoration(
                                            color: ThemeProvider.appColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              Get.find<MyFavoritesController>()
                                                          .currencySide ==
                                                      'left'
                                                  ? Get.find<MyFavoritesController>()
                                                          .currencySymbol +
                                                      value
                                                          .restaurantList[
                                                              restIndex]
                                                          .costForTwo
                                                          .toString() +
                                                      ' ' +
                                                      'for 2'.tr
                                                  : value
                                                          .restaurantList[
                                                              restIndex]
                                                          .costForTwo
                                                          .toString() +
                                                      Get.find<
                                                              MyFavoritesController>()
                                                          .currencySymbol +
                                                      ' ' +
                                                      'for 2',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.whiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -12,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: ThemeProvider.appColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Text(
                                                'Free Delivery'.tr,
                                                style: const TextStyle(
                                                    color: ThemeProvider
                                                        .whiteColor,
                                                    fontFamily: 'medium',
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      ThemeProvider.whiteColor,
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        offset:
                                                            const Offset(0, 1),
                                                        blurRadius: 3),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Text(
                                                value
                                                        .getMinDeliveryTime(
                                                            value
                                                                .restaurantList[
                                                                    restIndex]
                                                                .deliveryTime
                                                                .toString())
                                                        .toString() +
                                                    ' - ' +
                                                    value
                                                        .restaurantList[
                                                            restIndex]
                                                        .deliveryTime
                                                        .toString() +
                                                    'min'.tr,
                                                style: const TextStyle(
                                                    color:
                                                        ThemeProvider.appColor,
                                                    fontFamily: 'medium',
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 10,
                                        left: 10,
                                        right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 280,
                                          child: Text(
                                            value.restaurantList[restIndex].name
                                                .toString(),
                                            softWrap: false,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'bold',
                                                fontSize: 16),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 280,
                                          child: Text(
                                            value.restaurantList[restIndex]
                                                .cuisines
                                                .toString(),
                                            softWrap: false,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: ThemeProvider.greyColor),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              value.restaurantList[restIndex]
                                                  .ratings
                                                  .toString(),
                                              style: const TextStyle(
                                                color: ThemeProvider.appColor,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.star,
                                              color: ThemeProvider.appColor,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              value.restaurantList[restIndex]
                                                      .distance
                                                      .toString() +
                                                  ' ' +
                                                  value.distanceType,
                                              style: const TextStyle(
                                                color: ThemeProvider.greyColor,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
      );
    });
  }
}
