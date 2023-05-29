/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodies_user/app/backend/api/api.dart';
import 'package:foodies_user/app/backend/models/product_models.dart';
import 'package:foodies_user/app/helper/shared_pref.dart';
import 'package:foodies_user/app/util/constant.dart';

class RestaurantDetailParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  RestaurantDetailParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getStoreData(var body) async {
    var response = await apiService.postPublic(AppConstants.getStoreData, body);
    return response;
  }

  void saveLocalInfo(List<ProductModal> products) {
    debugPrint('on Save');
    List<String> prods = [];
    for (var cartModel in products) {
      prods.add(jsonEncode(cartModel));
    }
    sharedPreferencesManager.putStringList('saveLocalProducts', prods);
  }

  void cleanLocal() {
    sharedPreferencesManager.clearKey('saveLocalProducts');
  }

  List<ProductModal> getLocalProducts() {
    List<String>? products = [];
    if (sharedPreferencesManager.isKeyExists('saveLocalProducts') ?? false) {
      products = sharedPreferencesManager.getStringList('saveLocalProducts');
    }
    List<ProductModal> savedProducts = <ProductModal>[];
    products?.forEach((element) {
      var data = jsonDecode(element);
      savedProducts.add(ProductModal.fromJson(data));
    });
    return savedProducts;
  }

  bool isLoggedIn() {
    return sharedPreferencesManager.getString('uid') != null &&
            sharedPreferencesManager.getString('uid') != ''
        ? true
        : false;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  String getCurrencyCode() {
    return sharedPreferencesManager.getString('currencyCode') ??
        AppConstants.defaultCurrencyCode;
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  Future<Response> myFavList(var body) async {
    var response = await apiService.postPrivate(AppConstants.myFavList, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> addToFavourite(var body) async {
    var response = await apiService.postPrivate(AppConstants.addToFavList, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> removeFromFavList(var body) async {
    var response = await apiService.postPrivate(AppConstants.removeFromFavList,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getName() {
    String firstName = sharedPreferencesManager.getString('first_name') ?? '';
    String lastName = sharedPreferencesManager.getString('last_name') ?? '';
    return '$firstName $lastName';
  }
}
