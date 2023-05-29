/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:foodies_user/app/controller/add_new_address_controller.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:get/get.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewAddressController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            title: Text(
              value.action == 'new'.tr
                  ? 'Add New Address'.tr
                  : 'Update Address'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: value.addressTextEditor,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    hintText: '',
                    labelText: 'Address'.tr,
                    labelStyle: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: value.houseTextEditor,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    hintText: '',
                    labelText: 'House / Flat No'.tr,
                    labelStyle: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: value.landmarkTextEditor,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    hintText: '',
                    labelText: 'Landmark'.tr,
                    labelStyle: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: value.zipcodeTextEditor,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    hintText: '',
                    labelText: 'Zipcode'.tr,
                    labelStyle: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: value.optionalPhone,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    hintText: '',
                    labelText: 'Optional Phone Number'.tr,
                    labelStyle: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'SAVE AS'.tr,
                  style: const TextStyle(fontFamily: 'bold'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        value.onFilter(0);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.home_outlined),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Home'.tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              value.title == 0
                                  ? Icons.radio_button_checked
                                  : Icons.circle_outlined,
                              color: value.title == 0
                                  ? ThemeProvider.appColor
                                  : ThemeProvider.greyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        value.onFilter(1);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.work_outline),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Work'.tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              value.title == 1
                                  ? Icons.radio_button_checked
                                  : Icons.circle_outlined,
                              color: value.title == 1
                                  ? ThemeProvider.appColor
                                  : ThemeProvider.greyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        value.onFilter(2);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.home_work_outlined),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Other'.tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              value.title == 2
                                  ? Icons.radio_button_checked
                                  : Icons.circle_outlined,
                              color: value.title == 2
                                  ? ThemeProvider.appColor
                                  : ThemeProvider.greyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                value.getLatLngFromAddress();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: ThemeProvider.whiteColor,
                backgroundColor: ThemeProvider.appColor,
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
          ),
        );
      },
    );
  }
}
