/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:vender/app/backend/models/language_model.dart';
import 'package:vender/app/env.dart';

class AppConstants {
  static const String appName = Environments.appName;
  static const int defaultDriverAssignment = 2; // manully assign
  static const String defaultCurrencyCode =
      'USD'; // your currency code in 3 digit
  static const String defaultCurrencySide =
      'right'; // default currency position
  static const String defaultCurrencySymbol = '\$'; // default currency symbol
  static const String defaultLanguageApp = 'en';

  // API Routes
  static const String appSettings = 'api/v1/settings/getDefault';
  static const String login = 'api/v1/auth/store_login';
  static const String category = 'api/v1/categories/getList';
  static const String status = 'api/v1/storeCates/updateStatus';
  static const String delete = 'api/v1/storeCates/delete';
  static const String adminCategory = 'api/v1/categories/updateCategories';
  static const String masterCategory = 'api/v1/categories/get';
  static const String updateMaster = 'api/v1/categories/updateCategories';
  static const String uploadImage = 'api/v1/uploadImage';
  static const String createStore = 'api/v1/storeCates/create';
  static const String storeGetById = 'api/v1/storeCates/getById';
  static const String updateStoreCategory = 'api/v1/storeCates/updateInfo';
  static const String saveFood = 'api/v1/foods/save';
  static const String getFoodList = 'api/v1/foods/stores';
  static const String getProductInfo = 'api/v1/foods/getProductInfo';
  static const String updateFood = 'api/v1/foods/update';
  static const String getOrders = 'api/v1/orders/getByStore';
  static const String getOrderDetail = 'api/v1/orders/getOrderByIdForStore';
  static const String getNearDrivers = 'api/v1/drivers/getDriversNearStore';
  static const String changeOrderStatus = 'api/v1/orders/updateFromStore';
  static const String getBookings = 'api/v1/table_booking/getBookingsByStore';
  static const String updateBookingInfo =
      'api/v1/table_booking/updateBookingInfo';
  static const String getStoreInfo = 'api/v1/store/getStoreInfo';
  static const String updateStoreInfo = 'api/v1/store/updateData';
  static const String saveaContacts = 'api/v1/contacts/create';
  static const String sendMailToAdmin = 'api/v1/sendMailToAdmin';
  static const String pageContent = 'api/v1/pages/getContent';
  static const String getStoreStats = 'api/v1/orders/getStoreStatsData';
  static const String resetWithEmail = 'api/v1/auth/verifyEmailForReset';
  static const String verifyOTPForReset = 'api/v1/otp/verifyOTPReset';
  static const String updatePasswordWithToken =
      'api/v1/password/updateUserPasswordWithEmail';
  static const String getStoreStatsWithDate =
      'api/v1/orders/getStoreStatsDataWithDates';
  static const String getChatRooms = 'api/v1/chats/getChatRooms';
  static const String createChatRooms = 'api/v1/chats/createChatRooms';
  static const String getChatList = 'api/v1/chats/getById';
  static const String sendMessage = 'api/v1/chats/sendMessage';
  static const String getChatConversionList = 'api/v1/chats/getChatListBUid';
  static const String getMyReviews = 'api/v1/ratings/getStoreReviews';
  static const String updateProfile = 'api/v1/profile/update';
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
    'Refunded', // 7
    'Pending Payments', // 8
  ];
}
// order status
// 0 = created
// 1 = accepted
// 2 = prepared
// 3 = ongoing
// 4 = delivered
// 5 = cancelled // by user
// 6 = rejected // by store
// 7 = refund

// order to status
// 0 = to home
// 1 = self pickup

// driver assignments
// 1 = auto assign
// 2 = manually
