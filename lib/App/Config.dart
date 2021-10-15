import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/Category/EditCategoryController.dart';
import 'package:hai_noob/Controller/Category/ListCategoryController.dart';
import 'package:hai_noob/Controller/Item/EditItemController.dart';
import 'package:hai_noob/Controller/Item/ListItemController.dart';
import 'package:hai_noob/Controller/Menu/AddSpecialItemController.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderSuccessController.dart';
import 'package:hai_noob/Controller/Phieu/CreatePhieuController.dart';
import 'package:hai_noob/Controller/Table/AddTableController.dart';
import 'package:hai_noob/Controller/Menu/CartController.dart';
import 'package:hai_noob/Controller/Item/CreateItemController.dart';
import 'package:hai_noob/Controller/Menu/MenuController.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderController.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderCouponController.dart';
import 'package:hai_noob/Controller/Table/EditTableController.dart';
import 'package:hai_noob/Controller/Table/ListTableController.dart';
import 'package:hai_noob/Controller/Table/TableLocalInfoController.dart';
import 'package:hai_noob/Controller/Table/TablePanelController.dart';
import 'package:hai_noob/Screen/Category/EditCategoryScreen.dart';
import 'package:hai_noob/Screen/Category/ListCategoryScreen.dart';
import 'package:hai_noob/Screen/Item/EditItemScreen.dart';
import 'package:hai_noob/Screen/Item/ListItemScreen.dart';
import 'package:hai_noob/Screen/Menu/AddSpecialItemScreen.dart';
import 'package:hai_noob/Screen/Order/PlaceOrderSuccessScreen.dart';
import 'package:hai_noob/Screen/Phieu/CreatePhieuScreen.dart';
import 'package:hai_noob/Screen/Table/AddTableScreen.dart';
import 'package:hai_noob/Screen/Menu/CartScreen.dart';
import 'package:hai_noob/Screen/Menu/MenuScreen.dart';
import 'package:hai_noob/Screen/Order/PlaceOrderCouponScreen.dart';
import 'package:hai_noob/Screen/Order/PlaceOrderScreen.dart';
import 'package:hai_noob/Screen/Table/EditTableScreen.dart';
import 'package:hai_noob/Screen/Table/ListTableScreen.dart';
import 'package:hai_noob/Screen/Table/TableLocalInfoScreen.dart';
import 'package:hai_noob/Screen/Table/TablePanelScreen.dart';

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
      name: '/login',
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
    GetPage(
      name: '/category/add',
      page: () => CreateCategoryScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CreateCategoryController());
      }),
    ),
    GetPage(
      name: '/category/edit',
      page: () => EditCategoryScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => EditCategoryController());
      }),
    ),
    GetPage(
      name: '/category/list',
      page: () => ListCategoryScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ListCategoryController());
      }),
    ),
    GetPage(
      name: '/item/add',
      page: () => CreateItemScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CreateItemController());
      }),
    ),
    GetPage(
      name: '/item/edit',
      page: () => EditItemScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => EditItemController());
      }),
    ),
    GetPage(
      name: '/item/list',
      page: () => ListItemScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ListItemController());
      }),
    ),
    GetPage(
      name: '/menu',
      page: () => MenuScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MenuController());
      }),
    ),
    GetPage(
      name: '/menu/add-special-item',
      page: () => AddSpecialItemScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddSpecialItemController());
      }),
    ),
    GetPage(
      name: '/menu/cart',
      page: () => CartScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CartController());
      }),
    ),
    GetPage(
      name: '/place-order',
      page: () => PlaceOrderScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PlaceOrderController());
      }),
    ),
    GetPage(
      name: '/place-order/add-coupon',
      page: () => PlaceOrderCouponScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PlaceOrderCouponController());
      }),
    ),
    GetPage(
      name: '/place-order/success',
      page: () => PlaceOrderSuccessScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PlaceOrderSuccessController());
      }),
    ),
    GetPage(
      name: '/table',
      page: () => TablePanelScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TablePanelController());
      }),
    ),
    GetPage(
      name: '/table/list',
      page: () => ListTableScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ListTableController());
      }),
    ),
    GetPage(
      name: '/table/add',
      page: () => AddTableScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddTableController());
      }),
    ),
    GetPage(
      name: '/table/edit',
      page: () => EditTableScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => EditTableController());
      }),
    ),
    GetPage(
      name: '/table/local-info',
      page: () => TableLocalInfoScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TableLocalInfoController());
      }),
    ),
    GetPage(
      name: '/phieu/add',
      page: () => CreatePhieuScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CreatePhieuController());
      }),
    ),
  ];
}
