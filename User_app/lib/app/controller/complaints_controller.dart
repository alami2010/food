/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/models/issuewith_model.dart';
import 'package:upgrade/app/backend/models/orders_model.dart';
import 'package:upgrade/app/backend/models/store_models.dart';
import 'package:upgrade/app/backend/models/user_model.dart';
import 'package:upgrade/app/backend/parse/complaints_parse.dart';
import 'package:upgrade/app/util/theme.dart';
import 'package:upgrade/app/util/toast.dart';

class ComplaintsController extends GetxController implements GetxService {
  final ComplaintsParser parser;
  String orderId = '';
  bool apiCalled = false;
  RxBool isLogin = false.obs;
  List<IssueItemsModel> _issueWithList = <IssueItemsModel>[];
  List<IssueItemsModel> get issueWithList => _issueWithList;

  List<StoreModal> _stores = <StoreModal>[];
  List<StoreModal> get stores => _stores;

  OrdersModel _details = OrdersModel();
  OrdersModel get details => _details;

  List<UserModel> _driversList = <UserModel>[];
  List<UserModel> get driversList => _driversList;

  XFile? _selectedImage;

  List<String> reasonList = [
    'The product arrived too late'.tr,
    'The product did not match the description'.tr,
    'The purchase was fraudulent'.tr,
    'The product was damaged or defective'.tr,
    'The merchant shipped the wrong item'.tr,
    'Wrong Item Size or Wrong Product Shipped'.tr,
    'Driver arrived too late'.tr,
    'Driver behavior'.tr,
    'Store Vendors behavior'.tr,
    'Issue with Payment Amount'.tr,
    'Others'.tr,
  ];
  String issueWith = '1';
  String issueWithText = 'Order';

  String storeID = '';
  String storeName = '';

  String selectedReason = '';

  String productId = '';
  String productName = '';

  String driverId = '';
  String driverName = '';

  final title = TextEditingController();
  final comments = TextEditingController();

  List<String> savedImages = [''];

  ComplaintsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments[0].toString();
    getOrderDetails();
  }

  Future<void> getOrderDetails() async {
    Response response = await parser.getOrderDetails(orderId);
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic orderInfo = myMap["data"];
      OrdersModel orderData = OrdersModel.fromJson(orderInfo);
      _details = orderData;
      dynamic driverInfo = myMap['driverInfo'];
      dynamic storeInfo = myMap["storeInfo"];
      if (storeInfo != null) {
        _stores = [];
        StoreModal _storeDatas = StoreModal.fromJson(storeInfo);
        _stores.add(_storeDatas);
      }
      for (var item in details.items!) {
        var storeName =
            stores.firstWhere((element) => element.uid == item.storeId).name;
        item.name = '${item.name!} -  $storeName';
      }

      _issueWithList = [];
      if (driverInfo != null && driverInfo != '') {
        var orderParam = {"id": 1, "name": "Order".tr};
        _issueWithList.add(IssueItemsModel.fromJson(orderParam));

        var storeParam = {"id": 2, "name": "Store".tr};
        _issueWithList.add(IssueItemsModel.fromJson(storeParam));

        var driverParam = {"id": 3, "name": "Driver".tr};
        _issueWithList.add(IssueItemsModel.fromJson(driverParam));

        var productParam = {"id": 4, "name": "Product".tr};
        _issueWithList.add(IssueItemsModel.fromJson(productParam));
        _driversList = [];
        if (driverInfo.length > 0) {
          UserModel _driverDatas = UserModel.fromJson(driverInfo);
          _driversList.add(_driverDatas);
          // driverInfo.forEach((element) {
          //   UsersModel driverData = UsersModel.fromJson(element);
          //   _driversList.add(driverData);
          // });
        }
        debugPrint(_driversList.length.toString());
      } else {
        var orderParam = {"id": 1, "name": "Order".tr};
        _issueWithList.add(IssueItemsModel.fromJson(orderParam));

        var storeParam = {"id": 2, "name": "Store".tr};
        _issueWithList.add(IssueItemsModel.fromJson(storeParam));

        var productParam = {"id": 4, "name": "Product".tr};
        _issueWithList.add(IssueItemsModel.fromJson(productParam));
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> onIssueModal() async {
    var context = Get.context as BuildContext;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'Choose Issue With'.tr,
              style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
              textAlign: TextAlign.center,
            ),
            content: Column(
              children: [
                SizedBox(
                  height: 200.0, // Change as per your requirement
                  width: 300.0, // Change as per your requirement
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: issueWithList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Color getColor(Set<MaterialState> states) {
                          return ThemeProvider.appColor;
                        }

                        return ListTile(
                          textColor: ThemeProvider.appColor,
                          iconColor: ThemeProvider.appColor,
                          title: Text(issueWithList[index].name.toString()),
                          leading: Radio(
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: issueWithList[index].id.toString(),
                              groupValue: issueWith,
                              onChanged: (e) {
                                issueWith = e.toString();
                                var selected = issueWithList
                                    .firstWhere((element) =>
                                        element.id.toString() == issueWith)
                                    .name;
                                issueWithText = selected!;
                                update();
                                Navigator.pop(context);
                              }),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> onStoreModal() async {
    var context = Get.context as BuildContext;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'Choose Store'.tr,
              style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
              textAlign: TextAlign.center,
            ),
            content: Column(
              children: [
                SizedBox(
                  height: 200.0, // Change as per your requirement
                  width: 300.0, // Change as per your requirement
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: stores.length,
                      itemBuilder: (BuildContext context, int index) {
                        Color getColor(Set<MaterialState> states) {
                          return ThemeProvider.appColor;
                        }

                        return ListTile(
                          textColor: ThemeProvider.appColor,
                          iconColor: ThemeProvider.appColor,
                          title: Text(stores[index].name.toString()),
                          leading: Radio(
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: stores[index].uid.toString(),
                              groupValue: storeID,
                              onChanged: (e) {
                                storeID = e.toString();
                                var selected = stores
                                    .firstWhere((element) =>
                                        element.uid.toString() == storeID)
                                    .name;
                                storeName = selected!;
                                update();
                                Navigator.pop(context);
                              }),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> onDriverModal() async {
    var context = Get.context as BuildContext;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'Choose Driver'.tr,
              style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
              textAlign: TextAlign.center,
            ),
            content: Column(
              children: [
                SizedBox(
                  height: 200.0, // Change as per your requirement
                  width: 300.0, // Change as per your requirement
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: driversList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Color getColor(Set<MaterialState> states) {
                          return ThemeProvider.appColor;
                        }

                        return ListTile(
                          textColor: ThemeProvider.appColor,
                          iconColor: ThemeProvider.appColor,
                          title: Text(
                              '${driversList[index].firstName} ${driversList[index].lastName}'),
                          leading: Radio(
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: driversList[index].id.toString(),
                              groupValue: driverId,
                              onChanged: (e) {
                                driverId = e.toString();
                                var selected = driversList.firstWhere(
                                    (element) =>
                                        element.id.toString() == driverId);
                                driverName =
                                    '${selected.firstName} ${selected.lastName}';
                                update();
                                Navigator.pop(context);
                              }),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> onReasonModal() async {
    var context = Get.context as BuildContext;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'Choose Reason'.tr,
              style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
              textAlign: TextAlign.center,
            ),
            content: Column(
              children: [
                SizedBox(
                  height: 200.0, // Change as per your requirement
                  width: 300.0, // Change as per your requirement
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: reasonList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Color getColor(Set<MaterialState> states) {
                          return ThemeProvider.appColor;
                        }

                        return ListTile(
                          textColor: ThemeProvider.appColor,
                          iconColor: ThemeProvider.appColor,
                          title: Text(reasonList[index].toString()),
                          leading: Radio(
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: reasonList[index].toString(),
                              groupValue: selectedReason,
                              onChanged: (e) {
                                selectedReason = e.toString();
                                update();
                                Navigator.pop(context);
                              }),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> onProductModal() async {
    var context = Get.context as BuildContext;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'Choose Product'.tr,
              style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
              textAlign: TextAlign.center,
            ),
            content: Column(
              children: [
                SizedBox(
                  height: 200.0, // Change as per your requirement
                  width: 300.0, // Change as per your requirement
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: details.items!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Color getColor(Set<MaterialState> states) {
                          return ThemeProvider.appColor;
                        }

                        return ListTile(
                          textColor: ThemeProvider.appColor,
                          iconColor: ThemeProvider.appColor,
                          title: Text(details.items![index].name.toString()),
                          leading: Radio(
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: details.items![index].id.toString(),
                              groupValue: productId,
                              onChanged: (e) {
                                productId = e.toString();
                                productName = details.items!
                                    .firstWhere((element) =>
                                        element.id.toString() == productId)
                                    .name
                                    .toString();
                                update();
                                Navigator.pop(context);
                              }),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> onImageModal() async {
    var context = Get.context as BuildContext;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Choose From'.tr),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text('Gallery'.tr),
            onPressed: () {
              Navigator.pop(context);
              selectFromGallery('gallery');
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'.tr),
            onPressed: () {
              Navigator.pop(context);
              selectFromGallery('camera');
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

  void selectFromGallery(String kind) async {
    _selectedImage = await ImagePicker().pickImage(
        source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 25);
    update();
    if (_selectedImage != null) {
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
      Response response = await parser.uploadImage(_selectedImage as XFile);
      Get.back();
      if (response.statusCode == 200) {
        _selectedImage = null;
        if (response.body['data'] != null && response.body['data'] != '') {
          dynamic body = response.body["data"];
          if (body['image_name'] != null && body['image_name'] != '') {
            savedImages.add(body['image_name']);
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  Future<void> onSubmit() async {
    if (issueWith != '' &&
        selectedReason != '' &&
        title.text != '' &&
        comments.text != '') {
      if (issueWith == '1' && storeID != '') {
        callAPI();
      } else if (issueWith == '2' && storeID != '') {
        callAPI();
      } else if (issueWith == '4' && productId != '') {
        callAPI();
      } else if (issueWith == '3' && driverId != '') {
        callAPI();
      }
    } else {
      showToast('All fields are required'.tr);
    }
  }

  Future<void> callAPI() async {
    var reasonIndex = reasonList.indexOf(selectedReason);
    var param = {
      'uid': parser.getUID(),
      'order_id': orderId,
      'issue_with': issueWith,
      'driver_id': driverId,
      'store_id': storeID,
      'product_id': productId != '' ? productId : 0,
      'reason_id': reasonIndex,
      'title': title.text,
      'short_message': comments.text,
      'status': 0,
      'images': jsonEncode(savedImages)
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
        barrierDismissible: false);
    Response response = await parser.registerComplaints(param);
    isLogin.value = !isLogin.value;
    update();
    Get.back();
    if (response.statusCode == 200) {
      successToast('Complaints registered'.tr);
      onBack();
    } else {
      isLogin.value = !isLogin.value;
      ApiChecker.checkApi(response);
      update();
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
