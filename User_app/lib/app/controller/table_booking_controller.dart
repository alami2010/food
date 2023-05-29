/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:foodies_user/app/backend/api/handler.dart';
import 'package:foodies_user/app/backend/parse/table_booking_parse.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/helper/router.dart';
import 'package:foodies_user/app/util/theme.dart';
import 'package:foodies_user/app/util/toast.dart';

class TableBookingController extends GetxController implements GetxService {
  final TableBookingParse parser;

  int selectSlot = 1; //1 Breakfast  2 Lunch 3 Dinner
  final totalGuest = TextEditingController();
  final guestName = TextEditingController();
  final mobileNumber = TextEditingController();
  final emailId = TextEditingController();
  final specialRequest = TextEditingController();
  String resId = '';
  String savedDate = '';
  bool haveData = false;
  final DatePickerController controller = DatePickerController();

  TableBookingController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    resId = Get.arguments[0];
  }

  Future<void> onTableBooking() async {
    if (totalGuest.text == '' ||
        totalGuest.text.isEmpty ||
        guestName.text == '' ||
        guestName.text.isEmpty ||
        mobileNumber.text == '' ||
        mobileNumber.text.isEmpty ||
        emailId.text == '' ||
        emailId.text.isEmpty) {
      showToast('All fields are required');
    }
    if (!GetUtils.isEmail(emailId.text)) {
      showToast("Email is not valid");
      return;
    }
    var body = {
      "uid": parser.getUID(),
      "store_id": resId,
      "total_guest": totalGuest.text,
      "guest_name": guestName.text,
      "mobile": mobileNumber.text,
      "email": emailId.text,
      "notes": specialRequest.text,
      "saved_date": savedDate,
      "slot": selectSlot,
      "status": 1
    };

    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: const [
                SizedBox(
                  width: 30,
                ),
                CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait",
                  style: TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    debugPrint(body.toString());
    var response = await parser.tableBooking(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      showToast('Your Table is successfully booked');
      onTableList();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  onTableList() {
    Get.delete<TableBookingController>(force: true);
    Get.toNamed(AppRouter.getTableList());
  }

  void onDateChange(DateTime date) {
    haveData = false;
    debugPrint(date.toString());
    var dayName = Jiffy(date).format("EEEE"); // Tuesday
    var selectedDate = Jiffy(date).format('yyyy-MM-dd');
    savedDate = selectedDate;
    update();
    debugPrint(dayName);
  }

  void changeSession(int time) {
    selectSlot = time;
    update();
  }
}
