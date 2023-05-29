/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:foodies_user/app/backend/parse/deals_parse.dart';
import 'package:get/get.dart';

class DealsController extends GetxController implements GetxService {
  final DealsParse parser;

  DealsController({required this.parser});
}
