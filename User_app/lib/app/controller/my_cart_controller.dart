/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:upgrade/app/backend/models/product_models.dart';
import 'package:upgrade/app/backend/parse/my_cart_parse.dart';
import 'package:upgrade/app/controller/checkout_controller.dart';
import 'package:upgrade/app/controller/tab_controller.dart';
import 'package:upgrade/app/helper/router.dart';
import 'package:get/get.dart';
import 'package:upgrade/app/util/constant.dart';

class MyCartController extends GetxController implements GetxService {
  final MyCartParse parser;
  List<Products> _savedInCart = <Products>[];
  List<Products> get savedInCart => _savedInCart;

  int _totalItemsInCart = 0;
  int get totalItemsInCart => _totalItemsInCart;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  double _grandTotal = 0.0;
  double get grandTotal => _grandTotal;

  double _walletDiscount = 0.0;
  double get walletDiscount => _walletDiscount;

  double _orderPrice = 0.0;
  double get orderPrice => _orderPrice;

  bool isWalletChecked = false;

  final notesController = TextEditingController();

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  MyCartController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
  }

  void getCart() {
    _savedInCart = [];
    _savedInCart.addAll(parser.getCartProducts());
    Get.find<TabsController>().updateCartValue();
    calcuate();
    update();
  }

  void clearCart() {
    _savedInCart = [];
    _totalPrice = 0.0;
    _grandTotal = 0.0;
    _walletDiscount = 0.0;
    _orderPrice = 0.0;
    _totalItemsInCart = 0;
    parser.saveCart(_savedInCart);
    Get.find<TabsController>().updateCartValue();
    Get.find<TabsController>().cleanData();
    calcuate();
    update();
  }

  void addItem(Products product) {
    _savedInCart.add(product);
    parser.saveCart(_savedInCart);
    calcuate();
    update();
  }

  void calcuate() {
    _totalItemsInCart = 0;
    double total = 0.0;
    for (var element in _savedInCart) {
      _totalItemsInCart = _totalItemsInCart + element.quantity;
      if (element.size == 0) {
        if (element.discount! > 0) {
          total = total + element.discount! * element.quantity;
        } else {
          total = total + element.price! * element.quantity;
        }
      } else if (element.size == 1 && element.savedVariationsList.isNotEmpty) {
        for (var variations in element.savedVariationsList) {
          total = total + variations.price! * element.quantity;
        }
      }
    }
    _totalPrice = double.parse((total).toStringAsFixed(2));
    double totalPrice = _totalPrice;

    _grandTotal = double.parse((totalPrice).toStringAsFixed(2));
    Get.find<TabsController>().updateCartValue();
    debugPrint(total.toString());

    update();
  }

  bool checkProductInCart(int id) {
    return savedInCart
        .where((element) => element.id == id && element.quantity >= 1)
        .isNotEmpty;
  }

  int getQuantity(int id) {
    final index = savedInCart
        .indexWhere((element) => element.id == id && element.quantity >= 1);
    return index >= 0 ? savedInCart[index].quantity : 0;
  }

  List<Products> getSavedVariations(int id) {
    return savedInCart.where((element) => element.id == id).toList();
  }

  void removeProductFromCart(int id) {
    _savedInCart.removeWhere((element) => element.id == id);
    parser.saveCart(_savedInCart);
    update();
    Get.find<TabsController>().updateCartValue();
    calcuate();
  }

  void clearCartFromQauntity() {
    _savedInCart.removeWhere((element) => element.quantity == 0);
    parser.saveCart(_savedInCart);
    update();
    Get.find<TabsController>().updateCartValue();
    calcuate();
  }

  void updateSameProductQuantity(Products product) {
    for (var prod in _savedInCart) {
      for (var element in prod.savedVariationsList) {
        if (prod.id == product.id &&
            element.title == product.savedVariationsList[0].title &&
            element.price == product.savedVariationsList[0].price &&
            element.type == product.savedVariationsList[0].type &&
            element.quantity == product.savedVariationsList[0].quantity &&
            element.uuid == product.savedVariationsList[0].uuid) {
          prod.quantity = product.quantity;
        }
      }
    }
    clearCartFromQauntity();
    calcuate();
    update();
  }

  void addQuantity(Products product) {
    int index = savedInCart.indexWhere((element) => element.id == product.id);
    if (product.quantity <= 0) {
      removeItem(product);
    }
    _savedInCart[index].quantity = product.quantity;
    parser.saveCart(_savedInCart);
    calcuate();
    update();
  }

  void removeItem(Products product) {
    int index = savedInCart.indexWhere((element) => element.id == product.id);
    _savedInCart.removeAt(index);
    parser.saveCart(_savedInCart);
    calcuate();
    update();
  }

  int getSumOfVariations(int id) {
    var item = savedInCart
        .where((element) => element.id == id && element.quantity >= 1);
    int sum = 0;
    for (var element in item) {
      sum = sum + element.quantity;
    }
    return sum;
  }

  void removeItemFromCart(int index) {
    _savedInCart.removeAt(index);
    parser.saveCart(_savedInCart);
    calcuate();
    update();
  }

  void addProductQuantity(int index) {
    _savedInCart[index].quantity = _savedInCart[index].quantity + 1;
    parser.saveCart(_savedInCart);
    update();
    calcuate();
  }

  void removeProductQuantity(int index) {
    if (_savedInCart[index].quantity > 1) {
      _savedInCart[index].quantity = _savedInCart[index].quantity - 1;
      parser.saveCart(_savedInCart);
    } else {
      removeItemFromCart(index);
    }

    update();
    calcuate();
  }

  void onCheckout() {
    Get.delete<CheckoutController>(force: true);
    if (parser.isLoggedIn() == true) {
      debugPrint('Go to Checkout');
      Get.toNamed(AppRouter.getCheckout());
    } else {
      debugPrint('Go to Login');
      Get.toNamed(AppRouter.getLogin());
    }
  }
}
