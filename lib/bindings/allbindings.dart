import 'package:get/get.dart';
import 'package:responsive_login_ui/controller/address_controller.dart';
import 'package:responsive_login_ui/controller/login_controller.dart';
import 'package:responsive_login_ui/controller/simple_ui_controller.dart';
import 'package:responsive_login_ui/data/repository/address_repo.dart';

import '../data/provider/api/api.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Api());
    Get.lazyPut(() => AddressRepo(api: Get.find()));
    Get.lazyPut(() => AddressController(addressRepo: Get.find()));
    Get.lazyPut(() => SimpleUIController());
    Get.lazyPut(() => LoginController());
  }
}
