import 'package:get/get.dart';

class SimpleUIController extends GetxController {
  bool isObscure = true;

  isObscureActive() {
    isObscure = !isObscure;
    update();
  }
}
