import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_login_ui/routes/routes.dart';
import 'bindings/allbindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      getPages: Routes.listRoutes,
      initialBinding: AllBindings(),
    );
  }
}
