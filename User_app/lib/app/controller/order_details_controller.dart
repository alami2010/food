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
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/models/orders_model.dart';
import 'package:upgrade/app/backend/models/store_models.dart';
import 'package:upgrade/app/backend/models/user_model.dart';
import 'package:upgrade/app/backend/parse/order_details_parse.dart';
import 'package:get/get.dart';
import 'package:upgrade/app/controller/await_payments_controller.dart';
import 'package:upgrade/app/controller/complaints_controller.dart';
import 'package:upgrade/app/controller/give_reviews_controller.dart';
import 'package:upgrade/app/controller/history_controller.dart';
import 'package:upgrade/app/controller/message_controll.dart';
import 'package:upgrade/app/controller/track_controller.dart';
import 'package:upgrade/app/env.dart';
import 'package:upgrade/app/helper/router.dart';
import 'package:upgrade/app/util/constant.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:upgrade/app/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsController extends GetxController implements GetxService {
  final OrderDetailsParse parser;

  int orderId = 0;
  bool apiCalled = false;

  OrdersModel _orderInfo = OrdersModel();
  OrdersModel get orderInfo => _orderInfo;

  StoreModal _storeInfo = StoreModal();
  StoreModal get storeInfo => _storeInfo;

  UserModel _driverInfo = UserModel();
  UserModel get driverInfo => _driverInfo;

  bool haveDrivers = false;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  String orderActionName = '';
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

  String invoiceURL = '';
  bool isDelivered = false;
  double walletPrice = 0.0;
  OrderDetailsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments[0];
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    invoiceURL =
        '${parser.apiService.appBaseUrl}${AppConstants.getInvoice}$orderId&token=${parser.getToken()}';
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
      var storeIfo = myMap['storeInfo'];
      debugPrint(response.bodyString);
      OrdersModel datas = OrdersModel.fromJson(body);
      _orderInfo = datas;
      debugPrint(body['wallet_price'].toString());
      walletPrice = double.parse(body['wallet_price'].toString());
      if (orderInfo.status == 1) {
        orderActionName = 'Order Accepted';
      } else if (orderInfo.status == 2) {
        orderActionName = 'Order Prepared';
      } else if (orderInfo.status == 3) {
        orderActionName = 'Order Ongoing';
      } else if (orderInfo.status == 4) {
        isDelivered = true;
        orderActionName = 'Order Delivered';
      } else if (orderInfo.status == 5) {
        isDelivered = true;
        orderActionName = 'Order Cancelled';
      } else if (orderInfo.status == 6) {
        isDelivered = true;
        orderActionName = 'Order Rejected By Restaurant';
      } else if (orderInfo.status == 7) {
        isDelivered = true;
        orderActionName = 'Order Refunded By Administrator';
      } else if (orderInfo.status == 8) {
        orderActionName = 'Payment Pending';
      }
      debugPrint('isDelivered' + isDelivered.toString());
      StoreModal storeData = StoreModal.fromJson(storeIfo);
      _storeInfo = storeData;

      if (datas.driverId != 0 && datas.orderTo == 0) {
        haveDrivers = true;
        var driverResponse = myMap['driverInfo'];
        UserModel driverData = UserModel.fromJson(driverResponse);
        _driverInfo = driverData;
        debugPrint(driverInfo.firstName);
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void cancelOrder() {
    Get.defaultDialog(
      title: '',
      contentPadding: const EdgeInsets.all(20),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/sure.png',
              fit: BoxFit.cover,
              height: 80,
              width: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Are you sure'.tr,
              style: const TextStyle(fontSize: 24, fontFamily: 'semi-bold'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('To Cancel this order?'.tr),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      var context = Get.context as BuildContext;
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ThemeProvider.greyColor,
                      onPrimary: ThemeProvider.whiteColor,
                      minimumSize: const Size.fromHeight(35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Cancel'.tr,
                      style: const TextStyle(
                        color: ThemeProvider.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      var context = Get.context as BuildContext;
                      Navigator.pop(context);
                      cancelMyOrder();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ThemeProvider.appColor,
                      onPrimary: ThemeProvider.whiteColor,
                      minimumSize: const Size.fromHeight(35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Yes'.tr,
                      style: const TextStyle(
                        color: ThemeProvider.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> cancelMyOrder() async {
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
    var param = {"id": orderId, "status": 5};

    Response response = await parser.cancelMyOrder(param);
    Get.back();
    if (response.statusCode == 200) {
      showToast('Successfully Updated');
      Get.find<HistoryController>().getOrderList();
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

  void onWebPaymnets() {
    debugPrint('open Web Payments');
    debugPrint(orderInfo.payMethod.toString());
    if (orderInfo.payMethod == 6) {
      debugPrint('instamojo payments');
      payWithInstaMojo();
    } else {
      debugPrint('paytm');
      var paymentURL = 'api/v1/payNowWeb?amount=' +
          orderInfo.grandTotal.toString() +
          '&standby_id=' +
          orderId.toString();
      debugPrint('fullurl' + paymentURL);
      Get.delete<AwaitPaymentsController>(force: true);
      Get.toNamed(AppRouter.getAwaitPaymentsRoutes(),
          arguments: ['paytm', paymentURL]);
    }
  }

  Future<void> payWithInstaMojo() async {
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
    var param = {
      'allow_repeated_payments': 'False',
      'amount': orderInfo.grandTotal,
      'buyer_name': parser.getName(),
      'purpose': 'Orders',
      'redirect_url': parser.apiService.appBaseUrl +
          'api/v1/instaMOJOWebSuccess?id=' +
          orderId.toString(),
      'phone': parser.getPhone() != '' ? parser.getPhone() : '8888888888888888',
      'send_email': 'True',
      'webhook': parser.apiService.appBaseUrl,
      'send_sms': 'True',
      'email': parser.getEmail()
    };
    Response response = await parser.getInstaMojoPayLink(param);
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["success"];
      if (body['payment_request'] != '' &&
          body['payment_request']['longurl'] != '') {
        Get.delete<AwaitPaymentsController>(force: true);
        var paymentURL = body['payment_request']['longurl'];
        Get.toNamed(AppRouter.getAwaitPaymentsRoutes(),
            arguments: ['instamojo', paymentURL]);
      }
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
          type == 'driver'
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

  void trackOrderWithStore() {
    Get.delete<TrackingController>(force: true);
    Get.toNamed(AppRouter.getTrackingRoutes(), arguments: [
      'store', //0
      storeInfo.name, // 1
      storeInfo.address, //2
      storeInfo.cover, // 3
      storeInfo.lat, // 4
      storeInfo.lng, // 5
      storeInfo.mobile, // 6
      orderInfo.grandTotal, // 7
      orderInfo.payMethod.toString() // 8
    ]);
  }

  void trackOrderWithDriver() {
    Get.delete<TrackingController>(force: true);
    Get.toNamed(AppRouter.getTrackingRoutes(), arguments: [
      'driver', // 0
      driverInfo.id, // 1
      '${driverInfo.firstName!} ${driverInfo.lastName}', // 2
      driverInfo.cover, // 3
      driverInfo.lat, // 4
      driverInfo.lng, // 5
      orderInfo.address!.lat, // 6
      orderInfo.address!.lng, // 7
      driverInfo.mobile, // 8
      orderInfo.grandTotal, // 9
      orderInfo.payMethod.toString() // 10
    ]);
  }

  void onChat(String uid, String name) {
    Get.delete<MessageController>(force: true);
    Get.toNamed(AppRouter.getMessage(), arguments: [uid, name]);
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchInBrowser() async {
    var url = Uri.parse(invoiceURL);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  void openHelpModal() {
    var context = Get.context as BuildContext;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Choose'.tr),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text('Chat'.tr),
            onPressed: () {
              Navigator.pop(context);
              onChat(parser.getAdminId().toString(), parser.getAdminName());
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Complaints'.tr),
            onPressed: () {
              Navigator.pop(context);
              Get.delete<ComplaintsController>(force: true);
              Get.toNamed(AppRouter.getComplaintsRoutes(),
                  arguments: [orderId]);
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

  void openRatingModal() {
    var context = Get.context as BuildContext;
    showDialog(
        context: context,
        barrierColor: ThemeProvider.appColor,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(0.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rate Order'.tr,
                  style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 14,
                    ))
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: bottomBorder(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(storeInfo.name.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontFamily: 'bold')),
                          InkWell(
                              onTap: () {
                                Get.delete<GiveReviewsController>(force: true);
                                Get.toNamed(AppRouter.getGiveReviewsRoutes(),
                                    arguments: [
                                      'store',
                                      storeInfo.uid,
                                      storeInfo.name
                                    ]);
                              },
                              child: const Icon(Icons.star_outline,
                                  color: ThemeProvider.orangeColor))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children:
                          List.generate(orderInfo.items!.length, (orderIndex) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.grey.shade300))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  orderInfo.items![orderIndex].veg == 2
                                      ? Image.asset(
                                          'assets/images/non.png',
                                          height: 10,
                                          width: 10,
                                        )
                                      : Image.asset(
                                          'assets/images/veg.png',
                                          height: 10,
                                          width: 10,
                                        ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        orderInfo.items![orderIndex].quantity
                                            .toString(),
                                        style: const TextStyle(
                                            fontFamily: 'bold', fontSize: 12),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text('X',
                                          style: TextStyle(
                                              fontFamily: 'bold',
                                              fontSize: 12)),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        orderInfo.items![orderIndex].name
                                            .toString(),
                                        style: const TextStyle(
                                            fontFamily: 'bold', fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              InkWell(
                                  onTap: () {
                                    debugPrint(orderInfo.items![orderIndex].id
                                        .toString());
                                    Get.delete<GiveReviewsController>(
                                        force: true);
                                    Get.toNamed(
                                        AppRouter.getGiveReviewsRoutes(),
                                        arguments: [
                                          'product',
                                          orderInfo.items![orderIndex].id,
                                          orderInfo.items![orderIndex].name
                                        ]);
                                  },
                                  child: const Icon(
                                    Icons.star_outline,
                                    color: ThemeProvider.orangeColor,
                                  ))
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    orderInfo.orderTo == 0 &&
                            haveDrivers == true &&
                            orderInfo.driverId != 0 &&
                            driverInfo.firstName.toString() != ''
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            decoration: bottomBorder(),
                            child: Text('Rate Driver'.tr, style: boldText()),
                          )
                        : const SizedBox(),
                    orderInfo.orderTo == 0 &&
                            haveDrivers == true &&
                            orderInfo.driverId != 0 &&
                            driverInfo.firstName.toString() != ''
                        ? InkWell(
                            onTap: () {
                              Get.delete<GiveReviewsController>(force: true);
                              Get.toNamed(AppRouter.getGiveReviewsRoutes(),
                                  arguments: [
                                    'driver',
                                    driverInfo.id,
                                    '${driverInfo.firstName} ${driverInfo.lastName}'
                                  ]);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(30),
                                      child: FadeInImage(
                                        image: NetworkImage(
                                            '${Environments.apiBaseURL}storage/images/${driverInfo.cover}'),
                                        placeholder: const AssetImage(
                                            "assets/images/error.png"),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              'assets/images/error.png',
                                              fit: BoxFit.fitWidth);
                                        },
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${driverInfo.firstName} ${driverInfo.lastName}',
                                          style: boldText(),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            const Icon(Icons.mail, size: 17),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(driverInfo.email.toString()),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            const Icon(Icons.call, size: 17),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(driverInfo.mobile.toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          );
        });
  }

  boldText() {
    return const TextStyle(fontSize: 14, fontFamily: 'bold');
  }

  bottomBorder() {
    return BoxDecoration(
        border: Border(
            bottom:
                BorderSide(width: 1, color: ThemeProvider.greyColor.shade300)));
  }
}
