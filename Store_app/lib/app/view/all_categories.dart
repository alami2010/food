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
import 'package:vender/app/controller/all_categories_controller.dart';
import 'package:vender/app/util/theme.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllCategoriesController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            title: Text(
              'Select Category'.tr,
              style: const TextStyle(
                  fontFamily: 'bold',
                  fontSize: 18,
                  color: ThemeProvider.whiteColor),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                for (var item in value.categories)
                  GestureDetector(
                    onTap: () {
                      value.onCategory(item.id.toString(), item.from.toString(),
                          item.cateId.toString(), item.name.toString());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Icon(
                            value.cateId == item.cateId.toString()
                                ? Icons.radio_button_checked
                                : Icons.circle_outlined,
                            color: value.cateId == item.cateId.toString()
                                ? ThemeProvider.appColor
                                : ThemeProvider.greyColor,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                item.name.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                value.onSave();
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
                'Submit'.tr,
                style: const TextStyle(
                  color: ThemeProvider.whiteColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget selectCategory(value) {
    return GestureDetector(
      onTap: () {
        value.onCategory(0);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Icon(
              value.category == 0
                  ? Icons.radio_button_checked
                  : Icons.circle_outlined,
              color: value.category == 1
                  ? ThemeProvider.appColor
                  : ThemeProvider.greyColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  value.name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
