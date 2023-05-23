/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:upgrade/app/backend/api/api.dart';
import 'package:upgrade/app/backend/parse/account_parse.dart';
import 'package:upgrade/app/backend/parse/add_card_parse.dart';
import 'package:upgrade/app/backend/parse/add_new_address_parse.dart';
import 'package:upgrade/app/backend/parse/app_pages_screen.dart';
import 'package:upgrade/app/backend/parse/await_payments_parse.dart';
import 'package:upgrade/app/backend/parse/chat_screen_parse.dart';
import 'package:upgrade/app/backend/parse/checkout_parse.dart';
import 'package:upgrade/app/backend/parse/choose_location_parse.dart';
import 'package:upgrade/app/backend/parse/complaints_parse.dart';
import 'package:upgrade/app/backend/parse/contact_us_parse.dart';
import 'package:upgrade/app/backend/parse/coupens_parse.dart';
import 'package:upgrade/app/backend/parse/cuisines_parse.dart';
import 'package:upgrade/app/backend/parse/customiz_parse.dart';
import 'package:upgrade/app/backend/parse/deals_parse.dart';
import 'package:upgrade/app/backend/parse/delivery_address_parse.dart';
import 'package:upgrade/app/backend/parse/edit_profile_parse.dart';
import 'package:upgrade/app/backend/parse/feature_food_parse.dart';
import 'package:upgrade/app/backend/parse/find_location_parse.dart';
import 'package:upgrade/app/backend/parse/firebase_parse.dart';
import 'package:upgrade/app/backend/parse/firebase_register_parse.dart';
import 'package:upgrade/app/backend/parse/forgot_password_parse.dart';
import 'package:upgrade/app/backend/parse/getby_categories_parse.dart';
import 'package:upgrade/app/backend/parse/give_reviews_parse.dart';
import 'package:upgrade/app/backend/parse/history_parse.dart';
import 'package:upgrade/app/backend/parse/home_parse.dart';
import 'package:upgrade/app/backend/parse/language_parse.dart';
import 'package:upgrade/app/backend/parse/login_parse.dart';
import 'package:upgrade/app/backend/parse/message_parse.dart';
import 'package:upgrade/app/backend/parse/my_cart_parse.dart';
import 'package:upgrade/app/backend/parse/my_favorites_parse.dart';
import 'package:upgrade/app/backend/parse/offers_restaurants_parse.dart';
import 'package:upgrade/app/backend/parse/order_details_parse.dart';
import 'package:upgrade/app/backend/parse/refer_earn_parse.dart';
import 'package:upgrade/app/backend/parse/register_parse.dart';
import 'package:upgrade/app/backend/parse/restaurant_detail_parse.dart';
import 'package:upgrade/app/backend/parse/saved_address_parse.dart';
import 'package:upgrade/app/backend/parse/search_parse.dart';
import 'package:upgrade/app/backend/parse/slider_screen_parse.dart';
import 'package:upgrade/app/backend/parse/splash_screen_parse.dart';
import 'package:upgrade/app/backend/parse/stripe_pay_parse.dart';
import 'package:upgrade/app/backend/parse/tab_parse.dart';
import 'package:upgrade/app/backend/parse/table_booking_parse.dart';
import 'package:upgrade/app/backend/parse/table_list_parse.dart';
import 'package:upgrade/app/backend/parse/track_order_parse.dart';
import 'package:upgrade/app/backend/parse/track_parse.dart';
import 'package:upgrade/app/backend/parse/wallet_parse.dart';
import 'package:upgrade/app/backend/parse/web_payment_parse.dart';
import 'package:upgrade/app/controller/account_controller.dart';
import 'package:upgrade/app/controller/customiz_controller.dart';
import 'package:upgrade/app/controller/deals_controller.dart';
import 'package:upgrade/app/controller/history_controller.dart';
import 'package:upgrade/app/controller/home_controller.dart';
import 'package:upgrade/app/controller/my_cart_controller.dart';
import 'package:upgrade/app/controller/tab_controller.dart';
import 'package:upgrade/app/env.dart';
import 'package:upgrade/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final sharedPref = await SharedPreferences.getInstance();
    Get.put(
      SharedPreferencesManager(sharedPreferences: sharedPref),
      permanent: true,
    );

    Get.lazyPut(() => ApiService(appBaseUrl: Environments.apiBaseURL));

    // Parser LazyLoad

    Get.lazyPut(
        () => ChooseLocationParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FindLocationParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TabParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => HomeParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => DealsParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => HistoryParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AccountParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => RestaurantDetailParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => MyCartParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SearchParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CheckoutParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddCardParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => RegisterParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => LoginParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ForgotPasswordParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SliderScreenParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SplashScreenParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AppPagesParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => MyFavoritesParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SavedAddressParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddNewAddressParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ContactUsParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => WalletParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ReferEarnParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => LanguageParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ChatScreenParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => MessageParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => EditProfileParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CuisinesParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FeatureFoodParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CustomizeParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TrackOrderParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TableBookingParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => GetByCategoriesParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => DeliveryAddressParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => StripePayParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => WebPaymentParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CoupensParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => OrderDetailsParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TableListParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AwaitPaymentsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => OffersRestaurantsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ComplaintsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => GiveReviewsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TrackParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FirebaseParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FirebaseRegisterParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.put(() => CustomizController(parser: Get.find()));

    Get.lazyPut(() => MyCartController(parser: Get.find()), fenix: true);

    Get.lazyPut(() => TabsController(parser: Get.find()), fenix: true);

    Get.lazyPut(() => HomeController(parser: Get.find()), fenix: true);

    Get.lazyPut(() => DealsController(parser: Get.find()), fenix: true);

    Get.lazyPut(() => HistoryController(parser: Get.find()), fenix: true);

    Get.lazyPut(() => MyCartController(parser: Get.find()), fenix: true);

    Get.lazyPut(() => AccountController(parser: Get.find()), fenix: true);
  }
}
