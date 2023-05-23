/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class FoodDetailsModel {
  int? id;
  int? storeId;
  int? fromCate;
  int? cateId;
  String? cover;
  String? name;
  String? details;
  double? price;
  double? discount;
  double? rating;
  int? veg;
  String? variations;
  int? size;
  int? recommended;
  int? outofstock;
  int? status;
  String? extraField;
  String? cateName;

  FoodDetailsModel(
      {this.id,
      this.storeId,
      this.fromCate,
      this.cateId,
      this.cover,
      this.name,
      this.details,
      this.price,
      this.discount,
      this.rating,
      this.veg,
      this.variations,
      this.size,
      this.recommended,
      this.outofstock,
      this.status,
      this.extraField,
      this.cateName});

  FoodDetailsModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    storeId = int.parse(json['store_id'].toString());
    fromCate = int.parse(json['from_cate'].toString());
    cateId = int.parse(json['cate_id'].toString());
    cover = json['cover'];
    name = json['name'];
    details = json['details'];
    price = double.parse(json['price'].toString());
    discount = double.parse(json['discount'].toString());
    rating = double.parse(json['rating'].toString());
    veg = int.parse(json['veg'].toString());
    variations = json['variations'];
    size = int.parse(json['size'].toString());
    recommended = int.parse(json['recommended'].toString());
    outofstock = int.parse(json['outofstock'].toString());
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
    cateName = json['cate_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_id'] = storeId;
    data['from_cate'] = fromCate;
    data['cate_id'] = cateId;
    data['cover'] = cover;
    data['name'] = name;
    data['details'] = details;
    data['price'] = price;
    data['discount'] = discount;
    data['rating'] = rating;
    data['veg'] = veg;
    data['variations'] = variations;
    data['size'] = size;
    data['recommended'] = recommended;
    data['outofstock'] = outofstock;
    data['status'] = status;
    data['extra_field'] = extraField;
    data['cate_name'] = cateName;
    return data;
  }
}
