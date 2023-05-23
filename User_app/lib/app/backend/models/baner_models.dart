/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class BanerModal {
  int? id;
  int? cityId;
  String? cover;
  int? type;
  String? value;
  String? title;
  String? from;
  String? to;
  int? status;
  String? extraField;

  BanerModal(
      {this.id,
      this.cityId,
      this.cover,
      this.type,
      this.value,
      this.title,
      this.from,
      this.to,
      this.status,
      this.extraField});

  BanerModal.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    cityId = int.parse(json['city_id'].toString());
    cover = json['cover'];
    type = int.parse(json['type'].toString());
    value = json['value'];
    title = json['title'];
    from = json['from'];
    to = json['to'];
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_id'] = cityId;
    data['cover'] = cover;
    data['type'] = type;
    data['value'] = value;
    data['title'] = title;
    data['from'] = from;
    data['to'] = to;
    data['status'] = status;
    data['extra_field'] = extraField;
    return data;
  }
}
