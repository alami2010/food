/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:get/get.dart';
import 'package:vender/app/backend/api/handler.dart';
import 'package:vender/app/backend/models/products_reviews.dart';
import 'package:vender/app/backend/models/store_reviews_model.dart';
import 'package:vender/app/backend/parse/reviews_parse.dart';

class ReviewsController extends GetxController implements GetxService {
  final ReviewsParse parser;
  bool apiCalled = false;

  List<StoreReviews> _stores = <StoreReviews>[];
  List<StoreReviews> get stores => _stores;

  List<ProductReviews> _products = <ProductReviews>[];
  List<ProductReviews> get products => _products;
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
      _stores = [];
      _products = [];
      dynamic data1 = myMap["data"];
      dynamic data2 = myMap["products"];
      data1.forEach((data) {
        StoreReviews datas = StoreReviews.fromJson(data);
        _stores.add(datas);
      });

      data2.forEach((data) {
        ProductReviews datas = ProductReviews.fromJson(data);
        _products.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
