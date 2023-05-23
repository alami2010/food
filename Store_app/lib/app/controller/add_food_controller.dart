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
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/models/food_details_model.dart';
import 'package:vender/app/backend/models/variations_model.dart';
import 'package:vender/app/backend/parse/add_food_parse.dart';
import 'package:vender/app/controller/all_categories_controller.dart';
import 'package:vender/app/controller/foods_screen_controller.dart';
import 'package:vender/app/helper/router.dart';
import 'package:vender/app/util/constant.dart';
import 'package:vender/app/util/theme.dart';
import 'package:vender/app/util/toast.dart';

class AddFoodController extends GetxController implements GetxService {
  final AddFoodParse parser;

  String foodType = 'Veg';
  String statusvalue = 'Available';
  String sizevalue = 'No';

  String cateId = '';
  String cateName = '';
  String cateFrom = '';
  XFile? _selectedImage;
  String cover = '';
  String storeId = '';
  String action = '';
  String foodId = '';

  List<String> items = [
    'Veg'.tr,
    'Non Veg'.tr,
  ];

  List<String> status = [
    'Available'.tr,
    'Hide'.tr,
  ];

  List<String> size = [
    'No'.tr,
    'Yes'.tr,
  ];

  final addonName = TextEditingController();
  String addonType = 'radio';

  final addonItemName = TextEditingController();
  final addontItemPrice = TextEditingController();

  final foodName = TextEditingController();
  final foodPrice = TextEditingController();
  final discountPrice = TextEditingController();
  final foodDescription = TextEditingController();

  bool apiCalled = false;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  List<VariationsModel> _variationsList = <VariationsModel>[];
  List<VariationsModel> get variationsList => _variationsList;

