/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class ComplaintsModel {
  int? id;
  int? uid;
  int? orderId;
  int? issueWith;
  String? driverId;
  int? storeId;
  int? productId;
  int? reasonId;
  String? title;
  String? shortMessage;
  String? images;
  String? extraField;
  int? status;

  ComplaintsModel(
      {this.id,
      this.uid,
      this.orderId,
      this.issueWith,
      this.driverId,
      this.storeId,
      this.productId,
      this.reasonId,
      this.title,
      this.shortMessage,
      this.images,
      this.extraField,
      this.status});

  ComplaintsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    orderId = json['order_id'];
    issueWith = json['issue_with'];
    driverId = json['driver_id'];
    storeId = json['store_id'];
    productId = json['product_id'];
    reasonId = json['reason_id'];
    title = json['title'];
    shortMessage = json['short_message'];
    images = json['images'];
    extraField = json['extra_field'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['order_id'] = orderId;
    data['issue_with'] = issueWith;
    data['driver_id'] = driverId;
    data['store_id'] = storeId;
    data['product_id'] = productId;
    data['reason_id'] = reasonId;
    data['title'] = title;
    data['short_message'] = shortMessage;
    data['images'] = images;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}
