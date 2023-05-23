/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class RestaurantModal {
  int? id;
  String? name;
  int? uid;
  int? cityId;
  String? cover;
  String? address;
  int? deliveryType;
  int? pureVeg;
  int? haveDining;
  String? images;
  String? openTime;
  String? closeTime;
  int? isClosed;
  double? ratings;
  int? totalRatings;
  String? cuisines;
  String? deliveryTime;
  double? costForTwo;
  double? distance;

  RestaurantModal(
      {this.id,
      this.name,
      this.uid,
      this.cityId,
      this.cover,
      this.address,
      this.deliveryType,
      this.pureVeg,
      this.haveDining,
      this.images,
      this.openTime,
      this.closeTime,
      this.isClosed,
      this.ratings,
      this.totalRatings,
      this.cuisines,
      this.deliveryTime,
      this.costForTwo,
      this.distance});

  RestaurantModal.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    uid = int.parse(json['uid'].toString());
    cityId = int.parse(json['city_id'].toString());
    cover = json['cover'];
    address = json['address'];
    deliveryType = int.parse(json['delivery_type'].toString());
    pureVeg = int.parse(json['pure_veg'].toString());
    haveDining = int.parse(json['have_dining'].toString());
    images = json['images'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    isClosed = int.parse(json['is_closed'].toString());
    ratings = double.parse(json['ratings'].toString());
    totalRatings = int.parse(json['total_ratings'].toString());
    cuisines = json['cuisines'];
    deliveryTime = json['delivery_time'];
    costForTwo = double.parse(json['cost_for_two'].toString());
    distance = double.parse(json['distance'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['uid'] = uid;
    data['city_id'] = cityId;
    data['cover'] = cover;
    data['address'] = address;
    data['delivery_type'] = deliveryType;
    data['pure_veg'] = pureVeg;
    data['have_dining'] = haveDining;
    data['images'] = images;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    data['is_closed'] = isClosed;
    data['ratings'] = ratings;
    data['total_ratings'] = totalRatings;
    data['cuisines'] = cuisines;
    data['delivery_time'] = deliveryTime;
    data['cost_for_two'] = costForTwo;
    data['distance'] = distance;
    return data;
  }
}
