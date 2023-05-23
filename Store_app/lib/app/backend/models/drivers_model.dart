/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class DriversModel {
  int? id;
  String? firstName;
  String? lastName;
  String? lat;
  String? lng;
  String? cover;
  String? mobile;
  String? email;
  double? distance;

  DriversModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.lat,
      this.lng,
      this.cover,
      this.mobile,
      this.email,
      this.distance});

  DriversModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    firstName = json['first_name'];
    lastName = json['last_name'];
    lat = json['lat'];
    lng = json['lng'];
    cover = json['cover'];
    mobile = json['mobile'];
    email = json['email'];
    distance = double.parse(json['distance'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['lat'] = lat;
    data['lng'] = lng;
    data['cover'] = cover;
    data['mobile'] = mobile;
    data['email'] = email;
    data['distance'] = distance;
    return data;
  }
}
