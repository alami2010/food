/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/api/api.dart';
import 'package:driver/app/helper/shared_pref.dart';
import 'package:driver/app/util/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class EditProfileParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  EditProfileParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> uploadImage(XFile data) async {
    return await apiService
        .uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  Future<Response> getProfile() async {
    return await apiService.postPrivate(
        AppConstants.getUserProfile,
        {'id': sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> updateProfile(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateProfile,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  void saveInfo(String firstName, String lastName, String cover, String phone) {
    sharedPreferencesManager.putString('first_name', firstName);
    sharedPreferencesManager.putString('last_name', lastName);
    sharedPreferencesManager.putString('cover', cover);
    sharedPreferencesManager.putString('phone', phone);
  }
}
