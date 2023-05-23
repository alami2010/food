/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/models/address_model.dart';
import 'package:upgrade/app/backend/parse/saved_address_parse.dart';
import 'package:upgrade/app/controller/add_new_address_controller.dart';
import 'package:upgrade/app/helper/router.dart';
import 'package:get/get.dart';
import 'package:upgrade/app/util/theme.dart';

class SavedAddressController extends GetxController implements GetxService {
  final SavedAddressParse parser;

  bool apiCalled = false;

  List<AddressModel> _addressList = <AddressModel>[];
  List<AddressModel> get addressList => _addressList;

  List<String> titles = ['Home'.tr, 'Work'.tr, 'Others'.tr];
  SavedAddressController({required this.parser});

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

  void onAddNewAddress() {
    Get.delete<AddNewAddressController>(force: true);
    Get.toNamed(AppRouter.getAddNewAddress(), arguments: ['list', 'new']);
  }

  void updateAddress(int id) {
    Get.delete<AddNewAddressController>(force: true);
    Get.toNamed(AppRouter.getAddNewAddress(),
        arguments: ['list', 'update', id]);
  }

  Future<void> deleteAddress(int id) async {
    Get.dialog(
      const SimpleDialog(
        children: [
          Center(
            child: CircularProgressIndicator(
              color: ThemeProvider.appColor,
            ),
          )
        ],
      ),
    );

    var param = {"id": id};
    Response response = await parser.deleteAddress(param);
    Get.back();

    if (response.statusCode == 200) {
      getSavedAddress();
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }
}
