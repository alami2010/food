import 'package:image_picker/image_picker.dart';
/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:vender/app/backend/api/api.dart';
import 'package:vender/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:vender/app/util/constant.dart';

class EditProfileParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  EditProfileParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getInfo() async {
    var response = await apiService.postPrivate(
        AppConstants.getStoreInfo,
        {'id': sharedPreferencesManager.getString('uid') ?? ''},
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateData(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateStoreInfo,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> uploadImage(XFile data) async {
    return await apiService
        .uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  void saveInfo(String name, String address, String opentime, String closetime,
      String cover, String lat, String lng) {
    sharedPreferencesManager.putString('name', name);
    sharedPreferencesManager.putString('address', address);
    sharedPreferencesManager.putString('opentime', opentime);
    sharedPreferencesManager.putString('closetime', closetime);
    sharedPreferencesManager.putString('cover', cover);
    sharedPreferencesManager.putString('store_lat', lat);
    sharedPreferencesManager.putString('store_lng', lng);
  }
}
