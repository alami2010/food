/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/backend/binding/app_pages_binding.dart';
import 'package:driver/app/backend/binding/chat_screen_binding.dart';
import 'package:driver/app/backend/binding/contact_us_binding.dart';
import 'package:driver/app/backend/binding/edit_profile_binding.dart';
import 'package:driver/app/backend/binding/forgot_password_binding.dart';
import 'package:driver/app/backend/binding/language_binding.dart';
import 'package:driver/app/backend/binding/login_binding.dart';
import 'package:driver/app/backend/binding/message_binding.dart';
import 'package:driver/app/backend/binding/order_detail_binding.dart';
import 'package:driver/app/backend/binding/order_screen_binding.dart';
import 'package:driver/app/backend/binding/profile_binding.dart';
import 'package:driver/app/backend/binding/reviews_binding.dart';
import 'package:driver/app/backend/binding/splash_screen_binding.dart';
import 'package:driver/app/backend/binding/tab_screen_binding.dart';
import 'package:driver/app/backend/binding/tracking_binding.dart';
import 'package:driver/app/view/app_pages.dart';
import 'package:driver/app/view/chat_screen.dart';
import 'package:driver/app/view/contact_us.dart';
import 'package:driver/app/view/edit_profile.dart';
import 'package:driver/app/view/error.dart';
import 'package:driver/app/view/forgot_password.dart';
import 'package:driver/app/view/language.dart';
import 'package:driver/app/view/login.dart';
import 'package:driver/app/view/message.dart';
import 'package:driver/app/view/order_detail.dart';
import 'package:driver/app/view/order_screen.dart';
import 'package:driver/app/view/profile.dart';
import 'package:driver/app/view/reviews.dart';
import 'package:driver/app/view/splash_screen.dart';
import 'package:driver/app/view/tab_screen.dart';
import 'package:driver/app/view/tracking.dart';
import 'package:get/route_manager.dart';

class AppRouter {
  static const String initial = '/';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String tabScreen = '/tabScreen';
  static const String orderScreen = '/orderScreen';
  static const String profile = '/profile';
  static const String orderDetail = '/orderDetail';
  static const String reviews = '/reviews';
  static const String appPages = '/appPages';
  static const String contactUs = '/contactUs';
  static const String language = '/language';
  static const String editProfile = '/editProfile';
  static const String errorRoutes = '/error';
  static const String trackingRoutes = '/trackings';
  static const String chatScreen = '/chatScreen';
  static const String message = '/message';

  static String getInitialRoute() => initial;
  static String getLoginScreen() => login;
  static String getForgotPassword() => forgotPassword;
  static String getTabScreen() => tabScreen;
  static String getOrderScreen() => orderScreen;
  static String getProfile() => profile;
  static String getOrderDetail() => orderDetail;
  static String getReviews() => reviews;
  static String getAppPages() => appPages;
  static String getContactUs() => contactUs;
  static String getLanguage() => language;
  static String getEditProfile() => editProfile;
  static String getErroRoutes() => errorRoutes;
  static String getTrackingRoutes() => trackingRoutes;
  static String getChatScreen() => chatScreen;
  static String getMessage() => message;

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
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
      name: tabScreen,
      page: () => const TabScreen(),
      binding: TabBinding(),
    ),
    GetPage(
      name: orderScreen,
      page: () => const OrderScreen(),
      binding: OrderScreenBinding(),
    ),
    GetPage(
      name: profile,
      page: () => const Profile(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: orderDetail,
      page: () => const OrderDetail(),
      binding: OrderDetailBinding(),
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
      name: editProfile,
      page: () => const EditProfile(),
      binding: EditProfileBinding(),
    ),
    GetPage(name: errorRoutes, page: () => const ErrorScreen()),
    GetPage(
        name: trackingRoutes,
        page: () => const TrackingScreen(),
        binding: TrackingBinding()),
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
  ];
}
