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
import 'package:vender/app/controller/add_admin_category_controller.dart';
import 'package:vender/app/util/theme.dart';

class AddAdminCategory extends StatefulWidget {
  const AddAdminCategory({Key? key}) : super(key: key);

  @override
  State<AddAdminCategory> createState() => _AddAdminCategoryState();
}

class _AddAdminCategoryState extends State<AddAdminCategory> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAdminCategoryController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            title: Text(
              'Add Admin Category'.tr,
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
                for (var item in value.masterData)
                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: ThemeProvider.appColor,
                            value: item.isChecked,
                            onChanged: (bool? status) {
                              value.onExtra(status!, item.id as int);
                            },
                          ),
                          Text(
                            item.name.toString(),
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ThemeProvider.greyColor,
                      onPrimary: ThemeProvider.whiteColor,
                      minimumSize: const Size.fromHeight(35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Cancel'.tr,
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
                      // Navigator.pop(context);
                      value.onUpdate();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ThemeProvider.appColor,
                      onPrimary: ThemeProvider.whiteColor,
                      minimumSize: const Size.fromHeight(35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
