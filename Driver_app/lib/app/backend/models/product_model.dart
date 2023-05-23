/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:convert';

import 'package:driver/app/backend/models/product_variations_model.dart';
import 'package:driver/app/backend/models/variations_model.dart';

class ProductModal {
  String? id;
  String? cover;
  String? name;
  int? fromCate;
  List<Products>? products;
  String? cateId;

  ProductModal(
      {this.id,
      this.cover,
      this.name,
      this.fromCate,
      this.products,
      this.cateId});

  ProductModal.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    cover = json['cover'];
    name = json['name'];
    fromCate = int.parse(json['from_cate'].toString());
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    cateId = json['cate_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cover'] = cover;
    data['name'] = name;
    data['from_cate'] = fromCate;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['cate_id'] = cateId;
    return data;
  }
}

class Products {
  int? id;
  int? storeId;
  int? fromCate;
  int? cateId;
  String? cover;
  String? name;
  String? details;
  double? price;
  double? discount;
  double? rating;
  int? veg;
  List<ProductVariationsModel>? variations;
  int? size;
  int? recommended;
  int? outofstock;
  int? status;
  late int quantity;
  late List<VariationsModel> savedVariationsList;
  String? extraField;

  Products(
      {this.id,
      this.storeId,
      this.fromCate,
      this.cateId,
      this.cover,
      this.name,
      this.details,
      this.price,
      this.discount,
      this.rating,
      this.veg,
      this.variations,
      this.size,
      this.recommended,
      this.outofstock,
      this.status,
      this.extraField,
      this.quantity = 0,
      this.savedVariationsList = const []});

  Products.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    storeId = int.parse(json['store_id'].toString());
    fromCate = int.parse(json['from_cate'].toString());
    cateId = int.parse(json['cate_id'].toString());
    cover = json['cover'];
    name = json['name'];
    details = json['details'];
    price = double.parse(json['price'].toString());
    discount = double.parse(json['discount'].toString());
    rating = double.parse(json['rating'].toString());
    veg = int.parse(json['veg'].toString());
    if (json['variations'] != null &&
        json['variations'] != '' &&
        json['variations'] != 'NA' &&
        json['variations'].runtimeType == String) {
      variations = <ProductVariationsModel>[];
      List<dynamic> list = jsonDecode(json['variations']);
      if (list.isNotEmpty) {
        for (var v in list) {
          if (v['items']?.length > 0) {
            variations!.add(ProductVariationsModel.fromJson(v));
          } else {
            variations = null;
          }
        }
      } else {
        variations = null;
      }
    } else if (json['variations'] != null &&
        json['variations'] != '' &&
        json['variations'] != 'NA' &&
        json['variations'].runtimeType != String &&
        json['variations'].runtimeType == List) {
      variations = <ProductVariationsModel>[];
      List<dynamic> list = json['variations'];
      if (list.isNotEmpty) {
        for (var v in list) {
          if (v['items']?.length > 0) {
            variations!.add(ProductVariationsModel.fromJson(v));
          } else {
            variations = null;
          }
        }
      } else {
        variations = null;
      }
    } else {
      variations = null;
    }
    size = int.parse(json['size'].toString());
    recommended = int.parse(json['recommended'].toString());
    outofstock = int.parse(json['outofstock'].toString());
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
    if (json['quantity'] != null &&
        json['quantity'] != 0 &&
        json['quantity'] != '') {
      quantity = int.parse(json['quantity'].toString());
    } else {
      quantity = 0;
    }

    if (json['savedVariationsList'] != null &&
        json['savedVariationsList'] != '' &&
        json['savedVariationsList'] != 'NA' &&
        json['savedVariationsList'].runtimeType == String) {
      savedVariationsList = <VariationsModel>[];
      List<dynamic> list = jsonDecode(json['savedVariationsList']);
      for (var element in list) {
        savedVariationsList.add(VariationsModel.fromJson(element));
      }
    } else if (json['savedVariationsList'] != null &&
        json['savedVariationsList'] != '' &&
        json['savedVariationsList'] != 'NA' &&
        json['savedVariationsList'].runtimeType != String &&
        json['savedVariationsList'].runtimeType == List) {
      savedVariationsList = <VariationsModel>[];
      List<dynamic> list = json['savedVariationsList'];
      for (var element in list) {
        savedVariationsList.add(VariationsModel.fromJson(element));
      }
    } else {
      savedVariationsList = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_id'] = storeId;
    data['from_cate'] = fromCate;
    data['cate_id'] = cateId;
    data['cover'] = cover;
    data['name'] = name;
    data['details'] = details;
    data['price'] = price;
    data['discount'] = discount;
    data['rating'] = rating;
    data['veg'] = veg;
    if (variations != null) {
      data['variations'] = variations!.map((v) => v.toJson()).toList();
    }
    data['size'] = size;
    data['recommended'] = recommended;
    data['outofstock'] = outofstock;
    data['status'] = status;
    data['extra_field'] = extraField;
    data['quantity'] = quantity;
    if (savedVariationsList.isNotEmpty) {
      data['savedVariationsList'] =
          savedVariationsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
