/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class VariationsModel {
  bool? isSize;
  String? title;
  String? type;
  List<Items>? items;

  VariationsModel({this.isSize, this.title, this.type, this.items});

  VariationsModel.fromJson(Map<String, dynamic> json) {
    isSize = json['isSize'];
    title = json['title'];
    type = json['type'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSize'] = isSize;
    data['title'] = title;
    data['type'] = type;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? title;
  double? price;

  Items({this.title, this.price});

  Items.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    return data;
  }
}
