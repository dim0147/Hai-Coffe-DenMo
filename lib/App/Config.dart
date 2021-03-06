import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/Bill/BillDetailController.dart';
import 'package:hai_noob/Controller/Bill/ListBillController.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillController.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillCouponController.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillSuccessController.dart';
import 'package:hai_noob/Controller/Category/EditCategoryController.dart';
import 'package:hai_noob/Controller/Category/ListCategoryController.dart';
import 'package:hai_noob/Controller/Item/CreateItemController.dart';
import 'package:hai_noob/Controller/Item/EditItemController.dart';
import 'package:hai_noob/Controller/Item/ListItemController.dart';
import 'package:hai_noob/Controller/Menu/AddSpecialItemController.dart';
import 'package:hai_noob/Controller/Menu/CartController.dart';
import 'package:hai_noob/Controller/Menu/MenuController.dart';
import 'package:hai_noob/Controller/Phieu/CreatePhieuController.dart';
import 'package:hai_noob/Controller/Phieu/ListPhieuController.dart';
import 'package:hai_noob/Controller/RevenueController.dart';
import 'package:hai_noob/Controller/System/ImportExportController.dart';
import 'package:hai_noob/Controller/System/SystemInfo.dart';
import 'package:hai_noob/Controller/Table/AddTableController.dart';
import 'package:hai_noob/Controller/Table/EditTableController.dart';
import 'package:hai_noob/Controller/Table/ListTableController.dart';
import 'package:hai_noob/Controller/Table/TableLocalInfoController.dart';
import 'package:hai_noob/Controller/Table/TablePanelController.dart';
import 'package:hai_noob/Screen/Bill/BillDetailScreen.dart';
import 'package:hai_noob/Screen/Bill/ListBillScreen.dart';
import 'package:hai_noob/Screen/Bill/PlaceBillCouponScreen.dart';
import 'package:hai_noob/Screen/Bill/PlaceBillScreen.dart';
import 'package:hai_noob/Screen/Bill/PlaceBillSuccessScreen.dart';
import 'package:hai_noob/Screen/Category/EditCategoryScreen.dart';
import 'package:hai_noob/Screen/Category/ListCategoryScreen.dart';
import 'package:hai_noob/Screen/Item/EditItemScreen.dart';
import 'package:hai_noob/Screen/Item/ListItemScreen.dart';
import 'package:hai_noob/Screen/Menu/AddSpecialItemScreen.dart';
import 'package:hai_noob/Screen/Menu/CartScreen.dart';
import 'package:hai_noob/Screen/Menu/MenuScreen.dart';
import 'package:hai_noob/Screen/Phieu/CreatePhieuScreen.dart';
import 'package:hai_noob/Screen/Phieu/ListPhieuScreen.dart';
import 'package:hai_noob/Screen/RevenueScreen.dart';
import 'package:hai_noob/Screen/System/ImportExportScreen.dart';
import 'package:hai_noob/Screen/System/SystemInfoScreen.dart';
import 'package:hai_noob/Screen/Table/AddTableScreen.dart';
import 'package:hai_noob/Screen/Table/EditTableScreen.dart';
import 'package:hai_noob/Screen/Table/ListTableScreen.dart';
import 'package:hai_noob/Screen/Table/TableLocalInfoScreen.dart';
import 'package:hai_noob/Screen/Table/TablePanelScreen.dart';

import '../Controller/Category/CreateCategoryController.dart';
import '../Controller/StartupController.dart';
import '../Screen/Category/CreateCategoryScreen.dart';
import '../Screen/Item/CreateItemScreen.dart';
import '../Screen/StartupScreen.dart';

class AppConfig {
  // RUN TEST CASE OR NOT
  static final runTestCase = false;

  // DB Config
  static final String DB_FOLDER_NAME = 'db';
  static final String DB_FILE_NAME = 'hai_noob.sqlite';

  // Img Folder Name
  static final String IMG_FOLDER_NAME = 'images';

  // Backup Folde name
  static final String BACKUP_FOLDER_NAME = 'backups';

  // Box name and key names
  static final String BOX_NAME = 'cafe';

  // Color For App
  static final Color BACKGROUND_COLOR = Colors.black as Color;
  static final Color MAIN_COLOR = Colors.green as Color;

  static final Color FONT_COLOR = Colors.white;

  // Header
  static final Color HEADER_COLOR = Colors.green;

  // Button
  static final Color TEXT_BTN_COLOR = Colors.white as Color;
  static final Color ELEVATED_TEXT_BTN_COLOR = Colors.white as Color;
  static final Color OUTLINE_TEXT_BTN_COLOR = Colors.white;

  // Chip
  static final Color CHIP_DELETE_ICON_COLOR = Colors.white;

  // Divider
  static final Color DIVIDER_COLOR = Colors.white;

  // Revenue
  static final Color REVENUE_DATEPICKER_HEADER_TEXT_COLOR =
      Colors.white as Color;
  static final Color REVENUE_DATEPICKER_RANGE_TEXT_COLOR =
      Colors.white as Color;
  static final Color REVENUE_GRAPH_GRID_COLOR = Colors.green as Color;

  // MENU + CART
  static final Color ITEM_IN_MENU_CONTAINER_BACKGROUND =
      Colors.white.withOpacity(0.1);
  static final Color FOOTER_MENU_CONTAINER_COLOR =
      AppConfig.MAIN_COLOR.withOpacity(0.7) as Color;
  static final Color FOOTER_CART_MENU_COLOR = Colors.amber as Color;
  static final Color FOOTER_CART_TEXT_MENU_COLOR = Colors.white as Color;
  static final Color FOOTER_CART_BACKGROUND_TEXT_MENU_COLOR =
      Colors.amber[800] as Color;

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
      name: '/bill/list',
      page: () => ListBillScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ListBillController());
      }),
    ),
    GetPage(
      name: '/bill/detail',
      page: () => BillDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => BillDetailController());
      }),
    ),
    GetPage(
      name: '/place-bill',
      page: () => PlaceBillScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PlaceBillController());
      }),
    ),
    GetPage(
      name: '/place-bill/add-coupon',
      page: () => PlaceBillCouponScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PlaceBillCouponController());
      }),
    ),
    GetPage(
      name: '/place-bill/success',
      page: () => PlaceBillSuccessScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PlaceBillSuccessController());
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
    GetPage(
      name: '/phieu/list',
      page: () => ListPhieuScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ListPhieuController());
      }),
    ),
    GetPage(
      name: '/revenue',
      page: () => RevenueScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RevenueController());
      }),
    ),
    GetPage(
      name: '/system/import-export',
      page: () => ImportExportScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ImportExportController());
      }),
    ),
    GetPage(
      name: '/system/info',
      page: () => SystemInfoScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SystemInfoController());
      }),
    ),
  ];
}
