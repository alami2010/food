/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:vender/app/backend/models/orders_model.dart';

class StatsChartModel {
  String? date;
  List<OrdersModel>? sells;
  double? totalSell;

  StatsChartModel({this.date, this.sells, this.totalSell});

  StatsChartModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sells = json['sells'];
    totalSell = json['totalSell'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['sells'] = sells;
    data['totalSell'] = totalSell;
    return data;
  }
}
