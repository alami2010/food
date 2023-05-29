/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:jiffy/jiffy.dart';

class TableListModel {
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
  StoreInfo? storeInfo;

  TableListModel(
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
      this.storeInfo});

  TableListModel.fromJson(Map<String, dynamic> json) {
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
    storeInfo = json['storeInfo'] != null
        ? StoreInfo.fromJson(json['storeInfo'])
        : null;
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
    if (storeInfo != null) {
      data['storeInfo'] = storeInfo!.toJson();
    }
    return data;
  }
}

class StoreInfo {
  int? id;
  int? uid;
  int? cityId;
  String? name;
  String? cover;
  String? mobile;
  String? address;
  String? landmark;
  String? pincode;
  String? lat;
  String? lng;
  String? masterCategories;
  int? deliveryType;
  int? pureVeg;
  int? haveDining;
  int? minOrderPrice;
  int? extraCharges;
  String? shortDescriptions;
  String? images;
  int? verified;
  int? status;
  String? openTime;
  String? closeTime;
  int? isClosed;
  String? certificate;
  double? ratings;
  int? totalRatings;
  String? cuisines;
  String? deliveryTime;
  int? costForTwo;
  String? extraField;

  StoreInfo(
      {this.id,
      this.uid,
      this.cityId,
      this.name,
      this.cover,
      this.mobile,
      this.address,
      this.landmark,
      this.pincode,
      this.lat,
      this.lng,
      this.masterCategories,
      this.deliveryType,
      this.pureVeg,
      this.haveDining,
      this.minOrderPrice,
      this.extraCharges,
      this.shortDescriptions,
      this.images,
      this.verified,
      this.status,
      this.openTime,
      this.closeTime,
      this.isClosed,
      this.certificate,
      this.ratings,
      this.totalRatings,
      this.cuisines,
      this.deliveryTime,
      this.costForTwo,
      this.extraField});

  StoreInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    cityId = int.parse(json['city_id'].toString());
    name = json['name'];
    cover = json['cover'];
    mobile = json['mobile'];
    address = json['address'];
    landmark = json['landmark'];
    pincode = json['pincode'];
    lat = json['lat'];
    lng = json['lng'];
    masterCategories = json['master_categories'];
    deliveryType = int.parse(json['delivery_type'].toString());
    pureVeg = int.parse(json['pure_veg'].toString());
    haveDining = int.parse(json['have_dining'].toString());
    minOrderPrice = int.parse(json['min_order_price'].toString());
    extraCharges = int.parse(json['extra_charges'].toString());
    shortDescriptions = json['short_descriptions'];
    images = json['images'];
    verified = int.parse(json['verified'].toString());
    status = int.parse(json['status'].toString());
    openTime = json['open_time'];
    closeTime = json['close_time'];
    isClosed = int.parse(json['is_closed'].toString());
    certificate = json['certificate'];
    ratings = double.parse(json['ratings'].toString());
    totalRatings = int.parse(json['total_ratings'].toString());
    cuisines = json['cuisines'];
    deliveryTime = json['delivery_time'];
    costForTwo = int.parse(json['cost_for_two'].toString());
    extraField = json['extra_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['city_id'] = cityId;
    data['name'] = name;
    data['cover'] = cover;
    data['mobile'] = mobile;
    data['address'] = address;
    data['landmark'] = landmark;
    data['pincode'] = pincode;
    data['lat'] = lat;
    data['lng'] = lng;
    data['master_categories'] = masterCategories;
    data['delivery_type'] = deliveryType;
    data['pure_veg'] = pureVeg;
    data['have_dining'] = haveDining;
    data['min_order_price'] = minOrderPrice;
    data['extra_charges'] = extraCharges;
    data['short_descriptions'] = shortDescriptions;
    data['images'] = images;
    data['verified'] = verified;
    data['status'] = status;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    data['is_closed'] = isClosed;
    data['certificate'] = certificate;
    data['ratings'] = ratings;
    data['total_ratings'] = totalRatings;
    data['cuisines'] = cuisines;
    data['delivery_time'] = deliveryTime;
    data['cost_for_two'] = costForTwo;
    data['extra_field'] = extraField;
    return data;
  }
}
