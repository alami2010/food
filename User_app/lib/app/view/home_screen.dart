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
import 'package:foodies_user/app/controller/home_controller.dart';
import 'package:foodies_user/app/env.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (value) {
        return Scaffold(
          body: value.apiCalled == false
              ? value.getDummy()
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                        backgroundColor: ThemeProvider.whiteColor,
                        floating: true,
                        pinned: true,
                        snap: false,
                        elevation: 0,
                        iconTheme:
                            const IconThemeData(color: ThemeProvider.appColor),
                        automaticallyImplyLeading: false,
                        title: Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: ThemeProvider.greyColor.shade300,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  value.onChooseLocation();
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: ThemeProvider.blackColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      // value.titleName,
                                      value.titleName.length > 30
                                          ? '${value.titleName.substring(0, 30)}...'
                                          : value.titleName,
                                      style: const TextStyle(
                                          color: ThemeProvider.blackColor,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottom: PreferredSize(
                          preferredSize: value.haveData == true
                              ? const Size.fromHeight(54)
                              : const Size.fromHeight(0),
                          child: value.haveData == true
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: ThemeProvider.whiteColor,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  offset: const Offset(0, 1),
                                                  blurRadius: 3),
                                            ],
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              value.onSearchScreen();
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(Icons.search),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text('Search restaurants'.tr),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        )),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: value.haveData == false
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          'No restaurants near your location'
                                              .tr,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'bold',
                                          )),
                                    ],
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
                                                CenterPageEnlargeStrategy
                                                    .height,
                                          ),
                                          items: value.banerList
                                              .map<Widget>((item) =>
                                                  GestureDetector(
                                                    onTap: () {
                                                      value.onBannerClick(
                                                          item.type as int,
                                                          item.value
                                                              .toString());
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 250,
                                                      decoration:
                                                          squareImage(item),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Container(
                                                          width: 300,
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 40),
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          150,
                                                                          0,
                                                                          0,
                                                                          0)),
                                                          child: Text(
                                                            item.title
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 17,
                                                                fontFamily:
                                                                    'medium'),
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Cuisines'.tr,
                                            style: const TextStyle(
                                                fontFamily: 'bold',
                                                fontSize: 18),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              value.onCuisines();
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  'View All'.tr,
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .greyColor),
                                                ),
                                                const Icon(
                                                  Icons.chevron_right,
                                                  color:
                                                      ThemeProvider.greyColor,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                              value.categoryList.length,
                                              (cateIndex) => Container(
                                                    width: 100,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 15),
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
                                                                .circular(10)),
                                                    child: InkWell(
                                                      onTap: () {
                                                        value.onGetByCategories(
                                                            value
                                                                .categoryList[
                                                                    cateIndex]
                                                                .id
                                                                .toString(),
                                                            value
                                                                .categoryList[
                                                                    cateIndex]
                                                                .name
                                                                .toString());
                                                      },
                                                      child: Column(
                                                        children: [
                                                          FadeInImage(
                                                            width: 50,
                                                            height: 50,
                                                            image: NetworkImage(
                                                                '${Environments.apiBaseURL}storage/images/${value.categoryList[cateIndex].cover}'),
                                                            placeholder:
                                                                const AssetImage(
                                                                    "assets/images/error.png"),
                                                            imageErrorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image.asset(
                                                                  'assets/images/error.png',
                                                                  fit: BoxFit
                                                                      .fitWidth);
                                                            },
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            value
                                                                .categoryList[
                                                                    cateIndex]
                                                                .name
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: ThemeProvider
                                                                    .greyColor,
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${value.restaurantList.length} ${'Restaurant near you'.tr}',
                                            style: const TextStyle(
                                                fontFamily: 'bold',
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: List.generate(
                                          value.restaurantList.length,
                                          (restIndex) => Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: ThemeProvider.whiteColor,
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      offset:
                                                          const Offset(0, 1),
                                                      blurRadius: 3),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: InkWell(
                                              onTap: () {
                                                value.onRestaurantDetail(value
                                                    .restaurantList[restIndex]
                                                    .uid
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
                                                            const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        child: FadeInImage(
                                                          height: 120,
                                                          width:
                                                              double.infinity,
                                                          image: NetworkImage(
                                                              '${Environments.apiBaseURL}storage/images/${value.restaurantList[restIndex].cover}'),
                                                          placeholder:
                                                              const AssetImage(
                                                                  "assets/images/error.png"),
                                                          imageErrorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                                height: 120,
                                                                width: double
                                                                    .infinity,
                                                                'assets/images/error.png',
                                                                fit: BoxFit
                                                                    .fitWidth);
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
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: ThemeProvider
                                                                .appColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              Get.find<HomeController>()
                                                                          .currencySide ==
                                                                      'left'
                                                                  ? '${Get.find<HomeController>().currencySymbol}${value.restaurantList[restIndex].costForTwo} ${'for 2'.tr}'
                                                                  : '${value.restaurantList[restIndex].costForTwo}${Get.find<HomeController>().currencySymbol} for 2',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                              decoration: BoxDecoration(
                                                                  color: ThemeProvider
                                                                      .appColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30)),
                                                              child: Text(
                                                                'Free Delivery'
                                                                    .tr,
                                                                style: const TextStyle(
                                                                    color: ThemeProvider
                                                                        .whiteColor,
                                                                    fontFamily:
                                                                        'medium',
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: ThemeProvider
                                                                          .whiteColor,
                                                                      boxShadow: <
                                                                          BoxShadow>[
                                                                        BoxShadow(
                                                                            color: Colors.black.withOpacity(
                                                                                0.2),
                                                                            offset: const Offset(0,
                                                                                1),
                                                                            blurRadius:
                                                                                3),
                                                                      ],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30)),
                                                              child: Text(
                                                                '${value.getMinDeliveryTime(value.restaurantList[restIndex].deliveryTime.toString())} - ${value.restaurantList[restIndex].deliveryTime}${'min'.tr}',
                                                                style: const TextStyle(
                                                                    color: ThemeProvider
                                                                        .appColor,
                                                                    fontFamily:
                                                                        'medium',
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20,
                                                            bottom: 10,
                                                            left: 10,
                                                            right: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 280,
                                                          child: Text(
                                                            value
                                                                .restaurantList[
                                                                    restIndex]
                                                                .name
                                                                .toString(),
                                                            softWrap: false,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                                    fontFamily:
                                                                        'bold',
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          width: 280,
                                                          child: Text(
                                                            value
                                                                .restaurantList[
                                                                    restIndex]
                                                                .cuisines
                                                                .toString(),
                                                            softWrap: false,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                                              value
                                                                  .restaurantList[
                                                                      restIndex]
                                                                  .ratings
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    ThemeProvider
                                                                        .appColor,
                                                              ),
                                                            ),
                                                            const Icon(
                                                              Icons.star,
                                                              color:
                                                                  ThemeProvider
                                                                      .appColor,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              '${value.restaurantList[restIndex].distance} ${value.distanceType}',
                                                              style:
                                                                  const TextStyle(
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
                                      ),
                                    ],
                                  ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  squareImage(val) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
          image: NetworkImage(
              '${Environments.apiBaseURL}storage/images/${val.cover}'),
          fit: BoxFit.cover,
          alignment: Alignment.center),
    );
  }
}
