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
import 'package:image_picker/image_picker.dart';
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/models/store_category_model.dart';
import 'package:vender/app/backend/parse/add_store_category_parse.dart';
import 'package:vender/app/controller/add_category_controller.dart';
import 'package:vender/app/util/theme.dart';
import 'package:vender/app/util/toast.dart';

class AddStoreCategoryController extends GetxController implements GetxService {
  final AddStoreCategoryParse parser;

  XFile? _selectedImage;
  String cover = '';
  int cateId = 0;
  String action = '';

  final categoryName = TextEditingController();

  StoreCategoryModel _storeInfo = StoreCategoryModel();
  StoreCategoryModel get storeInfo => _storeInfo;

  AddStoreCategoryController({required this.parser});

  @override
  void onInit() {
    debugPrint('api call');
    super.onInit();
    categoryName.text = '';
    action = Get.arguments[0];
    if (Get.arguments[0] == 'update') {
      cateId = Get.arguments[1];
      getStoreById();
    }
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

  Future<void> createStore() async {
    if (categoryName.text == '' ||
        categoryName.text.isEmpty ||
        cover == '' ||
        cover.isEmpty) {
      showToast('All fields are required');
      return;
    }

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
      'store_id': parser.getStoreId(),
      'name': categoryName.text,
      'cover': cover,
      'status': 1
    };

    Response response = await parser.createStore(param);
    Get.back();

    if (response.statusCode == 200) {
      Get.find<AddCategoryController>().getCategory();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  Future<void> getStoreById() async {
    var param = {"id": cateId};

    Response response = await parser.storeGetById(param);

    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      _storeInfo = StoreCategoryModel();
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      StoreCategoryModel datas = StoreCategoryModel.fromJson(body);
      _storeInfo = datas;
      categoryName.text = _storeInfo.name.toString();
      cover = _storeInfo.cover as String;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> updateStoreInfo() async {
    var body = {
      "id": cateId,
      "cover": cover,
      "name": categoryName.text,
    };
    debugPrint(body.toString());
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
      barrierDismissible: false,
    );

    var response = await parser.updateStore(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      successToast('Successfully Updated');
      Get.find<AddCategoryController>().getCategory();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
