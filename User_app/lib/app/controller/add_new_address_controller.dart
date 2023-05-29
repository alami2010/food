/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/models/address_model.dart';
import 'package:foodies_user/app/backend/models/google_address_model.dart';
import 'package:foodies_user/app/backend/parse/add_new_address_parse.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/controller/checkout_controller.dart';
import 'package:foodies_user/app/controller/delivery_address_controller.dart';
import 'package:foodies_user/app/controller/saved_address_controller.dart';
import 'package:foodies_user/app/env.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:foodies_user/app/util/toast.dart';

class AddNewAddressController extends GetxController implements GetxService {
  final AddNewAddressParse parser;
  int title = 0;

  final addressTextEditor = TextEditingController();
  final houseTextEditor = TextEditingController();
  final landmarkTextEditor = TextEditingController();
  final zipcodeTextEditor = TextEditingController();
  final optionalPhone = TextEditingController();
  int addressId = 0;
  double lat = 0.0;
  double lng = 0.0;
  String action = '';
  String from = '';
  List<int> updateAddId = [];

  AddressModel _addressInfo = AddressModel();
  AddressModel get addressInfo => _addressInfo;
  AddNewAddressController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    from = Get.arguments[0];
    action = Get.arguments[1];
    if (Get.arguments[1] == 'update') {
      addressId = Get.arguments[2];
      getAddressById();
    }
  }

  void onFilter(int choice) {
    title = choice;
    update();
  }

  void getLatLngFromAddress() async {
    if (addressTextEditor.text == '' ||
        addressTextEditor.text.isEmpty ||
        houseTextEditor.text == '' ||
        houseTextEditor.text.isEmpty ||
        landmarkTextEditor.text == '' ||
        landmarkTextEditor.text.isEmpty ||
        zipcodeTextEditor.text == '' ||
        zipcodeTextEditor.text.isEmpty ||
        optionalPhone.text == '' ||
        optionalPhone.text.isEmpty) {
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
      barrierDismissible: false,
    );
    var response = await parser.getLatLngFromAddress(
        'https://maps.googleapis.com/maps/api/geocode/json?address=${addressTextEditor.text} ${houseTextEditor.text} ${landmarkTextEditor.text}${zipcodeTextEditor.text}&key=${Environments.googleMapsKey}');
    debugPrint(response.bodyString);
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      GoogleAddresModel address = GoogleAddresModel.fromJson(myMap);
      debugPrint(address.toString());
      if (address.results!.isNotEmpty) {
        debugPrint('ok');
        lat = address.results![0].geometry!.location!.lat!;
        lng = address.results![0].geometry!.location!.lng!;
        if (action == 'new') {
          debugPrint('create');
          saveAddress();
        } else {
          debugPrint('update');
          updateAddress();
        }
      } else {
        Get.back();
        showToast("could not determine your location");
        update();
      }
    } else {
      Get.back();
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> saveAddress() async {
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

    var body = {
      "uid": parser.getUID(),
      "is_default": 1,
      "optional_phone": optionalPhone.text,
      "title": title,
      "address": addressTextEditor.text,
      "house": houseTextEditor.text,
      "landmark": landmarkTextEditor.text,
      "pincode": zipcodeTextEditor.text,
      "lat": lat,
      "lng": lng,
      "status": 1
    };
    var response = await parser.saveAddress(body);
    Get.back();

    debugPrint(response.bodyString);

    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('Successfully Added');
      if (from == 'list') {
        Get.find<SavedAddressController>().getSavedAddress();
      } else {
        Get.find<DeliveryAddressController>().getSavedAddress();
        Get.find<CheckoutController>().getSavedAddress();
      }
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onBack() {
    debugPrint('ok back');
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  Future<void> getAddressById() async {
    var param = {"id": addressId};

    Response response = await parser.getAddressById(param);

    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      _addressInfo = AddressModel();
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      AddressModel datas = AddressModel.fromJson(body);
      _addressInfo = datas;
      addressTextEditor.text = _addressInfo.address.toString();
      houseTextEditor.text = _addressInfo.house.toString();
      landmarkTextEditor.text = _addressInfo.landmark.toString();
      zipcodeTextEditor.text = _addressInfo.pincode.toString();
      optionalPhone.text = _addressInfo.optionalPhone.toString();
      title = _addressInfo.title as int;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> updateAddress() async {
    var body = {
      "optional_phone": optionalPhone.text,
      "title": title,
      "address": addressTextEditor.text,
      "house": houseTextEditor.text,
      "landmark": landmarkTextEditor.text,
      "pincode": zipcodeTextEditor.text,
      "lat": lat,
      "lng": lng,
      "id": addressId
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

    var response = await parser.updateAddress(body);
    Get.back();

    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('Successfully Updated');
      if (from == 'list') {
        Get.find<SavedAddressController>().getSavedAddress();
      } else {
        Get.find<DeliveryAddressController>().getSavedAddress();
        Get.find<CheckoutController>().getSavedAddress();
      }
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
