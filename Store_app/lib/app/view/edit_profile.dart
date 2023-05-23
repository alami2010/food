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
import 'package:vender/app/controller/edit_profile_controller.dart';
import 'package:vender/app/env.dart';
import 'package:vender/app/util/theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          title: Text(
            'Edit Profile'.tr,
            style: const TextStyle(
                fontFamily: 'bold',
                fontSize: 18,
                color: ThemeProvider.whiteColor),
          ),
        ),
        body: value.apiCallled == false
            ? const Center(
                child: CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Restaurant Name'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeProvider.greyColor.shade300),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: value.storeName,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintStyle:
                                TextStyle(color: ThemeProvider.blackColor)),
                      ),
                    ),
                    Text(
                      'Restaurant Address'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeProvider.greyColor.shade300),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: value.address,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            hintStyle:
                                TextStyle(color: ThemeProvider.blackColor)),
                      ),
                    ),
                    Text(
                      'Restaurant Landmark'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeProvider.greyColor.shade300),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: value.landmark,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            hintStyle:
                                TextStyle(color: ThemeProvider.blackColor)),
                      ),
                    ),
                    Text(
                      'Pincode'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeProvider.greyColor.shade300),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: value.pincode,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintStyle:
                                TextStyle(color: ThemeProvider.blackColor)),
                      ),
                    ),
                    Text(
                      'Latitude'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeProvider.greyColor.shade300),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: value.lat,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintStyle:
                                TextStyle(color: ThemeProvider.blackColor)),
                      ),
                    ),
                    Text(
                      'Longitute'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeProvider.greyColor.shade300),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: value.lng,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintStyle:
                                TextStyle(color: ThemeProvider.blackColor)),
                      ),
                    ),
                    Text(
                      'Cost For Two'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeProvider.greyColor.shade300),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: value.costForTwo,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintStyle:
                                TextStyle(color: ThemeProvider.blackColor)),
                      ),
                    ),
                    Text(
                      'Phone'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeProvider.greyColor.shade300),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: value.mobile,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintStyle:
                                TextStyle(color: ThemeProvider.blackColor)),
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
                      child: InkWell(
                        onTap: () {
                          value.openTimePicker();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Open Time'.tr,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  value.openTime,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          value.closeTimePicker();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Close Time'.tr,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  value.closeTime,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: ThemeProvider.greyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'Estimate Delivery Time'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeProvider.greyColor.shade300),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: value.deliveryTime,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintStyle:
                                TextStyle(color: ThemeProvider.blackColor)),
                      ),
                    ),
                    Text(
                      'Restaurant Description'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeProvider.greyColor.shade300),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: value.shortDesc,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            hintStyle:
                                TextStyle(color: ThemeProvider.blackColor)),
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
                      child: InkWell(
                        onTap: () {
                          value.onCuisines();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Select Cuisine'.tr,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  value.cuisines.length > 35
                                      ? '${value.cuisines.substring(0, 35)}...'
                                      : value.cuisines,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Is Open'.tr,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              DropdownButton(
                                underline: const SizedBox(),
                                value: value.dropdownvalue,
                                icon: const Icon(Icons.arrow_drop_down),
                                items: value.items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  value.dropdownvalue = newValue!;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Upload Your Restaurant Cover Image'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
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
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            image: NetworkImage(
                                '${Environments.apiBaseURL}storage/images/${value.cover}'),
                            placeholder:
                                const AssetImage("assets/images/error.png"),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/images/error.png',
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover);
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Upload Gallery Image'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'semi-bold'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 80 / 100,
                          children: List.generate(6, (index) {
                            return _buildGallery(index);
                          }),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        value.updateProfile();
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
                        'SUBMIT'.tr,
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

  Widget _buildGallery(int index) {
    return InkWell(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            title: Text('Choose From'.tr),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: Text('Gallery'.tr),
                onPressed: () {
                  Navigator.pop(context);
                  Get.find<EditProfileController>()
                      .uploadMoreImage('gallery', index);
                },
              ),
              CupertinoActionSheetAction(
                child: Text('Camera'.tr),
                onPressed: () {
                  Navigator.pop(context);
                  Get.find<EditProfileController>()
                      .uploadMoreImage('camera', index);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Cancel'.tr,
                  style: const TextStyle(fontFamily: 'bold', color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
      child: Get.find<EditProfileController>().extraImages[index] == ''
          ? Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: ThemeProvider.greyColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Text('${'Image'.tr} ${index + 1}',
                      style: ThemeProvider.titleStyle)),
            )
          : SizedBox(
              width: double.infinity,
              height: 150,
              child: FadeInImage(
                image: NetworkImage(
                    '${Environments.apiBaseURL}storage/images/${Get.find<EditProfileController>().extraImages[index]}'),
                placeholder: const AssetImage("assets/images/error.png"),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/error.png',
                      fit: BoxFit.fitWidth);
                },
                fit: BoxFit.fitWidth,
              ),
            ),
    );
  }
}
