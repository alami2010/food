/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/api/handler.dart';
import 'package:driver/app/backend/models/orders_model.dart';
import 'package:driver/app/backend/models/store_info_model.dart';
import 'package:driver/app/backend/models/user_model.dart';
import 'package:driver/app/backend/parse/order_detail_parse.dart';
import 'package:driver/app/controller/message_controll.dart';
import 'package:driver/app/controller/order_screen_controller.dart';
import 'package:driver/app/controller/tracking_controller.dart';
import 'package:driver/app/helper/router.dart';
import 'package:driver/app/util/constant.dart';
import 'package:driver/app/util/theme.dart';
import 'package:driver/app/util/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailController extends GetxController implements GetxService {
  final OrderDetailParse parser;

  int orderId = 0;

  OrderModel _orderInfo = OrderModel();
  OrderModel get orderInfo => _orderInfo;

  StoreInfoModel _storeInfo = StoreInfoModel();
  StoreInfoModel get storeInfo => _storeInfo;

  UserModel _userInfo = UserModel();
  UserModel get userInfo => _userInfo;
  bool apiCalled = false;
  String selectedStatus = 'Ongoing';
  bool haveActionButton = false;
  String orderActionName = '';

  List<String> ordersStatusList = [
    'Accepted'.tr, // 1
    'Prepared'.tr, // 2
    'Ongoing'.tr, // 3
    'Delivered'.tr, // 4
  ];

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

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  OrderDetailController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    orderId = Get.arguments[0];
    getOrderDetail();
  }

  Future<void> getOrderDetail() async {
    var param = {"id": orderId};

    Response response = await parser.getOrderDetails(param);
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      _orderInfo = OrderModel();
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      var store = myMap['storeInfo'];
      var user = myMap['userInfo'];

      OrderModel datas = OrderModel.fromJson(body);
      _orderInfo = datas;

      StoreInfoModel info = StoreInfoModel.fromJson(store);
      _storeInfo = info;

      UserModel exe = UserModel.fromJson(user);
      _userInfo = exe;

      if (orderInfo.status == 4) {
        haveActionButton = false;
        if (orderInfo.status == 4) {
          orderActionName = 'Order Delivered';
        }
      } else {
        haveActionButton = true;
      }
      selectedStatus = AppConstants.orderStatus[orderInfo.status as int];

      update();
      debugPrint(response.bodyString);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateOrderStatusNumber(String name) {
    selectedStatus = name;
    update();
  }

  int getStatusNumber(String name) {
    debugPrint(name);
    if (selectedStatus == 'Ongoing') {
      return 3;
    } else {
      return 4;
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

    var response = await parser.updateOrderStatus(param);
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

  void openTrackingFromUser() {
    debugPrint('open user tracking');
    Get.delete<TrackingController>(force: true);
    Get.toNamed(AppRouter.getTrackingRoutes(), arguments: [
      'user', // 0
      orderInfo.address!.lat.toString(), // 1
      orderInfo.address!.lng.toString(), // 2
      userInfo.cover != null && userInfo.cover!.isNotEmpty
          ? userInfo.cover
          : '', // 3
      '${userInfo.firstName} ${userInfo.lastName}', // 4
      userInfo.mobile, // 5
      '${orderInfo.address!.landmark} ${orderInfo.address!.house} ${orderInfo.address!.address} ${orderInfo.address!.pincode}', // 6
      orderInfo.grandTotal.toString(), // 7
      orderInfo.payMethod.toString() // 8
    ]);
  }

  void openTrackingFromStore() {
    debugPrint('open store tracking');
    Get.delete<TrackingController>(force: true);
    Get.toNamed(AppRouter.getTrackingRoutes(), arguments: [
      'store', // 0
      storeInfo.lat.toString(), // 1
      storeInfo.lng.toString(), // 2
      storeInfo.cover, // 3
      storeInfo.name, // 4
      storeInfo.mobile, // 5
      storeInfo.address, // 6
      orderInfo.grandTotal.toString(), // 7
      orderInfo.payMethod.toString() // 8
    ]);
  }

  void openActionModal(
      String name, String phone, String uid, String type, String email) {
    var context = Get.context as BuildContext;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('${'Contact'.tr} $name'),
        actions: [
          type == 'user'
              ? CupertinoActionSheetAction(
                  child: Text('Email'.tr),
                  onPressed: () {
                    Navigator.pop(context);
                    composeEmail(email);
                  },
                )
              : const SizedBox(),
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
    Get.delete<MessageController>(force: true);
    Get.toNamed(AppRouter.getMessage(), arguments: [uid, name]);
  }
}
