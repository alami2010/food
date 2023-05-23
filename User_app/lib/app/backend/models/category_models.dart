/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class CategoryModel {
  int? id;
  String? name;
  String? cover;
  int? kind;
  int? status;
  String? extraField;

  CategoryModel(
      {this.id,
      this.name,
      this.cover,
      this.kind,
      this.status,
      this.extraField});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    cover = json['cover'];
    kind = int.parse(json['kind'].toString());
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['kind'] = kind;
    data['status'] = status;
    data['extra_field'] = extraField;
    return data;
  }
}