  FoodDetailsModel _foodDetailsInfo = FoodDetailsModel();
  FoodDetailsModel get foodDetailsInfo => _foodDetailsInfo;
  AddFoodController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    _variationsList = [];
    action = Get.arguments[0];
    if (Get.arguments[0] == 'update') {
      foodId = Get.arguments[1];
      debugPrint(foodId.toString());
      getFoodInfo();
    } else {
      apiCalled = true;
      update();
    }
  }

  void updateItem(String items) {
    foodType = items;
    debugPrint(items);
    update();
  }

  void updateStatusValue(String value) {
    statusvalue = value;
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

  void onAllCategories(String cateId, String cateName) {
    Get.delete<AllCategoriesController>(force: true);
    Get.toNamed(AppRouter.getAllCategories(),
        arguments: [cateId, cateName, cateFrom]);
  }

  void saveCategory(String id, String from, String name) {
    cateId = id.toString();
    cateFrom = from.toString();
    cateName = name.toString();
    update();
  }

  void updateSizeValue(String size) {
    sizevalue = size;
    debugPrint(size);
    var findIndex =
        _variationsList.indexWhere((element) => element.isSize == true);
    if (size == 'Yes') {
      if (findIndex < 0) {
        var param = {
          "isSize": true,
          "title": "size",
          "type": "radio",
          "items": []
        };
        VariationsModel data = VariationsModel.fromJson(param);
        _variationsList.add(data);
        debugPrint(jsonEncode(_variationsList).toString());
      } else {
        showToast('Already added');
      }
    } else {
      _variationsList.removeWhere((element) => element.title == 'size');
      update();
    }
    update();
  }

  void removeVariations(String name) {
    _variationsList.removeWhere((element) => element.title == name);
    if (name == 'size') {
      sizevalue = 'No';
    }
    update();
  }

  void openAddonNewItemModal(String addonTitle, int index) {
    Get.defaultDialog(
      title: '${'Add item to'.tr} $addonTitle',
      contentPadding: const EdgeInsets.all(15),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: addonItemName,
              decoration: InputDecoration(
                hintText: 'Add-ons name'.tr,
                border: const UnderlineInputBorder(),
                hintStyle: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: addontItemPrice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Add-ons price'.tr,
                border: const UnderlineInputBorder(),
                hintStyle: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Cancel'.tr,
                    style: const TextStyle(color: ThemeProvider.appColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    onSaveAddontItems(index);
                  },
                  child: Text(
                    'Ok'.tr,
                    style: const TextStyle(color: ThemeProvider.appColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateAddonsItemsModal(int index, int subIndex, String addonTitle,
      String addonsTitle, String addonsPrice) {
    addonItemName.text = addonsTitle;
    addontItemPrice.text = addonsPrice;
    Get.defaultDialog(
      title: '${'Update item to'.tr} $addonTitle',
      contentPadding: const EdgeInsets.all(15),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: addonItemName,
              decoration: InputDecoration(
                hintText: 'Add-ons name'.tr,
                border: const UnderlineInputBorder(),
                hintStyle: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: addontItemPrice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Add-ons price'.tr,
                border: const UnderlineInputBorder(),
                hintStyle: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Cancel'.tr,
                    style: const TextStyle(color: ThemeProvider.appColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    onUpdateAddonsItems(index, subIndex);
                    // onSaveAddontItems(index);
                  },
                  child: Text(
                    'Ok'.tr,
                    style: const TextStyle(color: ThemeProvider.appColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onUpdateAddonsItems(index, subIndex) {
    _variationsList[index].items![subIndex].title = addonItemName.text;
    _variationsList[index].items![subIndex].price =
        double.parse(addontItemPrice.text);
    addonItemName.clear();
    addontItemPrice.clear();
    update();
  }

  void onSaveAddontItems(int index) {
    var param = {
      "title": addonItemName.text.toString(),
      "price": num.tryParse(addontItemPrice.text)
    };
    debugPrint(param.toString());
    Items data = Items.fromJson(param);
    _variationsList[index].items!.add(data);
    addonItemName.clear();
    addontItemPrice.clear();
    update();
    debugPrint(jsonEncode(variationsList).toString());
  }

  void removeSubAddonItems(int index, String name) {
    _variationsList[index]
        .items!
        .removeWhere((element) => element.title == name);
    update();
  }

  void openNewVariationModal() {
    Get.defaultDialog(
      title: 'Add Add-ons!'.tr,
      contentPadding: const EdgeInsets.all(15),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: addonName,
              decoration: InputDecoration(
                hintText: 'Title'.tr,
                border: const UnderlineInputBorder(),
                hintStyle: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Cancel'.tr,
                    style: const TextStyle(color: ThemeProvider.appColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    var index = _variationsList.indexWhere(
                        (element) => element.title == addonName.text);
                    if (index >= 0) {
                      addonName.text = '';
                      update();
                      showToast('Addon already exist with this name');
                    } else {
                      openVariationTypeModal();
                    }
                  },
                  child: Text(
                    'Ok'.tr,
                    style: const TextStyle(color: ThemeProvider.appColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateVaritionsTitle(int index, String name) {
    addonName.text = name;
    update();
    Get.defaultDialog(
      title: 'Update Add-ons! Title'.tr,
      contentPadding: const EdgeInsets.all(15),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: addonName,
              decoration: InputDecoration(
                hintText: 'Title'.tr,
                border: const UnderlineInputBorder(),
                hintStyle: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Cancel'.tr,
                    style: const TextStyle(color: ThemeProvider.appColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    var findIndex = _variationsList.indexWhere(
                        (element) => element.title == addonName.text);
                    if (findIndex >= 0) {
                      update();
                      showToast('Addon already exist with this name');
                    } else {
                      _variationsList[index].title = addonName.text;
                      update();
                    }
                  },
                  child: Text(
                    'Ok'.tr,
                    style: const TextStyle(color: ThemeProvider.appColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onNewVaraitionSave() {
    var param = {
      "isSize": false,
      "title": addonName.text,
      "type": addonType,
      "items": []
    };
    VariationsModel data = VariationsModel.fromJson(param);
    _variationsList.add(data);
    debugPrint(jsonEncode(_variationsList).toString());

    addonName.text = '';
    addonType = 'radio';
    update();
  }

  void openVariationTypeModal() {
    Get.defaultDialog(
      title: 'Select Type'.tr,
      contentPadding: const EdgeInsets.all(15),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                addonType = 'radio';
                update();
                onNewVaraitionSave();
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: ThemeProvider.greyColor))),
                child: Row(
                  children: [
                    Icon(
                      addonType == 'radio'
                          ? Icons.radio_button_checked
                          : Icons.circle_outlined,
                      color: addonType == 'radio'
                          ? ThemeProvider.appColor
                          : ThemeProvider.greyColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Only One'.tr,
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
            GestureDetector(
              onTap: () {
                addonType = 'check';
                update();
                onNewVaraitionSave();
                Get.back();
              },
              child: Row(
                children: [
                  Icon(
                    addonType == 'check'
                        ? Icons.radio_button_checked
                        : Icons.circle_outlined,
                    color: addonType == 'check'
                        ? ThemeProvider.appColor
                        : ThemeProvider.greyColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Multiple'.tr,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveFood() async {
    if (cateName == '' ||
        cateName.isEmpty ||
        foodName.text == '' ||
        foodName.text.isEmpty ||
        foodPrice.text == '' ||
        foodPrice.text.isEmpty ||
        foodDescription.text == '' ||
        foodDescription.text.isEmpty ||
        cover == '' ||
        cover.isEmpty) {
      showToast('All Fields Are Required');
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
      barrierDismissible: false,
    );

    var param = {
      'store_id': parser.getStoreId(),
      'from_cate': cateFrom,
      'outofstock': 0,
      'recommended': 0,
      'cate_id': cateId,
      'cover': cover,
      'name': foodName.text.toString(),
      'details': foodDescription.text.toString(),
      'price': foodPrice.text.toString(),
      'rating': 0,
      'veg': foodType == 'Veg' ? 1 : 0,
      'variations':
          _variationsList.isNotEmpty ? jsonEncode(variationsList) : 'NA',
      'size': sizevalue == 'No' ? 0 : 1,
      'status': 1
    };

    Response response = await parser.saveFood(param);
    debugPrint(response.bodyString);

    Get.back();

    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      onBack();
      showToast('Successfully Add');
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  Future<void> getFoodInfo() async {
    var param = {
      "id": foodId,
    };
    Response response = await parser.getProductInfo(param);
    debugPrint(response.bodyString);
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _foodDetailsInfo = FoodDetailsModel();
      var body = myMap['data'];
      FoodDetailsModel datas = FoodDetailsModel.fromJson(body);
      _foodDetailsInfo = datas;
      cateName = _foodDetailsInfo.cateName.toString();
      cateId = _foodDetailsInfo.cateId.toString();
      foodName.text = _foodDetailsInfo.name.toString();
      foodPrice.text = _foodDetailsInfo.price.toString();
      discountPrice.text = _foodDetailsInfo.discount.toString();
      foodType = _foodDetailsInfo.veg == 1 ? 'Veg' : 'Non Veg';
      foodDescription.text = _foodDetailsInfo.details.toString();
      statusvalue = _foodDetailsInfo.status == 1 ? 'Available' : 'Hide';
      cover = _foodDetailsInfo.cover.toString();
      cateFrom = _foodDetailsInfo.fromCate.toString();
      sizevalue = _foodDetailsInfo.size == 1 ? "Yes" : "No";
      if (_foodDetailsInfo.variations != 'NA') {
        _variationsList = [];
        var items = jsonDecode(_foodDetailsInfo.variations.toString());
        items.forEach((element) {
          VariationsModel variation = VariationsModel.fromJson(element);
          _variationsList.add(variation);
        });
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> updateFood() async {
    var body = {
      "id": foodId,
      'from_cate': cateFrom,
      'outofstock': 0,
      'recommended': 0,
      'cate_id': cateId,
      'cover': cover,
      'name': foodName.text.toString(),
      'details': foodDescription.text.toString(),
      'price': foodPrice.text.toString(),
      'discount': discountPrice.text == '' || discountPrice.text.isEmpty
          ? 0
          : discountPrice.text,
      'rating': 0,
      'veg': foodType == 'Veg' ? 1 : 0,
      'variations':
          _variationsList.isNotEmpty ? jsonEncode(variationsList) : 'NA',
      'size': sizevalue == 'No' ? 0 : 1,
      'status': 1
    };
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

    var response = await parser.updateFood(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      successToast('Successfully Updated');
      Get.find<FoodsScreenController>().getFoods();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
