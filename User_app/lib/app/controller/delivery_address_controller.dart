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
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/models/address_model.dart';
import 'package:foodies_user/app/backend/parse/delivery_address_parse.dart';
import 'package:foodies_user/app/controller/add_new_address_controller.dart';
import 'package:foodies_user/app/controller/checkout_controller.dart';
import 'package:foodies_user/app/helper/router.dart';

class DeliveryAddressController extends GetxController implements GetxService {
  final DeliveryAddressParse parser;
  bool apiCalled = false;
  int title = 0;

  List<AddressModel> _addressList = <AddressModel>[];
  List<AddressModel> get addressList => _addressList;

  List<String> titles = ['Home'.tr, 'Work'.tr, 'Others'.tr];

  DeliveryAddressController({required this.parser});

  @override
  void onInit() {
    super.onInit();

    getSavedAddress();
  }

  Future<void> getSavedAddress() async {
    var param = {"id": parser.getUID()};

    Response response = await parser.getSavedAddress(param);
    debugPrint(response.bodyString);
    apiCalled = true;

    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      var address = myMap['data'];
      _addressList = [];
      address.forEach((add) {
        AddressModel adds = AddressModel.fromJson(add);
        _addressList.add(adds);
      });
      debugPrint(addressList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveDeliveryAddress(int id) {
    Get.find<CheckoutController>().saveDeliveryAddressId(id);
    onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onAddNewAddress() {
    Get.delete<AddNewAddressController>(force: true);
    Get.toNamed(AppRouter.getAddNewAddress(), arguments: ['cart', 'new']);
  }
}
