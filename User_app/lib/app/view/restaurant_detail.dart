/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/controller/my_cart_controller.dart';
import 'package:upgrade/app/controller/restaurant_detail_controller.dart';
import 'package:upgrade/app/env.dart';
import 'package:upgrade/app/helper/curve_image.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:upgrade/app/view/customiz.dart';
import 'package:get/get.dart';

class RestaurantDetail extends StatefulWidget {
  const RestaurantDetail({Key? key}) : super(key: key);

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantDetailController>(
      builder: (value) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: value.haveData == true
              ? SizedBox(
                  height: 30,
                  width: 130,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alertDialogBox(value);
                          });
                    },
                    label: Text(
                      'Browse Menu'.tr,
                      style: const TextStyle(fontSize: 10),
                    ),
                    icon: const Icon(
                      Icons.fastfood,
                      size: 15,
                    ),
                    backgroundColor: ThemeProvider.appColor,
                  ),
                )
              : const SizedBox(),
          body: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        backgroundColor: ThemeProvider.whiteColor,
                        floating: true,
                        pinned: true,
                        snap: false,
                        expandedHeight: 550.0,
                        forceElevated: innerBoxIsScrolled,
                        actions: [
                          IconButton(
                            onPressed: () {
                              value.addToFav();
                            },
                            icon: Icon(
                              value.isFav == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: ThemeProvider.whiteColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              value.onMyCart();
                            },
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              color: ThemeProvider.whiteColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              value.share();
                            },
                            icon: const Icon(
                              Icons.share_outlined,
                              color: ThemeProvider.whiteColor,
                            ),
                          ),
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.bottomCenter,
                                children: [
                                  ClipPath(
                                    clipper: CurveImage(),
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/f8.jpg'),
                                            fit: BoxFit.fitWidth),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -50,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: ThemeProvider.appColor,
                                              width: 2)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: FadeInImage(
                                          width: 120,
                                          height: 120,
                                          image: NetworkImage(
                                              '${Environments.apiBaseURL}storage/images/${value.storeData.cover}'),
                                          placeholder: const AssetImage(
                                              "assets/images/error_white.png"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                width: 120,
                                                height: 120,
                                                'assets/images/error_white.png',
                                                fit: BoxFit.fitWidth);
                                          },
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 50),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      value.storeData.name.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'bold', fontSize: 18),
                                    ),
                                    Text(
                                      value.storeData.cuisines.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'regular',
                                          color: ThemeProvider.greyColor),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: ThemeProvider.greyColor,
                                          ),
                                          Expanded(
                                            child: Text(
                                              value.storeData.address
                                                          .toString()
                                                          .length >
                                                      30
                                                  ? value.storeData.address
                                                          .toString()
                                                          .substring(0, 30) +
                                                      '...'
                                                  : value.storeData.address
                                                      .toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        value.onTableBooking();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: ThemeProvider.appColor,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Text(
                                          'Book Table'.tr,
                                          style: const TextStyle(
                                              color: ThemeProvider.whiteColor),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color:
                                                        ThemeProvider.appColor,
                                                  ),
                                                  Text(
                                                    value.storeData.ratings
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontFamily: 'bold',
                                                        fontSize: 18),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                value.storeData.totalRatings
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: ThemeProvider
                                                        .greyColor),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                    color: ThemeProvider
                                                        .greyColor.shade300),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  value
                                                          .getMinDeliveryTime(
                                                              value.storeData
                                                                  .deliveryTime
                                                                  .toString())
                                                          .toString() +
                                                      ' - ' +
                                                      value.storeData
                                                          .deliveryTime
                                                          .toString() +
                                                      'min',
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  'Delivery Time'.tr,
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .greyColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                    color: ThemeProvider
                                                        .greyColor.shade300),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  Get.find<RestaurantDetailController>()
                                                              .currencySide ==
                                                          'left'
                                                      ? Get.find<RestaurantDetailController>()
                                                              .currencySymbol +
                                                          value.storeData
                                                              .costForTwo
                                                              .toString()
                                                      : value.storeData
                                                              .costForTwo
                                                              .toString() +
                                                          Get.find<
                                                                  RestaurantDetailController>()
                                                              .currencySymbol,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  'Order For 2'.tr,
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .greyColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Switch(
                                              value: value.isSwitched,
                                              onChanged: (data) {
                                                value.onSwitch(data);
                                              },
                                              activeColor:
                                                  ThemeProvider.greenColor,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text('Veg'.tr)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Switch(
                                              value: value.isNon,
                                              onChanged: (data) {
                                                value.onNon(data);
                                              },
                                              activeColor:
                                                  ThemeProvider.appColor,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text('Non-veg'.tr)
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(40.0),
                          child: Container(
                            padding: const EdgeInsets.only(top: 5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(color: ThemeProvider.greyColor),
                                bottom:
                                    BorderSide(color: ThemeProvider.greyColor),
                              ),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: value.productList.map((e) {
                                  return Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: InkWell(
                                      onTap: () {
                                        value.changeCat(e.cateId.toString());
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 10,
                                            left: 10,
                                            right: 10,
                                            top: 5),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 2,
                                                color: value.tabID == e.cateId
                                                    ? ThemeProvider.appColor
                                                    : ThemeProvider
                                                        .transParent),
                                          ),
                                        ),
                                        child: Text(
                                          e.name.toString(),
                                          style: TextStyle(
                                              fontFamily: 'semibold',
                                              color: value.tabID == e.cateId
                                                  ? ThemeProvider.appColor
                                                  : ThemeProvider.greyColor),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: value.sController,
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
                              Text('No items found!'.tr,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'bold',
                                  )),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  value.productList.length,
                                  (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    key: value.cateListKey[index],
                                    children: [
                                      Text(
                                        value.productList[index].name
                                            .toString(),
                                        style: const TextStyle(
                                            fontFamily: 'Bold', fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: List.generate(
                                          value.productList[index].products!
                                              .length,
                                          (subIndex) => Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
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
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // value.onFoodDetail();
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: FadeInImage(
                                                      width: 70,
                                                      height: 70,
                                                      image: NetworkImage(
                                                          '${Environments.apiBaseURL}storage/images/${value.productList[index].products![subIndex].cover}'),
                                                      placeholder: const AssetImage(
                                                          "assets/images/error.png"),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Image.asset(
                                                            width: 70,
                                                            height: 70,
                                                            'assets/images/error.png',
                                                            fit: BoxFit
                                                                .fitWidth);
                                                      },
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: ThemeProvider
                                                                    .appColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              size: 15,
                                                              color: value
                                                                          .productList[
                                                                              index]
                                                                          .products![
                                                                              subIndex]
                                                                          .rating! >=
                                                                      1
                                                                  ? ThemeProvider
                                                                      .appColor
                                                                  : ThemeProvider
                                                                      .greyColor,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              size: 15,
                                                              color: value
                                                                          .productList[
                                                                              index]
                                                                          .products![
                                                                              subIndex]
                                                                          .rating! >=
                                                                      2
                                                                  ? ThemeProvider
                                                                      .appColor
                                                                  : ThemeProvider
                                                                      .greyColor,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              size: 15,
                                                              color: value
                                                                          .productList[
                                                                              index]
                                                                          .products![
                                                                              subIndex]
                                                                          .rating! >=
                                                                      3
                                                                  ? ThemeProvider
                                                                      .appColor
                                                                  : ThemeProvider
                                                                      .greyColor,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              size: 15,
                                                              color: value
                                                                          .productList[
                                                                              index]
                                                                          .products![
                                                                              subIndex]
                                                                          .rating! >=
                                                                      4
                                                                  ? ThemeProvider
                                                                      .appColor
                                                                  : ThemeProvider
                                                                      .greyColor,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              size: 15,
                                                              color: value
                                                                          .productList[
                                                                              index]
                                                                          .products![
                                                                              subIndex]
                                                                          .rating! >=
                                                                      5
                                                                  ? ThemeProvider
                                                                      .appColor
                                                                  : ThemeProvider
                                                                      .greyColor,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              value
                                                                  .productList[
                                                                      index]
                                                                  .products![
                                                                      subIndex]
                                                                  .rating
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 180,
                                                            child: Text(
                                                              value
                                                                  .productList[
                                                                      index]
                                                                  .products![
                                                                      subIndex]
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
                                                                          14),
                                                            ),
                                                          ),
                                                          value
                                                                      .productList[
                                                                          index]
                                                                      .products![
                                                                          subIndex]
                                                                      .veg ==
                                                                  2
                                                              ? Image.asset(
                                                                  'assets/images/non.png',
                                                                  height: 15,
                                                                  width: 15,
                                                                )
                                                              : Image.asset(
                                                                  'assets/images/veg.png',
                                                                  height: 15,
                                                                  width: 15,
                                                                ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Price : '.tr,
                                                            style: const TextStyle(
                                                                color: ThemeProvider
                                                                    .greyColor),
                                                          ),
                                                          value
                                                                      .productList[
                                                                          index]
                                                                      .products![
                                                                          subIndex]
                                                                      .discount! >=
                                                                  1
                                                              ? Text(
                                                                  Get.find<RestaurantDetailController>().currencySide ==
                                                                          'left'
                                                                      ? Get.find<RestaurantDetailController>()
                                                                              .currencySymbol +
                                                                          value
                                                                              .productList[
                                                                                  index]
                                                                              .products![
                                                                                  subIndex]
                                                                              .price
                                                                              .toString()
                                                                      : value
                                                                              .productList[index]
                                                                              .products![subIndex]
                                                                              .price
                                                                              .toString() +
                                                                          Get.find<RestaurantDetailController>().currencySymbol,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'medium',
                                                                      fontSize:
                                                                          16,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough),
                                                                )
                                                              : Text(
                                                                  Get.find<RestaurantDetailController>().currencySide ==
                                                                          'left'
                                                                      ? Get.find<RestaurantDetailController>()
                                                                              .currencySymbol +
                                                                          value
                                                                              .productList[
                                                                                  index]
                                                                              .products![
                                                                                  subIndex]
                                                                              .price
                                                                              .toString()
                                                                      : value
                                                                              .productList[index]
                                                                              .products![subIndex]
                                                                              .price
                                                                              .toString() +
                                                                          Get.find<RestaurantDetailController>().currencySymbol,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'bold',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          value
                                                                      .productList[
                                                                          index]
                                                                      .products![
                                                                          subIndex]
                                                                      .discount! >=
                                                                  1
                                                              ? Text(
                                                                  Get.find<RestaurantDetailController>().currencySide ==
                                                                          'left'
                                                                      ? Get.find<RestaurantDetailController>()
                                                                              .currencySymbol +
                                                                          value
                                                                              .productList[
                                                                                  index]
                                                                              .products![
                                                                                  subIndex]
                                                                              .discount
                                                                              .toString()
                                                                      : value
                                                                              .productList[index]
                                                                              .products![subIndex]
                                                                              .discount
                                                                              .toString() +
                                                                          Get.find<RestaurantDetailController>().currencySymbol,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'bold',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                )
                                                              : const SizedBox()
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                value
                                                            .productList[index]
                                                            .products![subIndex]
                                                            .size ==
                                                        1
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 2),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 2,
                                                                  vertical: 2),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  border: Border.all(
                                                                      color: ThemeProvider
                                                                          .appColor)),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  showModalBottomSheet(
                                                                    context:
                                                                        context,
                                                                    isScrollControlled:
                                                                        true,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return FractionallySizedBox(
                                                                        heightFactor:
                                                                            0.7,
                                                                        child:
                                                                            CustomizScreen(
                                                                          id: value
                                                                              .productList[index]
                                                                              .products![subIndex]
                                                                              .id
                                                                              .toString(),
                                                                          name: value
                                                                              .productList[index]
                                                                              .products![subIndex]
                                                                              .name
                                                                              .toString(),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: Row(
                                                                  children:
                                                                      value.productList[index].products![subIndex].quantity >
                                                                              0
                                                                          ? [
                                                                              const Icon(
                                                                                Icons.remove_circle_outline,
                                                                                size: 20,
                                                                                color: ThemeProvider.greyColor,
                                                                              ),
                                                                              const SizedBox(width: 5),
                                                                              Text(
                                                                                value.getSumOfItems(value.productList[index].products![subIndex].id as int).toString(),
                                                                                style: const TextStyle(fontFamily: 'bold', fontSize: 16),
                                                                              ),
                                                                              const SizedBox(width: 5),
                                                                              const Icon(
                                                                                Icons.add_circle_outline,
                                                                                size: 20,
                                                                                color: ThemeProvider.greyColor,
                                                                              ),
                                                                            ]
                                                                          : [
                                                                              Text(
                                                                                'Add'.tr,
                                                                                style: const TextStyle(color: ThemeProvider.appColor, fontSize: 12),
                                                                              ),
                                                                              const Icon(
                                                                                Icons.add,
                                                                                color: ThemeProvider.appColor,
                                                                                size: 15,
                                                                              )
                                                                            ],
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              'Customisable'.tr,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          10),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 2),
                                                        child: value
                                                                    .productList[
                                                                        index]
                                                                    .products![
                                                                        subIndex]
                                                                    .quantity >
                                                                0
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            2,
                                                                        vertical:
                                                                            2),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        border: Border.all(
                                                                            color:
                                                                                ThemeProvider.appColor)),
                                                                    child: Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            value.updateProductQuantityRemove(index,
                                                                                subIndex);
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.remove_circle_outline,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                ThemeProvider.greyColor,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                5),
                                                                        Text(
                                                                          value
                                                                              .productList[index]
                                                                              .products![subIndex]
                                                                              .quantity
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'bold',
                                                                              fontSize: 16),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                5),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            value.updateProductQuantity(index,
                                                                                subIndex);
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.add_circle_outline,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                ThemeProvider.greyColor,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  )
                                                                ],
                                                              )
                                                            : Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      value.addToCart(
                                                                          index,
                                                                          subIndex);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              2,
                                                                          vertical:
                                                                              2),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              5),
                                                                          border:
                                                                              Border.all(color: ThemeProvider.appColor)),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            'Add'.tr,
                                                                            style:
                                                                                const TextStyle(color: ThemeProvider.appColor, fontSize: 12),
                                                                          ),
                                                                          const Icon(
                                                                            Icons.add,
                                                                            color:
                                                                                ThemeProvider.appColor,
                                                                            size:
                                                                                15,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
          bottomNavigationBar: Get.find<MyCartController>()
                  .savedInCart
                  .isNotEmpty
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  decoration:
                      const BoxDecoration(color: ThemeProvider.appColor),
                  child: InkWell(
                    onTap: () {
                      value.onMyCart();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                                Get.find<MyCartController>()
                                        .totalItemsInCart
                                        .toString() +
                                    ' ' +
                                    'Items '.tr,
                                style: const TextStyle(
                                    color: ThemeProvider.whiteColor,
                                    fontSize: 16)),
                            Text(
                                Get.find<RestaurantDetailController>()
                                            .currencySide ==
                                        'left'
                                    ? Get.find<RestaurantDetailController>()
                                            .currencySymbol +
                                        Get.find<MyCartController>()
                                            .totalPrice
                                            .toString()
                                    : Get.find<MyCartController>()
                                            .totalPrice
                                            .toString()
                                            .toString() +
                                        Get.find<RestaurantDetailController>()
                                            .currencySymbol,
                                style: const TextStyle(
                                    color: ThemeProvider.whiteColor,
                                    fontSize: 16))
                          ],
                        ),
                        Text(
                          'Cart'.tr,
                          style: const TextStyle(
                              color: ThemeProvider.whiteColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }

  Widget alertDialogBox(value) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      content: SizedBox(
        height: 300,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              Get.find<RestaurantDetailController>().productList.length,
              (index) => InkWell(
                onTap: () {
                  Get.find<RestaurantDetailController>().changeCat(
                      Get.find<RestaurantDetailController>()
                          .productList[index]
                          .cateId
                          .toString());
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Get.find<RestaurantDetailController>()
                            .productList[index]
                            .name
                            .toString(),
                        style: const TextStyle(
                            color: ThemeProvider.blackColor, fontSize: 15),
                      ),
                      Text(
                        Get.find<RestaurantDetailController>()
                            .productList[index]
                            .products!
                            .length
                            .toString(),
                        style: const TextStyle(
                            color: ThemeProvider.blackColor, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
