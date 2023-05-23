/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class SavedeVariationsModel {
  String? title;
  double? price;
  String? type;
  int? quantity;
  String? uuid;

  SavedeVariationsModel(
      {this.title, this.price, this.type, this.quantity, this.uuid});

  SavedeVariationsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = double.parse(json['price'].toString());
    type = json['type'];
    quantity = int.parse(json['quantity'].toString());
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['type'] = type;
    data['quantity'] = quantity;
    data['uuid'] = uuid;
    return data;
  }
}
