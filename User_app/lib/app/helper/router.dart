/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:upgrade/app/backend/binding/account_binding.dart';
import 'package:upgrade/app/backend/binding/add_card_binding.dart';
import 'package:upgrade/app/backend/binding/add_new_address_binding.dart';
import 'package:upgrade/app/backend/binding/app_pages_binding.dart';
import 'package:upgrade/app/backend/binding/await_payments_binding.dart';
import 'package:upgrade/app/backend/binding/chat_screen_binding.dart';
import 'package:upgrade/app/backend/binding/checkout_binding.dart';
import 'package:upgrade/app/backend/binding/choose_location_binding.dart';
import 'package:upgrade/app/backend/binding/complaints_binding.dart';
import 'package:upgrade/app/backend/binding/contact_us_binding.dart';
import 'package:upgrade/app/backend/binding/coupens_binding.dart';
import 'package:upgrade/app/backend/binding/cuisines_binding.dart';
import 'package:upgrade/app/backend/binding/customiz_binding.dart';
import 'package:upgrade/app/backend/binding/deals_binding.dart';
import 'package:upgrade/app/backend/binding/delivery_address_binding.dart';
import 'package:upgrade/app/backend/binding/edit_profile_binding.dart';
import 'package:upgrade/app/backend/binding/find_location_binding.dart';
import 'package:upgrade/app/backend/binding/firebase_binding.dart';
import 'package:upgrade/app/backend/binding/firebase_register_binding.dart';
import 'package:upgrade/app/backend/binding/forgot_password_binding.dart';
import 'package:upgrade/app/backend/binding/getby_categories_binding.dart';
import 'package:upgrade/app/backend/binding/give_reviews_binding.dart';
import 'package:upgrade/app/backend/binding/history_binding.dart';
import 'package:upgrade/app/backend/binding/home_binding.dart';
import 'package:upgrade/app/backend/binding/language_binding.dart';
import 'package:upgrade/app/backend/binding/login_binding.dart';
import 'package:upgrade/app/backend/binding/message_binding.dart';
import 'package:upgrade/app/backend/binding/my_cart_binding.dart';
import 'package:upgrade/app/backend/binding/my_favorites_binding.dart';
import 'package:upgrade/app/backend/binding/offers_restaurants_binding.dart';
import 'package:upgrade/app/backend/binding/order_details_binding.dart';
import 'package:upgrade/app/backend/binding/refer_earn_binding.dart';
import 'package:upgrade/app/backend/binding/register_binding.dart';
import 'package:upgrade/app/backend/binding/restaurant_detail_binding.dart';
import 'package:upgrade/app/backend/binding/saved_address_binding.dart';
import 'package:upgrade/app/backend/binding/search_binding.dart';
import 'package:upgrade/app/backend/binding/slider_screen_binding.dart';
import 'package:upgrade/app/backend/binding/splash_screen_binding.dart';
import 'package:upgrade/app/backend/binding/stripe_pay_binding.dart';
import 'package:upgrade/app/backend/binding/tab_binding.dart';
import 'package:upgrade/app/backend/binding/table_booking_binding.dart';
import 'package:upgrade/app/backend/binding/table_list_binding.dart';
import 'package:upgrade/app/backend/binding/track_order_binding.dart';
import 'package:upgrade/app/backend/binding/tracking_binding.dart';
import 'package:upgrade/app/backend/binding/wallet_binding.dart';
import 'package:upgrade/app/backend/binding/web_payment_binding.dart';
import 'package:upgrade/app/view/account.dart';
import 'package:upgrade/app/view/add_card.dart';
import 'package:upgrade/app/view/add_new_address.dart';
import 'package:upgrade/app/view/app_pages.dart';
import 'package:upgrade/app/view/await_payments.dart';
import 'package:upgrade/app/view/chat_screen.dart';
import 'package:upgrade/app/view/checkout.dart';
import 'package:upgrade/app/view/choose_location.dart';
import 'package:upgrade/app/view/complaints.dart';
import 'package:upgrade/app/view/contact_us.dart';
import 'package:upgrade/app/view/coupens.dart';
import 'package:upgrade/app/view/cuisines.dart';
import 'package:upgrade/app/view/customiz.dart';
import 'package:upgrade/app/view/deals.dart';
import 'package:upgrade/app/view/delivery_address.dart';
import 'package:upgrade/app/view/edit_profile.dart';
import 'package:upgrade/app/view/error.dart';
import 'package:upgrade/app/view/find_location.dart';
import 'package:upgrade/app/view/firebase.dart';
import 'package:upgrade/app/view/firebase_register.dart';
import 'package:upgrade/app/view/forgot_password.dart';
import 'package:upgrade/app/view/getby_categories.dart';
import 'package:upgrade/app/view/give_reviews.dart';
import 'package:upgrade/app/view/history.dart';
import 'package:upgrade/app/view/home_screen.dart';
import 'package:upgrade/app/view/language.dart';
import 'package:upgrade/app/view/login.dart';
import 'package:upgrade/app/view/message.dart';
import 'package:upgrade/app/view/my_cart.dart';
import 'package:upgrade/app/view/my_favorites.dart';
import 'package:upgrade/app/view/offers_restaurants.dart';
import 'package:upgrade/app/view/order_details.dart';
import 'package:upgrade/app/view/refer_earn.dart';
import 'package:upgrade/app/view/register.dart';
import 'package:upgrade/app/view/restaurant_detail.dart';
import 'package:upgrade/app/view/saved_address.dart';
import 'package:upgrade/app/view/search.dart';
import 'package:upgrade/app/view/slider_screen.dart';
import 'package:upgrade/app/view/splash_screen.dart';
import 'package:upgrade/app/view/stripe_pay.dart';
import 'package:upgrade/app/view/tab_screen.dart';
import 'package:upgrade/app/view/table_booking.dart';
import 'package:upgrade/app/view/table_list.dart';
import 'package:upgrade/app/view/track.dart';
import 'package:upgrade/app/view/track_order.dart';
import 'package:upgrade/app/view/wallet.dart';
import 'package:get/get.dart';
import 'package:upgrade/app/view/web_payment.dart';

