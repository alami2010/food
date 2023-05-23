/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class AddressModel {
  int? id;
  int? uid;
  int? isDefault;
  String? optionalPhone;
  int? title;
  String? address;
  String? house;
  String? landmark;
  String? pincode;
  String? lat;
  String? lng;
  int? status;
  String? extraField;

  AddressModel(
      {this.id,
      this.uid,
      this.isDefault,
      this.optionalPhone,
      this.title,
      this.address,
      this.house,
      this.landmark,
      this.pincode,
      this.lat,
      this.lng,
      this.status,
      this.extraField});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    isDefault = int.parse(json['is_default'].toString());
    optionalPhone = json['optional_phone'];
    title = int.parse(json['title'].toString());
    address = json['address'];
    house = json['house'];
    landmark = json['landmark'];
    pincode = json['pincode'];
    lat = json['lat'];
    lng = json['lng'];
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['is_default'] = isDefault;
    data['optional_phone'] = optionalPhone;
    data['title'] = title;
    data['address'] = address;
    data['house'] = house;
    data['landmark'] = landmark;
    data['pincode'] = pincode;
    data['lat'] = lat;
    data['lng'] = lng;
    data['status'] = status;
    data['extra_field'] = extraField;
    return data;
  }
}
