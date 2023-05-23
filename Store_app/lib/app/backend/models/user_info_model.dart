/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class UserInfoModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  int? gender;
  int? type;
  int? status;
  String? lat;
  String? lng;
  String? cover;
  String? countryCode;
  String? mobile;
  int? verified;
  String? fcmToken;
  String? others;
  String? stripeKey;
  String? extraField;
  String? createdAt;
  String? updatedAt;

  UserInfoModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.gender,
      this.type,
      this.status,
      this.lat,
      this.lng,
      this.cover,
      this.countryCode,
      this.mobile,
      this.verified,
      this.fcmToken,
      this.others,
      this.stripeKey,
      this.extraField,
      this.createdAt,
      this.updatedAt});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = int.parse(json['gender'].toString());
    type = int.parse(json['type'].toString());
    status = int.parse(json['status'].toString());
    lat = json['lat'];
    lng = json['lng'];
    cover = json['cover'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    verified = int.parse(json['verified'].toString());
    fcmToken = json['fcm_token'];
    others = json['others'];
    stripeKey = json['stripe_key'];
    extraField = json['extra_field'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['type'] = type;
    data['status'] = status;
    data['lat'] = lat;
    data['lng'] = lng;
    data['cover'] = cover;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['verified'] = verified;
    data['fcm_token'] = fcmToken;
    data['others'] = others;
    data['stripe_key'] = stripeKey;
    data['extra_field'] = extraField;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
