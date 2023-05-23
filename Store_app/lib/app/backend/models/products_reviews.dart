/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:jiffy/jiffy.dart';

class ProductReviews {
  int? id;
  int? uid;
  int? productId;
  int? storeId;
  int? driverId;
  int? rate;
  String? msg;
  int? from;
  int? status;
  String? extraField;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? cover;
  String? productName;
  String? productCover;

  ProductReviews(
      {this.id,
      this.uid,
      this.productId,
      this.storeId,
      this.driverId,
      this.rate,
      this.msg,
      this.from,
      this.status,
      this.extraField,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName,
      this.cover,
      this.productName,
      this.productCover});

  ProductReviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    productId = int.parse(json['product_id'].toString());
    storeId = int.parse(json['store_id'].toString());
    driverId = int.parse(json['driver_id'].toString());
    rate = int.parse(json['rate'].toString());
    msg = json['msg'];
    from = int.parse(json['from'].toString());
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
    createdAt = Jiffy(json['created_at']).yMMMdjm;
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    cover = json['cover'];
    productName = json['product_name'];
    productCover = json['product_cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['product_id'] = productId;
    data['store_id'] = storeId;
    data['driver_id'] = driverId;
    data['rate'] = rate;
    data['msg'] = msg;
    data['from'] = from;
    data['status'] = status;
    data['extra_field'] = extraField;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['cover'] = cover;
    data['product_name'] = productName;
    data['product_cover'] = productCover;
    return data;
  }
}
