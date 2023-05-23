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
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/parse/give_reviews_parse.dart';
import 'package:upgrade/app/util/toast.dart';

class GiveReviewsController extends GetxController implements GetxService {
  final GiveReviewsParser parser;
  String toReview = '';

  int storeId = 0;
  String storeName = '';

  int productId = 0;
  String productName = '';

  int driverId = 0;
  String driverName = '';

  int rate = 2;

  final comment = TextEditingController();

  RxBool isLogin = false.obs;

  String displayName = '';
  bool apiCalled = false;

  String uid = '';

  List<int?> rating = [];
  GiveReviewsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    uid = parser.getUID();
    if (Get.arguments[0] != null) {
      toReview = Get.arguments[0];
      if (toReview == 'store') {
        storeId = Get.arguments[1];
        storeName = Get.arguments[2];
        displayName = Get.arguments[2];
        debugPrint(storeId.toString());
        debugPrint(storeName);
        getStoreReviews();
      }

      if (toReview == 'product') {
        productId = Get.arguments[1];
        productName = Get.arguments[2];
        displayName = Get.arguments[2];
        debugPrint(productId.toString());
        debugPrint(productName);
        getProductRatings();
      }

      if (toReview == 'driver') {
        driverId = Get.arguments[1];
        driverName = Get.arguments[2];
        displayName = Get.arguments[2];
        debugPrint(driverId.toString());
        debugPrint(driverName);
        getDriversRatings();
      }
    } else {
      onBack();
    }
  }

  Future<void> getStoreReviews() async {
    Response response = await parser.getStoreRatings(storeId);
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic reviews = myMap["data"];
      rating = [];
      reviews.forEach((element) {
        rating.add(element['rate']);
      });
      debugPrint(rating.length.toString());
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> getProductRatings() async {
    Response response = await parser.getProductRatings(productId);
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic reviews = myMap["data"];
      rating = [];
      reviews.forEach((element) {
        rating.add(element['rate']);
      });
      debugPrint(rating.length.toString());
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> getDriversRatings() async {
    Response response = await parser.getDriverRatings(driverId);
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic reviews = myMap["data"];
      rating = [];
      reviews.forEach((element) {
        rating.add(element['rate']);
      });
      debugPrint(rating.length.toString());
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void updateRate(int value) {
    rate = value;
    update();
  }

  Future<void> submitData() async {
    if (comment.text == '') {
      showToast('Please add comments');
      return;
    }
    rating.add(rate);
    List<int> ratings = rating.map((e) => e!).cast<int>().toList();
    double sum = ratings.fold(0, (p, c) => p + c);
    if (sum > 0) {
      double average = sum / ratings.length;
      isLogin.value = !isLogin.value;
      update();

      if (toReview == 'store') {
        var param = {
          'uid': uid,
          'product_id': 0,
          'driver_id': 0,
          'store_id': storeId,
          'rate': rate,
          'msg': comment.text,
          'from': 1, // order = 1 // direct = 0
          'status': 1,
          'timestamp': Jiffy().format('yyyy-MM-dd'),
          'total_ratings': rating.length,
          'ratings': average.toStringAsFixed(2)
        };

        debugPrint(param.toString());
        Response response = await parser.saveStoreRating(param);
        if (response.statusCode == 200) {
          isLogin.value = !isLogin.value;
          update();
          successToast('Rating added');
          onBack();
        } else {
          isLogin.value = !isLogin.value;
          ApiChecker.checkApi(response);
          update();
        }
      }

      if (toReview == 'product') {
        var param = {
          'uid': uid,
          'product_id': productId,
          'driver_id': 0,
          'store_id': 0,
          'rate': rate,
          'msg': comment.text,
          'from': 1, // order = 1 // direct = 0
          'status': 1,
          'timestamp': Jiffy().format('yyyy-MM-dd'),
          'total_ratings': rating.length,
          'rating': average.toStringAsFixed(2)
        };

        debugPrint(param.toString());
        Response response = await parser.saveProductRating(param);
        if (response.statusCode == 200) {
          isLogin.value = !isLogin.value;
          update();
          successToast('Rating added');
          onBack();
        } else {
          isLogin.value = !isLogin.value;
          ApiChecker.checkApi(response);
          update();
        }
      }

      if (toReview == 'driver') {
        var param = {
          'uid': uid,
          'product_id': 0,
          'driver_id': driverId,
          'store_id': 0,
          'rate': rate,
          'msg': comment.text,
          'from': 1, // order = 1 // direct = 0
          'status': 1,
          'timestamp': Jiffy().format('yyyy-MM-dd'),
        };

        debugPrint(param.toString());
        Response response = await parser.saveDriversRatings(param);
        if (response.statusCode == 200) {
          isLogin.value = !isLogin.value;
          update();
          successToast('Rating added');
          onBack();
        } else {
          isLogin.value = !isLogin.value;
          ApiChecker.checkApi(response);
          update();
        }
      }
    }
  }
}
