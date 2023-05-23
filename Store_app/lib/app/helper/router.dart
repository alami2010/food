/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:get/route_manager.dart';
import 'package:vender/app/backend/binding/account_binding.dart';
import 'package:vender/app/backend/binding/add_admin_category_binding.dart';
import 'package:vender/app/backend/binding/add_category_binding.dart';
import 'package:vender/app/backend/binding/add_food_binding.dart';
import 'package:vender/app/backend/binding/add_store_category_parse.dart';
import 'package:vender/app/backend/binding/all_categories_binding.dart';
import 'package:vender/app/backend/binding/analytics_binding.dart';
import 'package:vender/app/backend/binding/app_pages_binding.dart';
import 'package:vender/app/backend/binding/bookings_binding.dart';
import 'package:vender/app/backend/binding/chat_screen_binding.dart';
import 'package:vender/app/backend/binding/contact_us_binding.dart';
import 'package:vender/app/backend/binding/cuisine_binding.dart';
import 'package:vender/app/backend/binding/edit_profile_binding.dart';
import 'package:vender/app/backend/binding/foods_screen_binding.dart';
import 'package:vender/app/backend/binding/forgot_password_binding.dart';
import 'package:vender/app/backend/binding/insights_binding.dart';
import 'package:vender/app/backend/binding/language_binding.dart';
import 'package:vender/app/backend/binding/login_binding.dart';
import 'package:vender/app/backend/binding/message_screen_binding.dart';
import 'package:vender/app/backend/binding/order_details_binding.dart';
import 'package:vender/app/backend/binding/order_screen_binding.dart';
import 'package:vender/app/backend/binding/reviews_binding.dart';
import 'package:vender/app/backend/binding/driver_list_binding.dart';
import 'package:vender/app/backend/binding/splash_screen_binding.dart';
import 'package:vender/app/backend/binding/stats_charts_binding.dart';
import 'package:vender/app/backend/binding/tab_binding.dart';
import 'package:vender/app/view/account.dart';
import 'package:vender/app/view/add_admin_category.dart';
import 'package:vender/app/view/add_category.dart';
import 'package:vender/app/view/add_food.dart';
import 'package:vender/app/view/add_store_category.dart';
import 'package:vender/app/view/all_categories.dart';
import 'package:vender/app/view/analytics.dart';
import 'package:vender/app/view/app_pages.dart';
import 'package:vender/app/view/bookings.dart';
import 'package:vender/app/view/chat_screen.dart';
import 'package:vender/app/view/contact_us.dart';
import 'package:vender/app/view/cuisine.dart';
import 'package:vender/app/view/edit_profile.dart';
import 'package:vender/app/view/error.dart';
import 'package:vender/app/view/foods_screen.dart';
import 'package:vender/app/view/forgot_password.dart';
import 'package:vender/app/view/insights.dart';
import 'package:vender/app/view/language.dart';
import 'package:vender/app/view/login.dart';
import 'package:vender/app/view/message_screen.dart';
import 'package:vender/app/view/order_details.dart';
import 'package:vender/app/view/order_screen.dart';
import 'package:vender/app/view/reviews.dart';
import 'package:vender/app/view/driver_list.dart';
import 'package:vender/app/view/splash_screen.dart';
import 'package:vender/app/view/stats_chart.dart';
import 'package:vender/app/view/tab_screen.dart';

class AppRouter {
  static const String spalashScreen = '/';
  static const String initial = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String tab = '/tab';
  static const String orderScreen = '/orderScreen';
  static const String analytics = '/analytics';
  static const String account = '/account';
  static const String reviews = '/reviews';
  static const String appPages = '/appPages';
  static const String contactUs = '/contactUs';
  static const String language = '/language';
  static const String chatScreen = '/chatScreen';
  static const String messageScreen = '/messageScreen';
  static const String addCategory = '/addCategory';
  static const String foodScreen = '/foodScreen';
  static const String addFood = '/addFood';
  static const String allCategories = '/allCategories';
  static const String editProfile = '/editProfile';
  static const String addStoreCategory = '/addStoreCategory';
  static const String addAdminCategory = '/addAdminCategory';
  static const String orderDetails = '/orderDetails';
  static const String driverList = '/driverList';
  static const String errorRoutes = '/error';
  static const String bookings = '/bookings';
  static const String insights = '/insights';
  static const String cuisineRoutes = '/cuisine';
  static const String statsChartsRoutes = '/statsCharts';

