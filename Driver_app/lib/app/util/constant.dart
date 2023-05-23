/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/models/language_model.dart';
import 'package:driver/app/env.dart';

class AppConstants {
  static const String appName = Environments.appName;
  static const String defaultCurrencyCode =
      'USD'; // your currency code in 3 digit
  static const String defaultCurrencySide =
      'right'; // default currency position
  static const String defaultCurrencySymbol = '\$'; // default currency symbol
  static const String defaultLanguageApp = 'en';

  // API Routes
  static const String appSettings = 'api/v1/settings/getDefault';
  static const String login = 'api/v1/auth/login';
  static const String orderList = 'api/v1/orders/getByDriver';
  static const String orderDetail = 'api/v1/orders/getByOrderId';
  static const String updateOrderStatusFromDriver =
      'api/v1/orders/updateFromDriver';
  static const String saveaContacts = 'api/v1/contacts/create';
  static const String sendMailToAdmin = 'api/v1/sendMailToAdmin';
  static const String editProfile = 'api/v1/profile/update';
  static const String uploadImage = 'api/v1/uploadImage';
  static const String getUserProfile = 'api/v1/profile/getByID';
  static const String updateProfile = 'api/v1/profile/update';
  static const String pageContent = 'api/v1/pages/getContent';
  static const String getChatRooms = 'api/v1/chats/getChatRooms';
  static const String createChatRooms = 'api/v1/chats/createChatRooms';
  static const String getChatList = 'api/v1/chats/getById';
  static const String sendMessage = 'api/v1/chats/sendMessage';
  static const String getChatConversionList = 'api/v1/chats/getChatListBUid';
  static const String resetWithEmail = 'api/v1/auth/verifyEmailForReset';
  static const String verifyOTPForReset = 'api/v1/otp/verifyOTPReset';
  static const String updatePasswordWithToken =
      'api/v1/password/updateUserPasswordWithEmail';
  static const String getMyReviews = 'api/v1/ratings/getDriversReviews';
  static const String logout = 'api/v1/auth/logout';
  // API Routes

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: '',
        languageName: 'عربي',
        countryCode: 'AE',
        languageCode: 'ar'),
    LanguageModel(
        imageUrl: '',
        languageName: 'हिन्दी',
        countryCode: 'IN',
        languageCode: 'hi'),
    LanguageModel(
        imageUrl: '',
        languageName: 'Español',
        countryCode: 'De',
        languageCode: 'es'),
  ];

  static List<String> orderStatus = [
    'Created', // 0
    'Accepted', // 1
    'Prepared', // 2
    'Ongoing', // 3
    'Delivered', // 4
    'Cancelled', // 5
    'Rejected', // 6
    'Rejected' // 7
  ];
}
