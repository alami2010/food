/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class GeneralModel {
  int? id;
  String? storeName;
  String? mobile;
  String? email;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zip;
  double? freeDelivery;
  double? tax;
  int? shipping;
  double? shippingPrice;
  double? allowDistance;
  double? searchResultKind;
  String? facebookUrl;
  String? instagram;
  String? twitter;
  String? googlePlaystore;
  String? appleAppstore;
  String? webFooter;
  int? status;
  String? extraField;

  GeneralModel(
      {this.id,
      this.storeName,
      this.mobile,
      this.email,
      this.address,
      this.city,
      this.state,
      this.country,
      this.zip,
      this.freeDelivery,
      this.tax,
      this.shipping,
      this.shippingPrice,
      this.allowDistance,
      this.searchResultKind,
      this.facebookUrl,
      this.instagram,
      this.twitter,
      this.googlePlaystore,
      this.appleAppstore,
      this.webFooter,
      this.status,
      this.extraField});

  GeneralModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    storeName = json['store_name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
    freeDelivery = double.parse(json['free_delivery'].toString());
    tax = double.parse(json['tax'].toString());
    shipping = int.parse(json['shipping'].toString());
    shippingPrice = double.parse(json['shippingPrice'].toString());
    allowDistance = double.parse(json['allowDistance'].toString());
    searchResultKind = double.parse(json['searchResultKind'].toString());
    facebookUrl = json['facebook_url'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    googlePlaystore = json['google_playstore'];
    appleAppstore = json['apple_appstore'];
    webFooter = json['web_footer'];
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_name'] = storeName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zip'] = zip;
    data['free_delivery'] = freeDelivery;
    data['tax'] = tax;
    data['shipping'] = shipping;
    data['shippingPrice'] = shippingPrice;
    data['allowDistance'] = allowDistance;
    data['searchResultKind'] = searchResultKind;
    data['facebook_url'] = facebookUrl;
    data['instagram'] = instagram;
    data['twitter'] = twitter;
    data['google_playstore'] = googlePlaystore;
    data['apple_appstore'] = appleAppstore;
    data['web_footer'] = webFooter;
    data['status'] = status;
    data['extra_field'] = extraField;
    return data;
  }
}
