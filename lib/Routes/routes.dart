import 'package:get/get.dart';
import 'package:glowshoess.id/module/cart_page/view/cart_page_view.dart';
import 'package:glowshoess.id/module/categories_page/view/simple_cleaning_view.dart';
import 'package:glowshoess.id/module/history_page/view/history_page_view.dart';
import 'package:glowshoess.id/module/login_page/view/login_page_view.dart';
import 'package:glowshoess.id/module/profile_page/view/profile_page.dart';
import 'package:glowshoess.id/module/signup_page/view/signup_page_view.dart';
import 'package:glowshoess.id/module/welcome_page/view/welcome_page_view.dart';
import 'package:glowshoess.id/module/homepage/view/homepage_view.dart';
import 'package:glowshoess.id/module/homepage/controller/homepage_controller.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String simple_cleaning = '/simple';
  static const String history1 = '/history1';
  static const String profile = '/profile';

  // Getter untuk rute awal
  static String getHomeRoute() => welcome;

  // Daftar rute
  static List<GetPage> routes = [
    GetPage(
      page: () => WelcomePage(),
      name: welcome,
    ),
    GetPage(
      page: () => LoginPageView(),
      name: login,
    ),
    GetPage(
      page: () => SignupPageView(),
      name: signup,
    ),
    GetPage(
      page: () =>
          HomePageView(controller: HomePageController()), // Perbaikan di sini
      name: home,
    ),
    GetPage(page: () => CartPage(), name: cart),
    GetPage(page: () => SimpleCleaningView(), name: simple_cleaning),
    GetPage(page: () => HistoryPage(), name: history1),
    GetPage(page: () => ProfilePage(), name: profile)
  ];
}