class AppRouter {
  static const String initial = '/';
  static const String chooseLocation = '/chooseLocation';
  static const String findlocation = '/findlocation';
  static const String tab = '/tabscreen';
  static const String home = '/homescreen';
  static const String deals = '/dealsscreen';
  static const String history = '/historyscreen';
  static const String account = '/accountscreen';
  static const String restaurantdetail = '/restaurantdetail';
  static const String mycart = '/mycart';
  static const String search = '/search';
  static const String checkout = '/checkout';
  static const String addcard = '/addcard';
  static const String register = '/register';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String sliderScreen = '/sliderScreen';
  static const String splashScreen = '/splashScreen';
  static const String appPages = '/appPages';
  static const String myFavorite = '/myFavorite';
  static const String savedAddress = '/savedAddress';
  static const String addNewAddress = '/addNewAddress';
  static const String contactUs = '/contactUs';
  static const String wallet = '/wallet';
  static const String referEarn = '/referEarn';
  static const String language = '/language';
  static const String chatScreen = '/chatScreen';
  static const String message = '/message';
  static const String editProfile = '/editProfile';
  static const String cusines = '/cusines';
  static const String customiz = '/customiz';
  static const String trackOrder = '/trackOrder';
  static const String tableBooking = '/tableBooking';
  static const String getbyCategories = '/getByCategories';
  static const String deliveryAddress = '/deliveryAddress';
  static const String stripePay = '/stripePay';
  static const String webPayment = '/webPayment';
  static const String coupens = '/coupens';
  static const String errorRoutes = '/error';
  static const String orderDetails = '/orderDetails';
  static const String tableList = '/tableList';
  static const String awaitPayments = '/await_payments';
  static const String offersRestaurants = '/offers_restaurants';
  static const String complaintsRoutes = '/complaints';
  static const String giveReviewsRoutes = '/give_reviews';
  static const String trackOrderRoutes = '/tracking';
  static const String firebaseLoginRoutes = '/firebase';
  static const String firebaseRegisterRoutes = '/firebase_register';

