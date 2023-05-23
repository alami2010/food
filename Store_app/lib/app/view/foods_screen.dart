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
import 'package:vender/app/controller/foods_screen_controller.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/util/theme.dart';

class FoodsScreen extends StatefulWidget {
  const FoodsScreen({Key? key}) : super(key: key);

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodsScreenController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            title: Text(
              'Foods'.tr,
              style: const TextStyle(
                  fontFamily: 'bold',
                  fontSize: 18,
                  color: ThemeProvider.whiteColor),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  value.onAddFood();
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: ThemeProvider.greyColor.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: ThemeProvider.greyColor,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Search foods'.tr),
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: value.categories.map((e) {
                      return Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            value.changeCat(e.id.toString(), e.from.toString());
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 2,
                                    color: value.cateId.toString() ==
                                            e.id.toString()
                                        ? ThemeProvider.appColor
                                        : ThemeProvider.transParent),
                              ),
                            ),
                            child: Text(
                              e.name.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'semibold',
                                  color:
                                      value.cateId.toString() == e.id.toString()
                                          ? ThemeProvider.appColor
                                          : ThemeProvider.greyColor),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                for (var item in value.foodList)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: ThemeProvider.whiteColor,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 1),
                              blurRadius: 3),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 90,
                          width: 90,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              image: NetworkImage(
                                  '${Environments.apiBaseURL}storage/images/${item.cover}'),
                              placeholder:
                                  const AssetImage("assets/images/error.png"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/error.png',
                                    height: 90, width: 90, fit: BoxFit.cover);
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.name.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'semi-bold',
                                          fontSize: 12),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            value.editFood(item.id.toString());
                                          },
                                          child:
                                              const Icon(Icons.edit_outlined),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child:
                                              const Icon(Icons.delete_outline),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  item.veg == 1 ? 'Veg'.tr : 'Non Veg'.tr,
                                  style: TextStyle(
                                      color: item.veg == 1
                                          ? ThemeProvider.greenColor
                                          : ThemeProvider.appColor,
                                      fontSize: 12),
                                ),
                                Row(
                                  children: [
                                    item.discount! >= 1
                                        ? Text(
                                            Get.find<FoodsScreenController>()
                                                        .currencySide ==
                                                    'left'
                                                ? Get.find<FoodsScreenController>()
                                                        .currencySymbol +
                                                    item.price.toString()
                                                : item.price.toString() +
                                                    Get.find<
                                                            FoodsScreenController>()
                                                        .currencySymbol,
                                            style: const TextStyle(
                                                fontFamily: 'medium',
                                                fontSize: 12,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          )
                                        : Text(
                                            Get.find<FoodsScreenController>()
                                                        .currencySide ==
                                                    'left'
                                                ? Get.find<FoodsScreenController>()
                                                        .currencySymbol +
                                                    item.price.toString()
                                                : item.price.toString() +
                                                    Get.find<
                                                            FoodsScreenController>()
                                                        .currencySymbol,
                                            style: const TextStyle(
                                              fontFamily: 'bold',
                                              fontSize: 12,
                                            ),
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    item.discount! >= 1
                                        ? Text(
                                            Get.find<FoodsScreenController>()
                                                        .currencySide ==
                                                    'left'
                                                ? Get.find<FoodsScreenController>()
                                                        .currencySymbol +
                                                    item.discount.toString()
                                                : item.discount.toString() +
                                                    Get.find<
                                                            FoodsScreenController>()
                                                        .currencySymbol,
                                            style: const TextStyle(
                                              fontFamily: 'bold',
                                              fontSize: 12,
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),

                                // const SizedBox(
                                //   height: 5,
                                // ),
                                // GestureDetector(
                                //   onTap: () {
                                //     value.editFood(item.id.toString());
                                //   },
                                //   child: const Text('Customisable'),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget allFoods(value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
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
          value.onEditFood();
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/f3.jpg',
                height: 100,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bruschetta'.tr,
                      style: const TextStyle(
                          fontFamily: 'semi-bold', fontSize: 18),
                    ),
                    Text(
                      'Bruschetta is an antipasto from Italy consisting'.tr,
                      style: const TextStyle(color: ThemeProvider.greyColor),
                    ),
                    Text(
                      'Veg'.tr,
                      style: const TextStyle(
                          color: ThemeProvider.greenColor, fontSize: 16),
                    ),
                    const Text(
                      '80.00',
                      style: TextStyle(fontFamily: 'semi-bold', fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
