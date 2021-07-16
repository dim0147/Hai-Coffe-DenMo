import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screen/StartupScreen.dart';
import '../Screen/LoginScreen.dart';

import '../Controller/LoginController.dart';
import '../Controller/StartupController.dart';

class AppConfig {
  // Admin password
  static final String DEFAULT_ADMIN_PASSWORD = '123456';

  // Box name and key names
  static final String BOX_NAME = 'cafe';
  static final String BOX_TABLE_KEY_NAME = 'table';

  static final List<GetPage> GetPages = [
    GetPage(
      name: '/startup',
      page: () => StartupScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => StartupController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: new Duration(seconds: 2),
      name: '/login',
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
  ];
}
