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
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/models/bookings_model.dart';
import 'package:vender/app/backend/parse/bookings_parse.dart';
import 'package:vender/app/util/theme.dart';

class BookingsController extends GetxController implements GetxService {
  final BookingParse parser;
  bool apiCalled = false;

  List<BookingsModel> _bookingList = <BookingsModel>[];
  List<BookingsModel> get bookingList => _bookingList;

  List<String> orderStatusList = [
    'Requested'.tr, // 0
    'Accept'.tr, // 1
    'Reject'.tr, // 2
    'Comlete'.tr, // 3
  ];

  BookingsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getTableBookinList();
  }

  Future<void> getTableBookinList() async {
    Response response = await parser.getBookings();
    debugPrint(bookingList.length.toString());

    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var booking = myMap['data'];
      _bookingList = [];
      booking.forEach((element) {
        BookingsModel ele = BookingsModel.fromJson(element);
        _bookingList.add(ele);
        debugPrint(bookingList.length.toString());
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> updateBookingInfo(int id, int status) async {
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
                  "Updating Status".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    var body = {"id": id, "status": status};

    Response response = await parser.updateBookingInfo(body);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      getTableBookinList();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
