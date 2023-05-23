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
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/models/offers_model.dart';
import 'package:upgrade/app/backend/parse/coupens_parse.dart';
import 'package:upgrade/app/controller/checkout_controller.dart';
import 'package:upgrade/app/util/toast.dart';

class CoupensController extends GetxController implements GetxService {
  final CoupensParse parser;
  List<OffersModel> _offersList = <OffersModel>[];
  List<OffersModel> get offersList => _offersList;
  bool apiCalled = false;
  String offerId = '';
  String offerName = '';

  CoupensController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    getActiveOffers();
  }

  Future<void> getActiveOffers() async {
    Response response = await parser.getActiveOffers();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _offersList = [];
      if (body != null) {
        body.forEach((element) {
          OffersModel data = OffersModel.fromJson(element);
          _offersList.add(data);
        });
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void selectOffer(String id, String name) {
    offerId = id;
    offerName = name;
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void addCoupen() {
    if (offerId.isEmpty) {
      showToast('Please select offer');
      return;
    }
    var selectedCoupon =
        _offersList.firstWhere((element) => element.id.toString() == offerId);
    Get.find<CheckoutController>().onSaveCoupon(selectedCoupon);
    Get.find<CheckoutController>()
        .savedCoupens(offerId.toString(), offerName.toString());
    onBack();
  }
}
