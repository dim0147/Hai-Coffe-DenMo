import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screen/StartupScreen.dart';
import '../Screen/LoginScreen.dart';
import '../Screen/CreateCategoryScreen.dart';
import '../Screen/CreateItem.dart';

import '../Controller/LoginController.dart';
import '../Controller/StartupController.dart';
import '../Controller/CreateCategoryController.dart';

class AppConfig {
  // Admin password
  static final String DEFAULT_ADMIN_PASSWORD = '123456';

  // Box name and key names
  static final String BOX_NAME = 'cafe';
  static final String BOX_TABLE_KEY_NAME = 'table';

  // Color For App
  static final Color BACKGROUND_COLOR =
      Color.fromRGBO(218, 172, 88, 1.0) as Color;
  static final Color MAIN_COLOR = Colors.amber[300] as Color;

  // Button
  static final Color TEXT_BTN_COLOR = (Colors.yellowAccent[100] as Color);
  static final Color TEXT_BTN_COLOR_HOVER =
      (Colors.yellowAccent[100] as Color).withOpacity(0.04);

  // Chip
  static final Color? CHIP_DELETE_ICON_COLOR = Colors.amber[800];

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
      transitionDuration: new Duration(seconds: 1),
      name: '/login',
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: new Duration(seconds: 1),
      name: '/category/add',
      page: () => CreateCategoryScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CreateCategoryController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: new Duration(seconds: 1),
      name: '/item/add',
      page: () => CreateItemScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut(() => CreateCategoryController());
      }),
    ),
  ];
}