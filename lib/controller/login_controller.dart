import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  // Call Api to server

}
