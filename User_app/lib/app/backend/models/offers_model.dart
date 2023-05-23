/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class OffersModel {
  int? id;
  String? name;
  String? shortDescriptions;
  String? code;
  int? type;
  double? discount;
  double? upto;
  String? expire;
  String? storeIds;
  int? maxUsage;
  double? minCartValue;
  int? validations;
  int? userLimitValidation;
  String? extraField;
  int? status;

  OffersModel(
      {this.id,
      this.name,
      this.shortDescriptions,
      this.code,
      this.type,
      this.discount,
      this.upto,
      this.expire,
      this.storeIds,
      this.maxUsage,
      this.minCartValue,
      this.validations,
      this.userLimitValidation,
      this.extraField,
      this.status});

  OffersModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    shortDescriptions = json['short_descriptions'];
    code = json['code'];
    type = int.parse(json['type'].toString());
    discount = double.parse(json['discount'].toString());
    upto = double.parse(json['upto'].toString());
    expire = json['expire'];
    storeIds = json['store_ids'];
    maxUsage = int.parse(json['max_usage'].toString());
    minCartValue = double.parse(json['min_cart_value'].toString());
    validations = int.parse(json['validations'].toString());
    userLimitValidation = int.parse(json['user_limit_validation'].toString());
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['short_descriptions'] = shortDescriptions;
    data['code'] = code;
    data['type'] = type;
    data['discount'] = discount;
    data['upto'] = upto;
    data['expire'] = expire;
    data['store_ids'] = storeIds;
    data['max_usage'] = maxUsage;
    data['min_cart_value'] = minCartValue;
    data['validations'] = validations;
    data['user_limit_validation'] = userLimitValidation;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}
