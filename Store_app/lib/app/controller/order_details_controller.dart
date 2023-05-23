/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/models/drivers_model.dart';
import 'package:vender/app/backend/models/orders_model.dart';
import 'package:vender/app/backend/models/user_info_model.dart';
import 'package:vender/app/backend/parse/order_details_parse.dart';
import 'package:vender/app/controller/driver_list_controller.dart';
import 'package:vender/app/controller/order_screen_controller.dart';
import 'package:vender/app/helper/router.dart';
import 'package:vender/app/util/constant.dart';
import 'package:vender/app/util/theme.dart';
import 'package:vender/app/util/toast.dart';

class OrderDetailsController extends GetxController implements GetxService {
  final OrderDetailsParse parser;

  int orderId = 0;
  bool apiCalled = false;

  OrdersModel _orderInfo = OrdersModel();
  OrdersModel get orderInfo => _orderInfo;

  UserInfoModel _userInfo = UserInfoModel();
  UserInfoModel get userInfo => _userInfo;

  List<DriversModel> _driverList = <DriversModel>[];
  List<DriversModel> get driverList => _driverList;

  UserInfoModel _driverInfo = UserInfoModel();
  UserInfoModel get driverInfo => _driverInfo;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  List<String> titles = ['Home'.tr, 'Work'.tr, 'Others'.tr];
  List<String> payment = [
    'NA'.tr,
    'COD'.tr,
    'Stripe'.tr,
    'PayPal'.tr,
    'Paytm'.tr,
    'Razorpay'.tr,
    'Instamojo'.tr,
    'Paystack'.tr,
    'Flutterwave'.tr
  ];

  String selectedStatus = 'Prepared';
  bool haveActionButton = false;
  bool haveDriver = false;
  List<String> ordersStatusList = [
    'Accepted'.tr, // 1
    'Prepared'.tr, // 2
    'Ongoing'.tr, // 3
    'Delivered'.tr, // 4
    'Rejected'.tr, // 6
    'Pending Payments'.tr, // 8
  ];
  String orderActionName = '';
  // auto assign
  // order to home

  OrderDetailsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments[0];
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getOrderDetail();
  }

  Future<void> getOrderDetail() async {
    var param = {"id": orderId};

    Response response = await parser.getOrderDetails(param);
    apiCalled = true;

    if (response.statusCode == 200) {
      _orderInfo = OrdersModel();
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      var userInfo = myMap['userInfo'];
      var driverInfo = myMap['driverInfo'];
      OrdersModel datas = OrdersModel.fromJson(body);
      datas.createdAt = Jiffy(datas.createdAt).yMMMdjm;
      _orderInfo = datas;
      if (orderInfo.status == 4 ||
          orderInfo.status == 5 ||
          orderInfo.status == 6 ||
          orderInfo.status == 7) {
        haveActionButton = false;
        if (orderInfo.status == 4) {
          orderActionName = 'Order Delivered';
        } else if (orderInfo.status == 5) {
          orderActionName = 'Order Cancelled  by User';
        } else if (orderInfo.status == 6) {
          orderActionName = 'Order Rejected By Restaurant';
        } else if (orderInfo.status == 7) {
          orderActionName = 'Order Refunded By Administrator';
        }
      } else {
        haveActionButton = true;
      }
      selectedStatus = AppConstants.orderStatus[orderInfo.status as int];
      UserInfoModel storeData = UserInfoModel.fromJson(userInfo);
      _userInfo = storeData;
      if (orderInfo.orderTo == 0) {
        // order to home
        getDriversNearMe();
      }
      if (driverInfo != null && driverInfo != '') {
        UserInfoModel driverData = UserInfoModel.fromJson(driverInfo);
        _driverInfo = driverData;
        haveDriver = true;
      }
      // if()
      update();
      debugPrint(response.bodyString);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onDriverList() {
    Get.delete<DriverListController>(force: true);
    Get.toNamed(AppRouter.getDriverList());
  }

  Future<void> getDriversNearMe() async {
    Response response = await parser.getDriversNearMe();

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _driverList = [];
      var body = myMap['data'];
      body.forEach((element) {
        DriversModel data = DriversModel.fromJson(element);
        _driverList.add(data);
      });
      // someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
      _driverList.sort((a, b) => a.distance!.compareTo(b.distance!));
      debugPrint(driverList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  // void isDriverInfoStatus(int id) {

  // }

  void onInitialOrderStatus(int number) {
    if (_orderInfo.orderTo == 1) {
      // self pickup
      changeOrderStatus(number);
    } else if (_orderInfo.orderTo == 0 && number == 6) {
      // home delivery and Reject
      changeOrderStatus(number);
    } else if (_orderInfo.orderTo == 0 && number == 1) {
      // home delivery and accecpt
      debugPrint('Select Driver or Auto Select');
      if (parser.getDriverAssignmentType() == 1) {
        debugPrint('Auto assignem');
        if (_driverList.isNotEmpty) {
          int driverId = _driverList[0].id as int;
          assignOrderToDriver(number, driverId);
        } else {
          showToast('No Drivers Near you');
        }
      } else {
        debugPrint('open modal');
        Get.toNamed(AppRouter.getDriverList());
      }
    }
  }

  void saveDriverId(int id) {
    assignOrderToDriver(1, id);
  }

  Future<void> assignOrderToDriver(int status, int driverId) async {
    var param = {"id": orderId, "status": status, "driver_id": driverId};

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

    var response = await parser.updateOrderStatsu(param);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      showToast('Status Updated');
      Get.find<OrderScreenController>().getOrderList();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> changeOrderStatus(int status) async {
    var param = {"id": orderId, "status": status};

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

    var response = await parser.updateOrderStatsu(param);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      showToast('Status Updated');
      Get.find<OrderScreenController>().getOrderList();
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

  void updateOrderStatusNumber(String name) {
    selectedStatus = name;
    update();
  }

  int getStatusNumber(String name) {
    debugPrint(name);
    if (selectedStatus == 'Prepared') {
      return 2;
    } else if (selectedStatus == 'Ongoing') {
      return 3;
    } else if (selectedStatus == 'Delivered') {
      return 4;
    } else if (selectedStatus == 'Accepted') {
      return 1;
    } else {
      return 6;
    }
  }

  Future<void> updateOrderStatus() async {
    debugPrint(getStatusNumber(selectedStatus).toString());
    var param = {"id": orderId, "status": getStatusNumber(selectedStatus)};

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

    var response = await parser.updateOrderStatsu(param);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      showToast('Status Updated');
      Get.find<OrderScreenController>().getOrderList();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void openActionModal(
      String name, String phone, String uid, String type, String email) {
    var context = Get.context as BuildContext;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('${'Contact'.tr} $name'),
        actions: [
          CupertinoActionSheetAction(
            child: Text('Email'.tr),
            onPressed: () {
              Navigator.pop(context);
              composeEmail(email);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Call'.tr),
            onPressed: () {
              Navigator.pop(context);
              makePhoneCall(phone);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Chat'.tr),
            onPressed: () {
              Navigator.pop(context);
              onChat(uid, name);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Cancel'.tr,
              style: const TextStyle(fontFamily: 'bold', color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> composeEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void onChat(String uid, String name) {
    // Get.delete<MessageController>(force: true);
    // Get.toNamed(AppRouter.getMessage(), arguments: [uid, name]);
  }
}
