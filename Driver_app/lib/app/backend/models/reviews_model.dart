/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:jiffy/jiffy.dart';

class ReviewsModel {
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

  ReviewsModel(
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
      this.cover});

  ReviewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    productId = json['product_id'];
    storeId = json['store_id'];
    driverId = json['driver_id'];
    rate = json['rate'];
    msg = json['msg'];
    from = json['from'];
    status = json['status'];
    extraField = json['extra_field'];
    createdAt = Jiffy(json['created_at']).yMMMdjm;
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    cover = json['cover'];
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
    return data;
  }
}
