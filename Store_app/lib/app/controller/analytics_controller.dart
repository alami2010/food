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
import 'package:jiffy/jiffy.dart';
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/models/orders_model.dart';
import 'package:vender/app/backend/parse/analytics_parse.dart';
import 'package:vender/app/util/constant.dart';
import 'package:vender/app/util/theme.dart';

class AnalyticsController extends GetxController implements GetxService {
  final AnalyticsParse parser;
  String openTime = '';
  String closeTime = '';
  DateTime date = DateTime.now();

  String startDate = '';
  String endDate = '';

  String todaysDate = '';

  double commission = 0.0;
  double commisionAmount = 0.0;
  double totalAmount = 0.0;
  String uid = '';
  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  String storeName = '';
  String storeAddress = '';
  String storeMobile = '';
  String storeZipcode = '';
  String storeEmail = '';

  bool haveData = false;

  List<OrdersModel> _productList = <OrdersModel>[];
  List<OrdersModel> get productList => _productList;

  AnalyticsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    storeName = parser.storeName();
    storeAddress = parser.storeAddress();
    storeMobile = parser.getMobile();
    storeZipcode = parser.getZipcode();
    storeEmail = parser.getEmail();
    todaysDate = Jiffy(date).yMMMMd.toString();
    uid = parser.getUID();
  }

  Future<void> openTimePicker() async {
    var context = Get.context as BuildContext;
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ThemeProvider.appColor
                  .withOpacity(0.7), // header background color
              onPrimary: ThemeProvider.whiteColor, // header text color
              onSurface: ThemeProvider.blackColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: ThemeProvider.appColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    openTime = Jiffy(newDate).yMMMMd.toString();
    startDate = Jiffy(newDate!.toUtc()).format('yyyy-MM-d HH:mm').toString();
    debugPrint(startDate);
    update();
  }

  Future<void> closeTimePicker() async {
    var context = Get.context as BuildContext;
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ThemeProvider.appColor
                  .withOpacity(0.7), // header background color
              onPrimary: ThemeProvider.whiteColor, // header text color
              onSurface: ThemeProvider.blackColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: ThemeProvider.appColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    closeTime = Jiffy(newDate).yMMMMd.toString();
    endDate = Jiffy(newDate!.toUtc()).format('yyyy-MM-d HH:mm').toString();
    debugPrint(endDate.toString());
    update();
  }

  Future<void> getResult() async {
    if (startDate != '' && endDate != '') {
      debugPrint('get Result');
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
      _productList = [];
      Response response = await parser.getResults(startDate, endDate);
      Get.back();
      haveData = true;
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        commission =
            double.parse((myMap['commission']['rate']).toStringAsFixed(2));
        debugPrint('commsion$commission');
        double total = 0;
        body.forEach((data) {
          OrdersModel info = OrdersModel.fromJson(data);
          info.createdAt = Jiffy(info.createdAt).yMMMMEEEEdjm;
          info.items = info.items!
              .where((element) => element.storeId.toString() == uid)
              .toList();
          info.status = info.status;

          if (info.status == 4) {
            for (var element in info.items!) {
              if (element.discount! == 0) {
                if (element.size == 1) {
                  if (element.savedVariationsList.isNotEmpty) {
                    for (var variant in element.savedVariationsList) {
                      total = total + variant.price! + variant.quantity!;
                    }
                  }
                } else {
                  total = total + element.price! * element.quantity;
                }
              } else {
                if (element.size == 1) {
                  if (element.savedVariationsList.isNotEmpty) {
                    for (var variant in element.savedVariationsList) {
                      total = total + variant.price! + variant.quantity!;
                    }
                  }
                } else {
                  total = total + element.discount! * element.quantity;
                }
              }
            }
          }
          _productList.add(info);
        });
        percentage(total, per) {
          return (total / 100) * per;
        }

        double totalPrice = percentage(total, commission);
        commisionAmount = double.parse((totalPrice).toStringAsFixed(2));
        totalAmount = total;
        update();
        debugPrint(commisionAmount.toString());
        debugPrint(totalAmount.toString());
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  String getCommission(total) {
    double sum = (total * commission) / 100;
    sum = double.parse((sum).toStringAsFixed(2));
    return sum.toString();
    // return double.parse(((total * commission) / 100)).toString();
  }
}
