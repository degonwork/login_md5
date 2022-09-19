import 'package:get/get.dart';
import 'package:responsive_login_ui/controller/login_controller.dart';
import 'package:responsive_login_ui/controller/simple_ui_controller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SimpleUIController());
    Get.lazyPut(() => LoginController());
  }
}
