/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vender/app/controller/add_food_controller.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/util/theme.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddFoodController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            title: Text(
              value.action == 'new'.tr ? 'Add Food'.tr : 'Update Food'.tr,
              style: const TextStyle(
                  fontFamily: 'bold',
                  fontSize: 18,
                  color: ThemeProvider.whiteColor),
            ),
          ),
          body: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeProvider.greyColor.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            value.onAllCategories(value.cateId, value.cateName);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              value.cateName.isEmpty
                                  ? Text('Category'.tr)
                                  : Text(value.cateName.toString()),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: ThemeProvider.greyColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeProvider.greyColor.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                          controller: value.foodName,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Food Name'.tr,
                              hintStyle: const TextStyle(
                                  color: ThemeProvider.greyColor)),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeProvider.greyColor.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                          controller: value.foodPrice,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Real Price'.tr,
                              hintStyle: const TextStyle(
                                  color: ThemeProvider.greyColor)),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeProvider.greyColor.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                          controller: value.discountPrice,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Discount Price'.tr,
                              hintStyle: const TextStyle(
                                  color: ThemeProvider.greyColor)),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeProvider.greyColor.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Veg'.tr),
                            Row(
                              children: [
                                DropdownButton(
                                  underline: const SizedBox(),
                                  value: value.foodType,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  items: value.items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    value.updateItem(newValue.toString());
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeProvider.greyColor.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                          controller: value.foodDescription,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Short  description'.tr,
                              hintStyle: const TextStyle(
                                  color: ThemeProvider.greyColor)),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeProvider.greyColor.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Status'.tr),
                            DropdownButton(
                              underline: const SizedBox(),
                              value: value.statusvalue,
                              icon: const Icon(Icons.arrow_drop_down),
                              items: value.status.map((String status) {
                                return DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                value.updateStatusValue(newValue.toString());
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeProvider.greyColor.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        child: GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoActionSheet(
                                title: Text('Choose From'.tr),
                                actions: <CupertinoActionSheetAction>[
                                  CupertinoActionSheetAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      value.selectFromGallery('camera');
                                    },
                                    child: Text('Camera'.tr),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      value.selectFromGallery('gallery');
                                    },
                                    child: Text('Gallery'.tr),
                                  ),
                                  CupertinoActionSheetAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'.tr),
                                  )
                                ],
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 200,
                            child: FadeInImage(
                              image: NetworkImage(
                                  '${Environments.apiBaseURL}storage/images/${value.cover}'),
                              placeholder:
                                  const AssetImage("assets/images/error.png"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/error.png',
                                    fit: BoxFit.cover);
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeProvider.greyColor.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Size?'.tr),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '(Regualar,Medium,Large)'.tr,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: ThemeProvider.greyColor),
                                )
                              ],
                            ),
                            DropdownButton(
                              underline: const SizedBox(),
                              value: value.sizevalue,
                              icon: const Icon(Icons.arrow_drop_down),
                              items: value.size.map((String size) {
                                return DropdownMenuItem(
                                  value: size,
                                  child: Text(size),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                value.updateSizeValue(newValue.toString());
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeProvider.greyColor.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Add-ons'.tr),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '(Extras,cold drinks)'.tr,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: ThemeProvider.greyColor),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    value.openNewVariationModal();
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: ThemeProvider.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: List.generate(
                          value.variationsList.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ThemeProvider.greyColor.shade300),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(value.variationsList[index].title
                                          .toString()),
                                      Row(
                                        children: [
                                          value.variationsList[index].isSize ==
                                                      false &&
                                                  value.variationsList[index]
                                                          .title !=
                                                      'size'
                                              ? IconButton(
                                                  onPressed: () {
                                                    value.updateVaritionsTitle(
                                                        index,
                                                        value
                                                            .variationsList[
                                                                index]
                                                            .title
                                                            .toString());
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color:
                                                        ThemeProvider.greyColor,
                                                  ))
                                              : const SizedBox(),
                                          IconButton(
                                              onPressed: () {
                                                value.openAddonNewItemModal(
                                                    value.variationsList[index]
                                                        .title
                                                        .toString(),
                                                    index);
                                              },
                                              icon: const Icon(
                                                Icons.add_circle,
                                                color: ThemeProvider.greyColor,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                value.removeVariations(value
                                                    .variationsList[index].title
                                                    .toString());
                                              },
                                              icon: const Icon(
                                                Icons.delete_outline,
                                                color: ThemeProvider.greyColor,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  child: Column(
                                    children: List.generate(
                                      value.variationsList[index].items!.length,
                                      (subIndex) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(value.variationsList[index]
                                                  .items![subIndex].title
                                                  .toString()),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                Get.find<AddFoodController>()
                                                            .currencySide ==
                                                        'left'
                                                    ? Get.find<AddFoodController>()
                                                            .currencySymbol +
                                                        value
                                                            .variationsList[
                                                                index]
                                                            .items![subIndex]
                                                            .price
                                                            .toString()
                                                    : value
                                                            .variationsList[
                                                                index]
                                                            .items![subIndex]
                                                            .price
                                                            .toString() +
                                                        Get.find<
                                                                AddFoodController>()
                                                            .currencySymbol,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    value
                                                        .updateAddonsItemsModal(
                                                            index,
                                                            subIndex,
                                                            value
                                                                .variationsList[
                                                                    index]
                                                                .title
                                                                .toString(),
                                                            value
                                                                .variationsList[
                                                                    index]
                                                                .items![
                                                                    subIndex]
                                                                .title
                                                                .toString(),
                                                            value
                                                                .variationsList[
                                                                    index]
                                                                .items![
                                                                    subIndex]
                                                                .price
                                                                .toString());
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color:
                                                        ThemeProvider.greyColor,
                                                  )),
                                              IconButton(
                                                onPressed: () {
                                                  value.removeSubAddonItems(
                                                      index,
                                                      value
                                                          .variationsList[index]
                                                          .items![subIndex]
                                                          .title
                                                          .toString());
                                                },
                                                icon: const Icon(
                                                  Icons.delete_outline,
                                                  color:
                                                      ThemeProvider.greyColor,
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
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (value.action == 'new') {
                            value.saveFood();
                          } else {
                            value.updateFood();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: ThemeProvider.appColor,
                          onPrimary: ThemeProvider.whiteColor,
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          value.action == 'new'.tr ? 'Submit'.tr : 'Update'.tr,
                          style: const TextStyle(
                            color: ThemeProvider.whiteColor,
                            fontSize: 16,
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
}
