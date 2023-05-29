/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:convert';
import 'package:foodies_user/app/backend/api/api.dart';
import 'package:foodies_user/app/backend/models/product_models.dart';
import 'package:foodies_user/app/helper/shared_pref.dart';
import 'package:foodies_user/app/util/constant.dart';

class MyCartParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  MyCartParse(
      {required this.sharedPreferencesManager, required this.apiService});

  void saveCart(List<Products> products) {
    List<String> carts = [];
    for (var cartModel in products) {
      carts.add(jsonEncode(cartModel));
    }
    sharedPreferencesManager.putStringList('savedCart', carts);
  }

  List<Products> getCartProducts() {
    List<String>? carts = [];

    if (sharedPreferencesManager.isKeyExists('savedCart') ?? false) {
      carts = sharedPreferencesManager.getStringList('savedCart');
    }
    List<Products> cartList = <Products>[];
    carts?.forEach((element) {
      var data = jsonDecode(element);
      data['variations'] =
          data['variations'] != null && data['variations'] != ''
              ? jsonEncode(data['variations'])
              : null;

      data['savedVariationsList'] = data['savedVariationsList'] != null &&
              data['savedVariationsList'] != ''
          ? jsonEncode(data['savedVariationsList'])
          : null;
      cartList.add(Products.fromJson(data));
    });
    return cartList;
  }

  bool isLoggedIn() {
    return sharedPreferencesManager.getString('uid') != null &&
            sharedPreferencesManager.getString('uid') != ''
        ? true
        : false;
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
}
