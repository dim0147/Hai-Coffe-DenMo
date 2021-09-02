import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/AddSpecialItemController.dart';
import 'package:hai_noob/Controller/CartController.dart';
import 'package:hai_noob/Controller/CreateItemController.dart';
import 'package:hai_noob/Controller/MenuController.dart';
import 'package:hai_noob/Controller/PlaceOrderController.dart';
import 'package:hai_noob/Controller/PlaceOrderCouponController.dart';
import 'package:hai_noob/Screen/AddSpecialItemScreen.dart';
import 'package:hai_noob/Screen/CartScreen.dart';
import 'package:hai_noob/Screen/MenuScreen.dart';
import 'package:hai_noob/Screen/PlaceOrderCouponScreen.dart';
import 'package:hai_noob/Screen/PlaceOrderScreen.dart';
import 'package:path_provider/path_provider.dart';

import '../Screen/StartupScreen.dart';
import '../Screen/LoginScreen.dart';
import '../Screen/CreateCategoryScreen.dart';
import '../Screen/CreateItemScreen.dart';

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

  // Header
  static final Color HEADER_COLOR = Colors.amber as Color;

  // Button
  static final Color TEXT_BTN_COLOR = (Colors.yellowAccent[100] as Color);

  // Chip
  static final Color? CHIP_DELETE_ICON_COLOR = Colors.amber[800];

  // Item menu
  static final Color MENU_ITEM_CONTAINER_COLOR = Colors.yellowAccent as Color;

  // Default img item
  static final String DEFAULT_IMG_ITEM = 'assets/img/background.png';

  // Route
  static final String initRoute = '/menu';
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
        Get.lazyPut(() => CreateItemController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: new Duration(seconds: 1),
      name: '/menu',
      page: () => MenuScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MenuController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: new Duration(seconds: 1),
      name: '/menu/add-special-item',
      page: () => AddSpecialItemScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddSpecialItemController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: new Duration(seconds: 1),
      name: '/menu/cart',
      page: () => CartScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CartController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: new Duration(seconds: 1),
      name: '/menu/place-order',
      page: () => PlaceOrderScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PlaceOrderController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: new Duration(seconds: 1),
      name: '/menu/place-order/add-coupon',
      page: () => PlaceOrderCouponScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PlaceOrderCouponController());
      }),
    ),
  ];
}
