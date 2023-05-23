/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class StoreModel {
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
  double? minOrderPrice;
  double? extraCharges;
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
  double? costForTwo;
  String? extraField;

  StoreModel(
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

  StoreModel.fromJson(Map<String, dynamic> json) {
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
    minOrderPrice = double.parse(json['min_order_price'].toString());
    extraCharges = double.parse(json['extra_charges'].toString());
    shortDescriptions = json['short_descriptions'];
    images = json['images'];
    verified = json['verified'];
    status = int.parse(json['status'].toString());
    openTime = json['open_time'];
    closeTime = json['close_time'];
    isClosed = json['is_closed'];
    certificate = json['certificate'];
    ratings = double.parse(json['ratings'].toString());
    totalRatings = int.parse(json['total_ratings'].toString());
    cuisines = json['cuisines'];
    deliveryTime = json['delivery_time'];
    costForTwo = double.parse(json['cost_for_two'].toString());
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
