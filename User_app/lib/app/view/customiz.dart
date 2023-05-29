/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:foodies_user/app/controller/customiz_controller.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:get/get.dart';

class CustomizScreen extends StatefulWidget {
  final String id;
  final String name;
  const CustomizScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<CustomizScreen> createState() => _CustomizScreenState();
}

class _CustomizScreenState extends State<CustomizScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CustomizController>().getFoodDetails(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomizController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          title: Text(
            widget.name,
            style: ThemeProvider.titleStyle,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: value.sameProduct == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Repeat Order'.tr.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16, fontFamily: 'bold')),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: List.generate(
                              value.sameCart.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                          value.sameCart[index]
                                              .savedVariationsList.length,
                                          (subIndex) => Text(
                                                '${value.sameCart[index].savedVariationsList[subIndex].title.toString().toUpperCase()} - ${value.sameCart[index].savedVariationsList[subIndex].price.toString().toUpperCase()}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              )),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            value
                                                .removeProductVariationsQuantity(
                                                    index);
                                          },
                                          child: const Icon(
                                            Icons.remove_circle_outline,
                                            size: 20,
                                            color: ThemeProvider.greyColor,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          value.sameCart[index].quantity
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'bold', fontSize: 16),
                                        ),
                                        const SizedBox(width: 5),
                                        InkWell(
                                          onTap: () {
                                            value.updateSameProductQuantity(
                                                index);
                                          },
                                          child: const Icon(
                                            Icons.add_circle_outline,
                                            size: 20,
                                            color: ThemeProvider.appColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          value.productDetails.variations!.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value.productDetails.variations![index].title
                                      .toString()
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 14, fontFamily: 'bold'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                value.productDetails.variations![index].type ==
                                        'radio'
                                    ? Column(
                                        children: List.generate(
                                          value.productDetails
                                              .variations![index].items!.length,
                                          (subIndex) => GestureDetector(
                                            onTap: () {
                                              // value.onFilter(id);
                                              value.saveRadioListName(
                                                  index, subIndex);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: ThemeProvider
                                                              .greyColor
                                                              .shade300))),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    value
                                                                .productDetails
                                                                .variations![
                                                                    index]
                                                                .items![
                                                                    subIndex]
                                                                .isChecked ==
                                                            true
                                                        ? Icons
                                                            .radio_button_checked
                                                        : Icons.circle_outlined,
                                                    color: value
                                                                .productDetails
                                                                .variations![
                                                                    index]
                                                                .items![
                                                                    subIndex]
                                                                .isChecked ==
                                                            true
                                                        ? ThemeProvider.appColor
                                                        : ThemeProvider
                                                            .greyColor,
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        value
                                                            .productDetails
                                                            .variations![index]
                                                            .items![subIndex]
                                                            .title
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    Get.find<CustomizController>()
                                                                .currencySide ==
                                                            'left'
                                                        ? Get.find<CustomizController>()
                                                                .currencySymbol +
                                                            value
                                                                .productDetails
                                                                .variations![
                                                                    index]
                                                                .items![
                                                                    subIndex]
                                                                .price
                                                                .toString()
                                                        : value
                                                                .productDetails
                                                                .variations![
                                                                    index]
                                                                .items![
                                                                    subIndex]
                                                                .price
                                                                .toString() +
                                                            Get.find<
                                                                    CustomizController>()
                                                                .currencySymbol,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: List.generate(
                                          value.productDetails
                                              .variations![index].items!.length,
                                          (subIndex) => GestureDetector(
                                            onTap: () {
                                              value.saveCheckBoxListItem(
                                                  index, subIndex);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: ThemeProvider
                                                              .greyColor
                                                              .shade300))),
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    checkColor: Colors.white,
                                                    activeColor:
                                                        ThemeProvider.appColor,
                                                    value: value
                                                        .productDetails
                                                        .variations![index]
                                                        .items![subIndex]
                                                        .isChecked,
                                                    onChanged:
                                                        (bool? status) {},
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        value
                                                            .productDetails
                                                            .variations![index]
                                                            .items![subIndex]
                                                            .title
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    Get.find<CustomizController>()
                                                                .currencySide ==
                                                            'left'
                                                        ? Get.find<CustomizController>()
                                                                .currencySymbol +
                                                            value
                                                                .productDetails
                                                                .variations![
                                                                    index]
                                                                .items![
                                                                    subIndex]
                                                                .price
                                                                .toString()
                                                        : value
                                                                .productDetails
                                                                .variations![
                                                                    index]
                                                                .items![
                                                                    subIndex]
                                                                .price
                                                                .toString() +
                                                            Get.find<
                                                                    CustomizController>()
                                                                .currencySymbol,
                                                    style: const TextStyle(
                                                      fontSize: 16,
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
                        ),
                      ),
              ),
        bottomNavigationBar: value.apiCalled == true
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: value.sameProduct == true
                    ? Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                value.updateSameProduct();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeProvider.appColor,
                                foregroundColor: ThemeProvider.whiteColor,
                                minimumSize: const Size.fromHeight(45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Update'.tr,
                                style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                value.onAddingNew();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeProvider.appColor,
                                foregroundColor: ThemeProvider.whiteColor,
                                minimumSize: const Size.fromHeight(45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Add New'.tr,
                                style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () {
                          value.onSaveItem();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeProvider.appColor,
                          foregroundColor: ThemeProvider.whiteColor,
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Add to cart'.tr,
                          style: const TextStyle(
                            color: ThemeProvider.whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ))
            : const SizedBox(),
      );
    });
  }
}
