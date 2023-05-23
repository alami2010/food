/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:convert';
import 'package:jiffy/jiffy.dart';
import 'package:driver/app/backend/models/address_model.dart';
import 'package:driver/app/backend/models/product_model.dart';

class OrderModel {
  int? id;
  int? uid;
  int? storeId;
  int? orderTo;
  // String? address;
  AddressModel? address;
  List<Products>? items;
  int? couponId;
  String? coupon;
  int? driverId;
  double? deliveryCharge;
  double? discount;
  double? total;
  double? serviceTax;
  double? grandTotal;
  int? payMethod;
  String? paid;
  String? notes;
  int? status;
  String? extraField;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? userCover;
  String? lastName;
  String? storeName;
  String? storeCover;
  String? storeAddress;

  OrderModel(
      {this.id,
      this.uid,
      this.storeId,
      this.orderTo,
      this.address,
      this.items,
      this.couponId,
      this.coupon,
      this.driverId,
      this.deliveryCharge,
      this.discount,
      this.total,
      this.serviceTax,
      this.grandTotal,
      this.payMethod,
      this.paid,
      this.notes,
      this.status,
      this.extraField,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.userCover,
      this.lastName,
      this.storeName,
      this.storeCover,
      this.storeAddress});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    storeId = int.parse(json['store_id'].toString());
    orderTo = int.parse(json['order_to'].toString());
    // address = json['address'];
    if (json['address'] != null &&
        json['address'] != '' &&
        json['address'] != 'NA' &&
        int.parse(json['order_to'].toString()) == 0) {
      AddressModel addressInfo =
          AddressModel.fromJson(jsonDecode(json['address']));
      address = addressInfo;
    } else {
      address = AddressModel();
    }
    // items = json['items'];
    if (json['items'] != null) {
      items = <Products>[];
      List<dynamic> list = jsonDecode(json['items']);
      for (var element in list) {
        items!.add(Products.fromJson(element));
      }
    } else {
      items = [];
    }
    couponId = int.parse(json['coupon_id'].toString());
    coupon = json['coupon'];
    driverId = int.parse(json['driver_id'].toString());
    deliveryCharge = double.parse(json['delivery_charge'].toString());
    discount = double.parse(json['discount'].toString());
    total = double.parse(json['total'].toString());
    serviceTax = double.parse(json['serviceTax'].toString());
    grandTotal = double.parse(json['grand_total'].toString());
    payMethod = int.parse(json['pay_method'].toString());
    paid = json['paid'];
    notes = json['notes'];
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
    // createdAt = json['created_at'];
    createdAt = Jiffy(json['created_at']).yMMMdjm;
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    userCover = json['user_cover'];
    lastName = json['last_name'];
    storeName = json['store_name'];
    storeCover = json['store_cover'];
    storeAddress = json['store_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['store_id'] = storeId;
    data['order_to'] = orderTo;
    data['address'] = address;
    data['items'] = items;
    data['coupon_id'] = couponId;
    data['coupon'] = coupon;
    data['driver_id'] = driverId;
    data['delivery_charge'] = deliveryCharge;
    data['discount'] = discount;
    data['total'] = total;
    data['serviceTax'] = serviceTax;
    data['grand_total'] = grandTotal;
    data['pay_method'] = payMethod;
    data['paid'] = paid;
    data['notes'] = notes;
    data['status'] = status;
    data['extra_field'] = extraField;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['user_cover'] = userCover;
    data['last_name'] = lastName;
    data['store_name'] = storeName;
    data['store_cover'] = storeCover;
    data['store_address'] = storeAddress;
    return data;
  }
}
