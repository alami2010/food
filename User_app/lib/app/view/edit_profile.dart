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
import 'package:upgrade/app/controller/edit_profile_controller.dart';
import 'package:upgrade/app/env.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:get/get.dart';

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
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
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
                                              value
                                                  .selectFromGallery('gallery');
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
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              ThemeProvider.greyColor.shade200),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(50),
                                        child: value.isUploading == false
                                            ? FadeInImage(
                                                image: NetworkImage(
                                                    '${Environments.apiBaseURL}storage/images/${value.cover}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/error.png"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return Image.asset(
                                                      'assets/images/error.png',
                                                      fit: BoxFit.fitWidth);
                                                },
                                                fit: BoxFit.fitWidth,
                                              )
                                            : const CircularProgressIndicator(
                                                color: ThemeProvider.appColor,
                                                strokeWidth: 2,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: value.firstName,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        hintText: 'First Name'.tr,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: value.lastName,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        hintText: 'Last Name'.tr,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: value.emailAddress,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        hintText: 'Email'.tr,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: value.mobileNumber,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        hintText: 'Mobile'.tr,
                      ),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              value.updateProfileData();
            },
            style: ElevatedButton.styleFrom(
              primary: ThemeProvider.appColor,
              onPrimary: ThemeProvider.whiteColor,
              minimumSize: const Size.fromHeight(45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: value.isLogin.value == true
                ? const CircularProgressIndicator(
                    color: ThemeProvider.whiteColor,
                  )
                : Text(
                    'Save Profile'.tr.toUpperCase(),
                    style: const TextStyle(
                      color: ThemeProvider.whiteColor,
                      fontSize: 16,
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
