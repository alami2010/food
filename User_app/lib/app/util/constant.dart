/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:upgrade/app/backend/models/language_model.dart';
import 'package:upgrade/app/env.dart';

class AppConstants {
  static const String appName = Environments.appName;
  static const String defaultCurrencyCode =
      'USD'; // your currency code in 3 digit
  static const String defaultCurrencySide =
      'right'; // default currency position
  static const String defaultCurrencySymbol = '\$'; // default currency symbol
  static const int defaultShippingMethod = 0;
  static const double defaultDeliverRadius = 50;
  static const int userLogin = 0;
  static const String defaultSMSGateway = '1'; // 2 = firebase // 1 = rest
  static const String defaultLanguageApp = 'en';
  static const int defaultVerificationForSignup = 0; // 0 = email // 1= phone

  // API Routes
  static const String getAppSettings = 'api/v1/settings/getDefault';
  static const String getHomeData = 'api/v1/user/getHome';
  static const String getCuisinesData = 'api/v1/categories/userCategories';
  static const String getStoreData = 'api/v1/user/getStoreProductsById';
  static const String register = 'api/v1/auth/create_account';
  static const String referralCode = 'api/v1/referral/redeemReferral';
  static const String getWalletAmounts = 'api/v1/profile/getMyWallet';
  static const String login = 'api/v1/auth/login';
  static const String saveAddress = 'api/v1/address/save';
  static const String getSavedAddress = 'api/v1/address/getByUID';
  static const String addressById = 'api/v1/address/getById';
  static const String updateAddress = 'api/v1/address/update';
  static const String deleteAddress = 'api/v1/address/delete';
  static const String getNearMeCategories = 'api/v1/user/getNearMeCategories';
  static const String getFoodDetail = 'api/v1/foods/getProductDetails';
  static const String getPayments = 'api/v1/payments/getPayments';
  static const String getUserProfile = 'api/v1/profile/getByID';
  static const String updateProfile = 'api/v1/profile/update';
  static const String createStripeToken = 'api/v1/payments/createStripeToken';
  static const String createStripeCustomer = 'api/v1/payments/createCustomer';
  static const String addStripeCard = 'api/v1/payments/addStripeCards';
  static const String getStripeCards = 'api/v1/payments/getStripeCards';
  static const String stripeCheckout = 'api/v1/payments/createStripePayments';
  static const String getActiveOffers = 'api/v1/offers/getActive';
  static const String getStoreInfo = 'api/v1/store/getStoreInfoByUid';
  static const String createOrder = 'api/v1/orders/create';
  static const String payPalPayLink = 'api/v1/payments/payPalPay?amount=';
  static const String payTmPayLink = 'api/v1/payNow?amount=';
  static const String razorPayLink = 'api/v1/payments/razorPay?';
  static const String verifyRazorPayments =
      'api/v1/payments/VerifyRazorPurchase?id=';
  static const String payWithInstaMojo = 'api/v1/payments/instamojoPay';
  static const String paystackCheckout = 'api/v1/payments/paystackPay?';
  static const String flutterwaveCheckout = 'api/v1/payments/flutterwavePay?';
  static const String getOrders = 'api/v1/orders/getByUid';
  static const String getOrderDetails = 'api/v1/orders/getByOrderId';
  static const String tableBooking = 'api/v1/table_booking/save';
  static const String getTableList = 'api/v1/table_booking/getByUID';
  static const String editProfile = 'api/v1/profile/update';
  static const String uploadImage = 'api/v1/uploadImage';
  static const String getMyReferralCode = 'api/v1/referralcode/getMyCode';
  static const String logout = 'api/v1/auth/logout';
  static const String pageContent = 'api/v1/pages/getContent';
  static const String getMyWalletBalance = 'api/v1/profile/getMyWalletBalance';
  static const String searchQuery = 'api/v1/stores/searchQuery';
  static const String cancelOrder = 'api/v1/orders/cancelMyOrder';
  static const String getOffersRestaurant = 'api/v1/user/getOffersRestaurants';
  static const String getInvoice = 'api/v1/orders/printInvoice?id=';
  static const String registerComplaints =
      'api/v1/complaints/registerNewComplaints';
  static const String getStoreRatings = 'api/v1/ratings/getByStoreId';
  static const String saveStoreRatings = 'api/v1/ratings/saveStoreRatings';
  static const String getProductRatings = 'api/v1/ratings/getByProductId';
  static const String saveProductRatings = 'api/v1/ratings/saveProductRatings';
  static const String getDriverRatings = 'api/v1/ratings/getByDriverId';
  static const String saveDriverRatings = 'api/v1/ratings/saveDriversRatings';
  static const String resetWithEmail = 'api/v1/auth/verifyEmailForReset';
  static const String verifyOTPForReset = 'api/v1/otp/verifyOTPReset';
  static const String updatePasswordWithToken =
      'api/v1/password/updateUserPasswordWithEmail';
  static const String loginWithPhonePassword =
      'api/v1/auth/loginWithPhonePassword';
  static const String verifyPhone = 'api/v1/otp/verifyPhone';
  static const String verifyOTP = 'api/v1/otp/verifyOTP';
  static const String loginWithMobileToken = 'api/v1/auth/loginWithMobileOtp';
  static const String verifyPhoneFirebase =
      'api/v1/auth/verifyPhoneForFirebase';
  static const String openFirebaseVerification = 'api/v1/auth/firebaseauth?';
  static const String getChatRooms = 'api/v1/chats/getChatRooms';
  static const String createChatRooms = 'api/v1/chats/createChatRooms';
  static const String getChatList = 'api/v1/chats/getById';
  static const String sendMessage = 'api/v1/chats/sendMessage';
  static const String getChatConversionList = 'api/v1/chats/getChatListBUid';
  static const String myFavList = 'api/v1/favourite/inMyList';
  static const String addToFavList = 'api/v1/favourite/save';
  static const String removeFromFavList = 'api/v1/favourite/delete';
  static const String getMyFavList = 'api/v1/user/getMyFavList';
  static const String sendVerificationMail = 'api/v1/sendVerificationOnMail';
  static const String sendVerificationSMS = 'api/v1/verifyPhoneSignup';
  static const String verifyMobileForeFirebase =
      'api/v1/auth/verifyPhoneForFirebaseRegistrations';
  static const String saveaContacts = 'api/v1/contacts/create';
  static const String sendMailToAdmin = 'api/v1/sendMailToAdmin';
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
    'Rejected', // 7
    'Pending Payments', // 8
  ];
}
