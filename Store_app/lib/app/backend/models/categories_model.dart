/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class CategoriesModel {
  int? id;
  String? name;
  int? from;
  int? storeId;
  String? cateId;

  CategoriesModel({this.id, this.name, this.from, this.storeId, this.cateId});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    from = json['from'] != null && json['from'] != 'null'
        ? int.parse(json['from'].toString())
        : 0;
    storeId = json['store_id'] != null && json['store_id'] != 'null'
        ? int.parse(json['store_id'].toString())
        : 0;
    cateId = json['cate_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['from'] = from;
    data['store_id'] = storeId;
    data['cate_id'] = cateId;
    return data;
  }
}
