import 'package:get/get.dart';
import 'package:responsive_login_ui/views/address_view.dart';
import 'package:responsive_login_ui/views/login_view.dart';
import 'package:responsive_login_ui/views/signup_view.dart';

class Routes {
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String country = '/country';
  static List<GetPage> listRoutes = [
    GetPage(name: login, page: () => const LoginView()),
    GetPage(name: signUp, page: () => const SignUpView()),
    GetPage(name: country, page: () => const AddressView()),
  ];
}
