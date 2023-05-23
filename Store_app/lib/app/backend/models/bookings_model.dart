/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:jiffy/jiffy.dart';

class BookingsModel {
  int? id;
  int? uid;
  int? storeId;
  int? totalGuest;
  String? guestName;
  String? mobile;
  String? email;
  String? notes;
  String? savedDate;
  int? slot;
  int? status;
  String? extraField;
  UserInfo? userInfo;

  BookingsModel(
      {this.id,
      this.uid,
      this.storeId,
      this.totalGuest,
      this.guestName,
      this.mobile,
      this.email,
      this.notes,
      this.savedDate,
      this.slot,
      this.status,
      this.extraField,
      this.userInfo});

  BookingsModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    storeId = int.parse(json['store_id'].toString());
    totalGuest = int.parse(json['total_guest'].toString());
    guestName = json['guest_name'];
    mobile = json['mobile'];
    email = json['email'];
    notes = json['notes'];
    savedDate = Jiffy(json['saved_date']).yMMMdjm;
    slot = int.parse(json['slot'].toString());
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
    userInfo =
        json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['store_id'] = storeId;
    data['total_guest'] = totalGuest;
    data['guest_name'] = guestName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['notes'] = notes;
    data['saved_date'] = savedDate;
    data['slot'] = slot;
    data['status'] = status;
    data['extra_field'] = extraField;
    if (userInfo != null) {
      data['userInfo'] = userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
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

  UserInfo(
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

  UserInfo.fromJson(Map<String, dynamic> json) {
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
    createdAt = Jiffy(json['created_at']).yMMMdjm;
    // createdAt = json['created_at'];
    updatedAt = Jiffy(json['updated_at']).yMMMdjm;
    // savedDate = json['updated_at'];
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
