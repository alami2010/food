/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/api/handler.dart';
import 'package:driver/app/backend/models/reviews_model.dart';
import 'package:driver/app/backend/parse/reviews_parse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsController extends GetxController implements GetxService {
  final ReviewsParse parser;
  bool apiCalled = false;
  List<ReviewsModel> _reviews = <ReviewsModel>[];
  List<ReviewsModel> get reviews => _reviews;
  ReviewsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getMyReviews();
  }

  Future<void> getMyReviews() async {
    Response response = await parser.getMyReviews();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _reviews = [];
      body.forEach((element) {
        ReviewsModel data = ReviewsModel.fromJson(element);
        _reviews.add(data);
      });
      debugPrint(reviews.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