  static String getInitialRoute() => initial;
  static String getForgotPassword() => forgotPassword;
  static String getTab() => tab;
  static String getOrderScreen() => orderScreen;
  static String getAnalytics() => analytics;
  static String getAccount() => account;
  static String getRevies() => reviews;
  static String getAppPages() => appPages;
  static String getContactUs() => contactUs;
  static String getLanguage() => language;
  static String getChatScreen() => chatScreen;
  static String getMessageScreen() => messageScreen;
  static String getAddCategory() => addCategory;
  static String getFoodScreen() => foodScreen;
  static String getAddFood() => addFood;
  static String getAllCategories() => allCategories;
  static String getEditProfile() => editProfile;
  static String getAddStoreCategory() => addStoreCategory;
  static String getAdminCategory() => addAdminCategory;
  static String getSingleOrderDetails() => orderDetails;
  static String getDriverList() => driverList;
  static String getSplashScreen() => spalashScreen;
  static String getErroRoutes() => errorRoutes;
  static String getBookings() => bookings;
  static String getInsights() => insights;
  static String getCuisineRoutes() => cuisineRoutes;
  static String getStatsChartsRoutes() => statsChartsRoutes;

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPassword(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: tab,
      page: () => const TabScreen(),
      binding: TabBinding(),
    ),
    GetPage(
      name: orderScreen,
      page: () => const OrderScreen(),
      binding: OrderScreenBinding(),
    ),
    GetPage(
      name: analytics,
      page: () => const Analytics(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: account,
      page: () => const Account(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: reviews,
      page: () => const Reviews(),
      binding: ReviewsBinding(),
    ),
    GetPage(
      name: appPages,
      page: () => const AppPages(),
      binding: AppPagesBinding(),
    ),
    GetPage(
      name: contactUs,
      page: () => const ContactUs(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: language,
      page: () => const Language(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: chatScreen,
      page: () => const ChatScreen(),
      binding: ChatScreenBinding(),
    ),
    GetPage(
      name: messageScreen,
      page: () => const MessageScreen(),
      binding: MessageScreenBinding(),
    ),
    GetPage(
      name: addCategory,
      page: () => const AddCategory(),
      binding: AddCategoryBinding(),
    ),
    GetPage(
      name: foodScreen,
      page: () => const FoodsScreen(),
      binding: FoodsScreenBinding(),
    ),
    GetPage(
      name: addFood,
      page: () => const AddFood(),
      binding: AddFoodBinding(),
    ),
    GetPage(
        name: allCategories,
        page: () => const AllCategories(),
        binding: AllCategoriesBinding(),
        fullscreenDialog: true),
    GetPage(
      name: editProfile,
      page: () => const EditProfile(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: addStoreCategory,
      page: () => const AddStoreCategory(),
      binding: AddStoreCategoryBinding(),
    ),
    GetPage(
      name: addAdminCategory,
      page: () => const AddAdminCategory(),
      binding: AddAdminCategoryBinding(),
    ),
    GetPage(
      name: orderDetails,
      page: () => const OrderDetails(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
        name: driverList,
        page: () => const DriverList(),
        binding: DriverListBinding(),
        fullscreenDialog: true),
    GetPage(
      name: spalashScreen,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(name: errorRoutes, page: () => const ErrorScreen()),
    GetPage(
      name: bookings,
      page: () => const Bookings(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: insights,
      page: () => const InsightsScreen(),
      binding: InsightsBinding(),
    ),
    GetPage(
        name: cuisineRoutes,
        page: () => const CuisineScreen(),
        binding: CuisineBinding(),
        fullscreenDialog: true),
    GetPage(
        name: statsChartsRoutes,
        page: () => const StatsChartScreen(),
        binding: StatsChartsBinding())
  ];
}