  static String getInitialRoute() => initial;
  static String getSliderScreen() => sliderScreen;
  static String getChooseLocation() => chooseLocation;
  static String getFindLocation() => findlocation;
  static String getTab() => tab;
  static String getHome() => home;
  static String getDeals() => deals;
  static String getHistory() => history;
  static String getAccount() => account;
  static String getRestaurantDetail() => restaurantdetail;
  static String getMyCart() => mycart;
  static String getSearch() => search;
  static String getCheckout() => checkout;
  static String getAddCard() => addcard;
  static String getRegister() => register;
  static String getLogin() => login;
  static String getForgotPassword() => forgotPassword;
  static String getSplasgScreen() => splashScreen;
  static String getAppPages() => appPages;
  static String getMyFavorite() => myFavorite;
  static String getSavedAddress() => savedAddress;
  static String getAddNewAddress() => addNewAddress;
  static String getContactUs() => contactUs;
  static String getWallet() => wallet;
  static String getReferEarn() => referEarn;
  static String getLangauge() => language;
  static String getChatScreen() => chatScreen;
  static String getMessage() => message;
  static String getEditProfile() => editProfile;
  static String getCusiness() => cusines;
  static String getCustomiz() => customiz;
  static String getTrackOrder() => trackOrder;
  static String getTableBooking() => tableBooking;
  static String getByCategories() => getbyCategories;
  static String getDeliveryAddress() => deliveryAddress;
  static String getStripePay() => stripePay;
  static String getWebPayment() => webPayment;
  static String getCoupens() => coupens;
  static String getErroRoutes() => errorRoutes;
  static String getOrderDetails() => orderDetails;
  static String getTableList() => tableList;
  static String getAwaitPaymentsRoutes() => awaitPayments;
  static String getOffersRestaurantsRoutes() => offersRestaurants;
  static String getComplaintsRoutes() => complaintsRoutes;
  static String getGiveReviewsRoutes() => giveReviewsRoutes;
  static String getTrackingRoutes() => trackOrderRoutes;
  static String getFirebaseVerificationRoutes() => firebaseLoginRoutes;
  static String getFirebaseRegisterVerificationRoutes() =>
      firebaseRegisterRoutes;

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: sliderScreen,
      page: () => const SliderScreen(),
      binding: SliderScreenBinding(),
    ),
    GetPage(
      name: chooseLocation,
      page: () => const ChooseLocation(),
      binding: ChooseLocationBinding(),
    ),
    GetPage(
      name: findlocation,
      page: () => const FindLocationScreen(),
      binding: FindLocationBinding(),
    ),
    GetPage(
      name: tab,
      page: () => const TabScreen(),
      binding: TabBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: deals,
      page: () => const DealsScreen(),
      binding: DealsBinding(),
    ),
    GetPage(
      name: history,
      page: () => const HistoryScreen(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: account,
      page: () => const AccountScreen(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: restaurantdetail,
      page: () => const RestaurantDetail(),
      binding: RestaurantDetailBinding(),
    ),
    GetPage(
      name: mycart,
      page: () => const MyCartScreen(),
      binding: MyCartBinding(),
    ),
    GetPage(
        name: search,
        page: () => const SearchScreen(),
        binding: SearchBinding(),
        fullscreenDialog: true),
    GetPage(
      name: checkout,
      page: () => const CheckoutScreen(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: addcard,
      page: () => const AddCardScreen(),
      binding: AddCardBinding(),
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPassword(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: sliderScreen,
      page: () => const SliderScreen(),
      binding: SliderScreenBinding(),
    ),
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: appPages,
      page: () => const AppPagesScreen(),
      binding: AppPagesBinding(),
    ),
    GetPage(
      name: myFavorite,
      page: () => const MyFavorites(),
      binding: MyFavoritesBinding(),
    ),
    GetPage(
      name: savedAddress,
      page: () => const SavedAddress(),
      binding: SavedAddressBinding(),
    ),
    GetPage(
      name: addNewAddress,
      page: () => const AddNewAddress(),
      binding: AddNewAddressBinding(),
    ),
    GetPage(
      name: contactUs,
      page: () => const ContactUs(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: wallet,
      page: () => const WalletScreen(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: referEarn,
      page: () => const ReferAndEarn(),
      binding: ReferEarnBinding(),
    ),
    GetPage(
      name: language,
      page: () => const LanguageScreen(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: chatScreen,
      page: () => const ChatScreen(),
      binding: ChatScreenBinding(),
    ),
    GetPage(
      name: message,
      page: () => const MessageScreen(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfile(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: cusines,
      page: () => const CusinesScreen(),
      binding: CuisinesBinding(),
    ),
    GetPage(
      name: customiz,
      page: () => const CustomizScreen(
        id: 'null',
        name: 'null',
      ),
      binding: CustomizeBinding(),
    ),
    GetPage(
      name: trackOrder,
      page: () => const TrackOrder(),
      binding: TrackOrderBinding(),
    ),
    GetPage(
      name: tableBooking,
      page: () => const TableBooking(),
      binding: TableBookingBinding(),
    ),
    GetPage(
      name: getbyCategories,
      page: () => const GetBycategories(),
      binding: GetByCategoriesBinding(),
    ),
    GetPage(
        name: deliveryAddress,
        page: () => const DeliveryAdrress(),
        binding: DeliveryAddressBinding(),
        fullscreenDialog: true),
    GetPage(
      name: stripePay,
      page: () => const StripePay(),
      binding: StripePayBinding(),
    ),
    GetPage(
      name: webPayment,
      page: () => const WebPayment(),
      binding: WebPaymentBinding(),
    ),
    GetPage(
        name: coupens,
        page: () => const Coupens(),
        binding: CoupensBinding(),
        fullscreenDialog: true),
    GetPage(name: errorRoutes, page: () => const ErrorScreen()),
    GetPage(
      name: tableList,
      page: () => const TableList(),
      binding: TableListBinding(),
    ),
    GetPage(
      name: orderDetails,
      page: () => const OrderDetails(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
        name: awaitPayments,
        page: () => const AwaitPaymentScreen(),
        binding: AwaitPaymentsBinding()),
    GetPage(
        name: offersRestaurants,
        page: () => const OffersRestaurantScreen(),
        binding: OffersRestaurantsBinding()),
    GetPage(
        name: complaintsRoutes,
        page: () => const ComplaintScreen(),
        binding: ComplaintsBinding()),
    GetPage(
        name: giveReviewsRoutes,
        page: () => const GiveReviewScreen(),
        binding: GiveReviewsBinding()),
    GetPage(
        name: trackOrderRoutes,
        page: () => const TrackingScreen(),
        binding: TrackingBinding()),
    GetPage(
        name: firebaseLoginRoutes,
        page: () => const FirebaseVerificationScreen(),
        binding: FirebaseBinding()),
    GetPage(
        name: firebaseRegisterRoutes,
        page: () => const FirebaseRegisterScreen(),
        binding: FirebaseRegisterBinding(),
        fullscreenDialog: true)
  ];
}
