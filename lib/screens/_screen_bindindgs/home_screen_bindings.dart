import 'package:flutter_boilerplate/screens/_screen_controllers/home_screen_controller.dart';
import 'package:get/get.dart';

class HomeScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
  }
}
