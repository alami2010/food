/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/parse/edit_profile_parse.dart';
import 'package:get/get.dart';
import 'package:upgrade/app/controller/account_controller.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:upgrade/app/util/toast.dart';

class EditProfileController extends GetxController implements GetxService {
  final EditProfileParse parser;

  bool apiCalled = false;
  XFile? _selectedImage;
  RxBool isLogin = false.obs;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final emailAddress = TextEditingController();
  final mobileNumber = TextEditingController();
  String cover = '';
  bool isUploading = false;

  EditProfileController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    Response response = await parser.getProfile();
    apiCalled = true;
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      debugPrint(body.toString());
      if (body != null && body != '') {
        firstName.text = body['first_name'] ?? '';
        lastName.text = body['last_name'] ?? '';
        emailAddress.text = body['email'] ?? '';
        mobileNumber.text = body['mobile'] ?? '';
        cover = body['cover'] ?? '';
        update();
      }
    } else {
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  void selectFromGallery(String kind) async {
    _selectedImage = await ImagePicker().pickImage(
        source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 25);
    update();
    if (_selectedImage != null) {
      Get.dialog(
          SimpleDialog(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const CircularProgressIndicator(
                    color: ThemeProvider.appColor,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                      child: Text(
                    "Please wait".tr,
                    style: const TextStyle(fontFamily: 'bold'),
                  )),
                ],
              )
            ],
          ),
          barrierDismissible: false);
      Response response = await parser.uploadImage(_selectedImage as XFile);
      Get.back();
      if (response.statusCode == 200) {
        _selectedImage = null;
        if (response.body['data'] != null && response.body['data'] != '') {
          dynamic body = response.body["data"];
          if (body['image_name'] != null && body['image_name'] != '') {
            cover = body['image_name'];
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  Future<void> updateProfileData() async {
    if (firstName.text == '' ||
        lastName.text == '' ||
        mobileNumber.text == '') {
      showToast('All fields are required');
      return;
    }
    isLogin.value = !isLogin.value;
    update();

    var param = {
      'cover': cover,
      'first_name': firstName.text,
      'last_name': lastName.text,
      'mobile': mobileNumber.text,
      'id': parser.getUID(),
    };
    Response response = await parser.updateProfile(param);
    isLogin.value = !isLogin.value;
    if (response.statusCode == 200) {
      successToast('Profile Updated');
      parser.saveInfo(firstName.text, lastName.text, cover, mobileNumber.text);
      Get.find<AccountController>().changeInfo();
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }
}
