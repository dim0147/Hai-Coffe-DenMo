import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/StartupController.dart';

import 'Screen/LoginScreen.dart';
import 'Screen/StartupScreen.dart';

import 'Blinding/SpashBlinding.dart';

import 'Controller/LoginController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'QuickSand',
        primaryColor: AppConfig.BACKGROUND_COLOR,
      ),
      title: 'Hải Bên Lề',
      initialRoute: '/startup',
      initialBinding: SpashBinding(),
      // getPages: [
      //   GetPage(
      //     name: '/startup',
      //     page: () => StartupScreen(),
      //     binding: BindingsBuilder(() {
      //       Get.lazyPut(() => StartupController());
      //     }),
      //   ),
      //   GetPage(
      //     name: '/login',
      //     transition: Transition.downToUp,
      //     page: () => LoginScreen(),
      //     binding: BindingsBuilder(() {
      //       Get.lazyPut(() => LoginController());
      //     }),
      //   ),
      // ],
      getPages: AppConfig.GetPages,
    );
  }
}
