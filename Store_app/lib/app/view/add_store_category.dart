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
import 'package:vender/app/controller/add_store_category_controller.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/util/theme.dart';

class AddStoreCategory extends StatefulWidget {
  const AddStoreCategory({Key? key}) : super(key: key);

  @override
  State<AddStoreCategory> createState() => _AddStoreCategoryState();
}

class _AddStoreCategoryState extends State<AddStoreCategory> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddStoreCategoryController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          title: Text(
            value.action == 'new'.tr
                ? 'Add Store Category'.tr
                : 'Update  Store Category'.tr,
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
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
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
                  width: 100,
                  height: 100,
                  child: FadeInImage(
                    image: NetworkImage(
                        '${Environments.apiBaseURL}storage/images/${value.cover}'),
                    placeholder: const AssetImage("assets/images/error.png"),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/error.png',
                          fit: BoxFit.cover);
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: value.categoryName,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Add Category Name'.tr),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  // value.onBack();
                  if (value.action == 'new') {
                    value.createStore();
                  } else {
                    value.updateStoreInfo();
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
              ),
            ],
          ),
        ),
      );
    });
  }
}
