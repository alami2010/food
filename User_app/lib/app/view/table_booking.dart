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
import 'package:get/get.dart';
import 'package:foodies_user/app/controller/table_booking_controller.dart';
import 'package:foodies_user/app/util/theme.dart';

class TableBooking extends StatefulWidget {
  const TableBooking({Key? key}) : super(key: key);

  @override
  State<TableBooking> createState() => _TableBookingState();
}

class _TableBookingState extends State<TableBooking> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TableBookingController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            'Table Booking'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selct An Offer Or Deal'.tr,
                style: const TextStyle(fontFamily: 'semi-bold', fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Select Date'.tr,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 8, bottom: 8),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DatePicker(
                      DateTime.now(),
                      width: 55,
                      height: 80,
                      controller: value.controller,
                      dateTextStyle:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: ThemeProvider.appColor,
                      selectedTextColor: Colors.white,
                      deactivatedColor: ThemeProvider.greyColor,
                      activeDates: List.generate(7,
                          (index) => DateTime.now().add(Duration(days: index))),
                      onDateChange: (date) {
                        value.onDateChange(date);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Select Time'.tr,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        value.changeSession(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: value.selectSlot == 1
                                ? ThemeProvider.appColor
                                : ThemeProvider.greyColor.shade300),
                        child: Text(
                          'Breakfast'.tr,
                          style: TextStyle(
                            color: value.selectSlot == 1
                                ? ThemeProvider.whiteColor
                                : ThemeProvider.blackColor,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        value.changeSession(2);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: value.selectSlot == 2
                                ? ThemeProvider.appColor
                                : ThemeProvider.greyColor.shade300),
                        child: Column(
                          children: [
                            Text(
                              'Lunch'.tr,
                              style: TextStyle(
                                color: value.selectSlot == 2
                                    ? ThemeProvider.whiteColor
                                    : ThemeProvider.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        value.changeSession(3);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: value.selectSlot == 3
                                ? ThemeProvider.appColor
                                : ThemeProvider.greyColor.shade300),
                        child: Text(
                          'Dinner'.tr,
                          style: TextStyle(
                            color: value.selectSlot == 3
                                ? ThemeProvider.whiteColor
                                : ThemeProvider.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Enter Guest Detail'.tr,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: value.totalGuest,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Total Guest'.tr,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 15)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: value.guestName,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Guest Name'.tr,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 15)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: value.mobileNumber,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Mobile Number'.tr,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 15)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: value.emailId,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Email Id'.tr,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 15)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: value.specialRequest,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Special Request (Optional)'.tr),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  value.onTableBooking();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeProvider.appColor,
                  foregroundColor: ThemeProvider.whiteColor,
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Save'.tr,
                  style: const TextStyle(
                    color: ThemeProvider.whiteColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
