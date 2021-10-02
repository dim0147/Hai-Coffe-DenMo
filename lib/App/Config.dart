import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/Menu/AddSpecialItemController.dart';
import 'package:hai_noob/Controller/Table/AddTableController.dart';
import 'package:hai_noob/Controller/Menu/CartController.dart';
import 'package:hai_noob/Controller/Item/CreateItemController.dart';
import 'package:hai_noob/Controller/Menu/MenuController.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderController.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderCouponController.dart';
import 'package:hai_noob/Controller/Table/TablePanelController.dart';
import 'package:hai_noob/Screen/Menu/AddSpecialItemScreen.dart';
import 'package:hai_noob/Screen/Table/AddTableScreen.dart';
import 'package:hai_noob/Screen/Menu/CartScreen.dart';
import 'package:hai_noob/Screen/Menu/MenuScreen.dart';
import 'package:hai_noob/Screen/Order/PlaceOrderCouponScreen.dart';
import 'package:hai_noob/Screen/Order/PlaceOrderScreen.dart';
import 'package:hai_noob/Screen/Table/TablePanelScreen.dart';
import 'package:path_provider/path_provider.dart';

import '../Screen/StartupScreen.dart';
import '../Screen/LoginScreen.dart';
import '../Screen/Category/CreateCategoryScreen.dart';
import '../Screen/Item/CreateItemScreen.dart';

import '../Controller/LoginController.dart';
import '../Controller/StartupController.dart';
import '../Controller/Category/CreateCategoryController.dart';

class AppConfig {
  // Admin password
  static final String DEFAULT_ADMIN_PASSWORD = '123456';

  // Box name and key names
  static final String BOX_NAME = 'cafe';

  // Color For App
  static final Color BACKGROUND_COLOR =
      Color.fromRGBO(218, 172, 88, 1.0) as Color;
  static final Color MAIN_COLOR = Colors.amber[300] as Color;
  static final Color FONT_COLOR = Colors.white;

  // Header
  static final Color HEADER_COLOR = Colors.amberAccent;

  // Button
  static final Color TEXT_BTN_COLOR = Colors.yellowAccent[400] as Color;
  static final Color ELEVATED_TEXT_BTN_COLOR =
      (Colors.yellowAccent[100] as Color);
  static final Color OUTLINE_TEXT_BTN_COLOR = Colors.white;

  // Chip
  static final Color? CHIP_DELETE_ICON_COLOR = Colors.amber[800];

  // Item menu
  static final Color MENU_ITEM_CONTAINER_COLOR = Colors.yellowAccent as Color;

  // Default img item
  static final String DEFAULT_IMG_ITEM = 'assets/img/background.png';

  // Route
  // static final String initRoute = '/menu';
  static final String initRoute = '/table/';

  // Pages
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
      name: '/login',
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      name: '/category/add',
      page: () => CreateCategoryScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CreateCategoryController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      name: '/item/add',
      page: () => CreateItemScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CreateItemController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      name: '/menu',
      page: () => MenuScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MenuController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      name: '/menu/add-special-item',
      page: () => AddSpecialItemScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddSpecialItemController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      name: '/menu/cart',
      page: () => CartScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CartController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      name: '/menu/place-order',
      page: () => PlaceOrderScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PlaceOrderController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      name: '/menu/place-order/add-coupon',
      page: () => PlaceOrderCouponScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PlaceOrderCouponController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      name: '/table/add',
      page: () => AddTableScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddTableController());
      }),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      name: '/table/',
      page: () => TablePanelScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TablePanelController());
      }),
    ),
  ];
}
