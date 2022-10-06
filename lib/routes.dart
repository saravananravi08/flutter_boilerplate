import 'package:flutter_boilerplate/screens/_screen_bindindgs/home_screen_bindings.dart';
import 'package:flutter_boilerplate/screens/home_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const String home = '/home';
}

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.home,
        page: () => const HomeScreen(),
        binding: HomeScreenBindings()),
  ];
}
