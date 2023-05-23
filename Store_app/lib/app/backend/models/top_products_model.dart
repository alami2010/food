/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:vender/app/backend/models/product_model.dart';

class TopProductsModel {
  int? id;
  Products? items;
  int? counts;

  TopProductsModel({this.id, this.items, this.counts});

  TopProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    items = json['items'];
    counts = json['counts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['items'] = items;
    data['counts'] = counts;
    return data;
  }
}
