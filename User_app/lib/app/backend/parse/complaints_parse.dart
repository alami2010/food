/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodies_user/app/backend/api/api.dart';
import 'package:foodies_user/app/helper/shared_pref.dart';
import 'package:foodies_user/app/util/constant.dart';

class ComplaintsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ComplaintsParser(
      {required this.apiService, required this.sharedPreferencesManager});

  Future<Response> getOrderDetails(var id) async {
    return await apiService.postPrivate(AppConstants.getOrderDetails,
        {'id': id}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> uploadImage(XFile data) async {
    return await apiService
        .uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  Future<Response> registerComplaints(var param) async {
    return await apiService.postPrivate(AppConstants.registerComplaints, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }
}
