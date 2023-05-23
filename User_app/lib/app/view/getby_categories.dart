/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:upgrade/app/controller/getby_categories_controller.dart';
import 'package:upgrade/app/env.dart';
import 'package:upgrade/app/util/theme.dart';

class GetBycategories extends StatefulWidget {
  const GetBycategories({Key? key}) : super(key: key);

  @override
  State<GetBycategories> createState() => _GetBycategoriesState();
}

class _GetBycategoriesState extends State<GetBycategories> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetByCategoriesController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            title: Text(
              value.cusineName.toString(),
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                              height: 50,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        const SizedBox(height: 20),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                              height: 150,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 16,
                                  width: 64,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 16,
                                  width: 64,
                                  borderRadius: BorderRadius.circular(8)),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(10, (index) {
                            return SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                              width: 70,
                              height: 70,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              borderRadius: BorderRadius.circular(8),
                            ));
                          })),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 16,
                                  width: 64,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 16,
                                  width: 64,
                                  borderRadius: BorderRadius.circular(8)),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(10, (index) {
                            return SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                              width: 280,
                              height: 120,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              borderRadius: BorderRadius.circular(8),
                            ));
                          })),
                        ),
                        const SizedBox(height: 10),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                              height: 120,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: value.haveData == false
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
                              Text('No restaurants near your location'.tr,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'bold',
                                  )),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: false,
                                  viewportFraction: 1.0,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                ),
                                items: value.banerList
                                    .map<Widget>((item) => GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: double.infinity,
                                            height: 250,
                                            decoration: squareImage(item),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                width: 300,
                                                margin: const EdgeInsets.only(
                                                    bottom: 40),
                                                decoration: const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        150, 0, 0, 0)),
                                                child: Text(
                                                  item.title.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontFamily: 'medium'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: List.generate(
                                value.restaurantList.length,
                                (index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: ThemeProvider.whiteColor,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            offset: const Offset(0, 1),
                                            blurRadius: 3),
                                      ],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      value.onRestaurantDetail(value
                                          .restaurantList[index].uid
                                          .toString());
                                    },
                                    child: Column(
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          alignment: Alignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10)),
                                              child: FadeInImage(
                                                height: 120,
                                                width: double.infinity,
                                                image: NetworkImage(
                                                    '${Environments.apiBaseURL}storage/images/${value.restaurantList[index].cover}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/error.png"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: const BoxDecoration(
                                                  color: ThemeProvider.appColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    Get.find<GetByCategoriesController>()
                                                                .currencySide ==
                                                            'left'
                                                        ? Get.find<GetByCategoriesController>()
                                                                .currencySymbol +
                                                            value
                                                                .restaurantList[
                                                                    index]
                                                                .costForTwo
                                                                .toString() +
                                                            ' ' +
                                                            'for 2'.tr
                                                        : value
                                                                .restaurantList[
                                                                    index]
                                                                .costForTwo
                                                                .toString() +
                                                            Get.find<
                                                                    GetByCategoriesController>()
                                                                .currencySymbol +
                                                            ' ' +
                                                            'for 2'.tr,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: ThemeProvider
                                                            .whiteColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: -12,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                        color: ThemeProvider
                                                            .appColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
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
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                        color: ThemeProvider
                                                            .whiteColor,
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2),
                                                              offset:
                                                                  const Offset(
                                                                      0, 1),
                                                              blurRadius: 3),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Text(
                                                      value
                                                              .getMinDeliveryTime(value
                                                                  .restaurantList[
                                                                      index]
                                                                  .deliveryTime
                                                                  .toString())
                                                              .toString() +
                                                          ' - ' +
                                                          value
                                                              .restaurantList[
                                                                  index]
                                                              .deliveryTime
                                                              .toString() +
                                                          'min'.tr,
                                                      style: const TextStyle(
                                                          color: ThemeProvider
                                                              .appColor,
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
                                                  value.restaurantList[index]
                                                      .name
                                                      .toString(),
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  value.restaurantList[index]
                                                      .cuisines
                                                      .toString(),
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .greyColor),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    value.restaurantList[index]
                                                        .ratings
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: ThemeProvider
                                                          .appColor,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.star,
                                                    color:
                                                        ThemeProvider.appColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    value.restaurantList[index]
                                                            .distance
                                                            .toString() +
                                                        ' ' +
                                                        value.distanceType,
                                                    style: const TextStyle(
                                                      color: ThemeProvider
                                                          .greyColor,
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
                            )
                          ],
                        ),
                ),
        );
      },
    );
  }

  squareImage(val) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
          image: NetworkImage(Environments.apiBaseURL +
              'storage/images/' +
              val.cover.toString()),
          fit: BoxFit.cover,
          alignment: Alignment.center),
    );
  }

  // Widget fullContainer(
  //     id, image, cost, time, name, cuisines, distance, ratings, value) {
  //   return ;
  // }
}
