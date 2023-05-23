/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class StatsDataModel {
  double? total;
  int? totalSold;
  String? label;

  StatsDataModel({this.total, this.totalSold, this.label});

  StatsDataModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalSold = json['totalSold'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['totalSold'] = totalSold;
    data['label'] = label;
    return data;
  }
}
