/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/models/store_model.dart';
import 'package:vender/app/backend/parse/edit_profile_parse.dart';
import 'package:vender/app/controller/account_controller.dart';
import 'package:vender/app/controller/cuisine_controller.dart';
import 'package:vender/app/helper/router.dart';
import 'package:vender/app/util/theme.dart';
import 'package:vender/app/util/toast.dart';

class EditProfileController extends GetxController implements GetxService {
  final EditProfileParse parser;
  XFile? _selectedImage;
  String dropdownvalue = 'Open';

  var items = [
    'Open'.tr,
    'Closed'.tr,
  ];

  bool apiCallled = false;
  StoreModel _storeInfo = StoreModel();
  StoreModel get storeInfo => _storeInfo;

  final storeName = TextEditingController();
  final address = TextEditingController();
  final landmark = TextEditingController();
  final pincode = TextEditingController();
  final lat = TextEditingController();
  final lng = TextEditingController();
  final costForTwo = TextEditingController();
  final mobile = TextEditingController();
  final deliveryTime = TextEditingController();
  final shortDesc = TextEditingController();
  String cuisines = '';
  String cover = '';
  String openTime = '';
  String closeTime = '';
  List<String> extraImages = ['', '', '', '', '', ''];
  EditProfileController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getStoreInfo();
  }

  Future<void> getStoreInfo() async {
    Response response = await parser.getInfo();
    apiCallled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var data = myMap['data'];
      _storeInfo = StoreModel();
      StoreModel storeData = StoreModel.fromJson(data);
      _storeInfo = storeData;
      debugPrint(storeInfo.name);
      storeName.text = storeInfo.name.toString();
      address.text = storeInfo.address.toString();
      landmark.text = storeInfo.landmark.toString();
      pincode.text = storeInfo.pincode.toString();
      lat.text = storeInfo.lat.toString();
      lng.text = storeInfo.lng.toString();
      costForTwo.text = storeInfo.costForTwo.toString();
      mobile.text = storeInfo.mobile.toString();
      cuisines = storeInfo.cuisines.toString();
      shortDesc.text = storeInfo.shortDescriptions.toString();
      openTime = storeInfo.openTime.toString();
      closeTime = storeInfo.closeTime.toString();
      deliveryTime.text = storeInfo.deliveryTime.toString();
      dropdownvalue = storeInfo.isClosed == 0 ? 'Open' : 'Closed';
      cover = storeInfo.cover.toString();
      if (storeInfo.openTime != '') {
        var time = storeInfo.openTime!.split(':');
        if (time.isNotEmpty) {
          openTime = Jiffy({
            "year": 2020,
            "month": 10,
            "day": 19,
            "hour": num.parse(time[0]).toInt(),
            "minute": num.parse(time[1]).toInt(),
          }).format("H:mm").toString();
        }
      }

      if (storeInfo.closeTime != '') {
        var time = storeInfo.closeTime!.split(':');
        if (time.isNotEmpty) {
          closeTime = Jiffy({
            "year": 2020,
            "month": 10,
            "day": 19,
            "hour": num.parse(time[0]).toInt(),
            "minute": num.parse(time[1]).toInt(),
          }).format("H:mm").toString();
        }
      }
      if (storeInfo.images != 'NA') {
        List<dynamic> images = jsonDecode(storeInfo.images.toString());
        images.asMap().forEach((index, value) {
          extraImages[index] = value;
        });
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> openTimePicker() async {
    var context = Get.context as BuildContext;
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.input);
    openTime = Jiffy({
      "year": 2020,
      "month": 10,
      "day": 19,
      "hour": pickedTime!.hour,
      "minute": pickedTime.minute,
    }).format("H:mm").toString();
    update();
  }

  Future<void> closeTimePicker() async {
    var context = Get.context as BuildContext;
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.input);
    closeTime = Jiffy({
      "year": 2020,
      "month": 10,
      "day": 19,
      "hour": pickedTime!.hour,
      "minute": pickedTime.minute
    }).format("H:mm").toString();
    update();
  }

  void onCuisines() {
    Get.delete<CuisineController>(force: true);
    Get.toNamed(AppRouter.getCuisineRoutes(), arguments: [cuisines]);
  }

  void saveCuisines(String list) {
    cuisines = list;
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

  void uploadMoreImage(String kind, int index) async {
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
            extraImages[index] = body['image_name'];
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  void updateProfile() {
    if (storeName.text.isEmpty ||
        address.text.isEmpty ||
        landmark.text.isEmpty ||
        pincode.text.isEmpty ||
        lat.text.isEmpty ||
        lng.text.isEmpty ||
        costForTwo.text.isEmpty ||
        deliveryTime.text.isEmpty ||
        shortDesc.text.isEmpty ||
        cuisines.isEmpty ||
        cover.isEmpty) {
      showToast('All Fields Are Required');
      return;
    }
    saveData();
  }

  Future<void> saveData() async {
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
    var param = {
      "uid": parser.getUID(),
      "name": storeName.text,
      "cover": cover,
      "mobile": mobile.text,
      "address": address.text,
      "landmark": landmark.text,
      "pincode": pincode.text,
      "lat": lat.text,
      "lng": lng.text,
      "short_descriptions": shortDesc.text,
      "open_time": openTime,
      "close_time": closeTime,
      "is_closed": dropdownvalue == 'Open' ? 0 : 1,
      "cuisines": cuisines,
      "delivery_time": deliveryTime.text,
      "cost_for_two": costForTwo.text,
      "images": jsonEncode(extraImages)
    };
    var response = await parser.updateData(param);
    Get.back();
    if (response.statusCode == 200) {
      successToast('Updated');
      parser.saveInfo(storeName.text, address.text, openTime, closeTime, cover,
          lat.text, lng.text);
      Get.find<AccountController>().getData();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
