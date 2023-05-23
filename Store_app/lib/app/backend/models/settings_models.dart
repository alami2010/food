/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class SettingsModel {
  int? id;
  String? currencySymbol;
  String? currencySide;
  String? currencyCode;
  String? appDirection;
  String? logo;
  String? smsName;
  int? userLogin;
  int? userVerifyWith;
  String? countryModal;
  String? defaultCountryCode;
  String? appColor;
  int? showBooking;
  int? appStatus;
  int? driverAssign;
  int? homePageStyle;
  int? storePageStype;
  int? status;
  String? extraField;

  SettingsModel(
      {this.id,
      this.currencySymbol,
      this.currencySide,
      this.currencyCode,
      this.appDirection,
      this.logo,
      this.smsName,
      this.userLogin,
      this.userVerifyWith,
      this.countryModal,
      this.defaultCountryCode,
      this.appColor,
      this.showBooking,
      this.appStatus,
      this.driverAssign,
      this.homePageStyle,
      this.storePageStype,
      this.status,
      this.extraField});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    currencySymbol = json['currencySymbol'];
    currencySide = json['currencySide'];
    currencyCode = json['currencyCode'];
    appDirection = json['appDirection'];
    logo = json['logo'];
    smsName = json['sms_name'];
    userLogin = int.parse(json['user_login'].toString());
    userVerifyWith = int.parse(json['user_verify_with'].toString());
    countryModal = json['country_modal'];
    defaultCountryCode = json['default_country_code'];
    appColor = json['app_color'];
    showBooking = int.parse(json['show_booking'].toString());
    appStatus = int.parse(json['app_status'].toString());
    driverAssign = int.parse(json['driver_assign'].toString());
    homePageStyle = int.parse(json['home_page_style'].toString());
    storePageStype = int.parse(json['store_page_stype'].toString());
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['currencySymbol'] = currencySymbol;
    data['currencySide'] = currencySide;
    data['currencyCode'] = currencyCode;
    data['appDirection'] = appDirection;
    data['logo'] = logo;
    data['sms_name'] = smsName;
    data['user_login'] = userLogin;
    data['user_verify_with'] = userVerifyWith;
    data['country_modal'] = countryModal;
    data['default_country_code'] = defaultCountryCode;
    data['app_color'] = appColor;
    data['show_booking'] = showBooking;
    data['app_status'] = appStatus;
    data['driver_assign'] = driverAssign;
    data['home_page_style'] = homePageStyle;
    data['store_page_stype'] = storePageStype;
    data['status'] = status;
    data['extra_field'] = extraField;
    return data;
  }
}
