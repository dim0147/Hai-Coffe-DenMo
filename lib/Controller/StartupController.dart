import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/RevenueDAO.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../App/Services.dart';
import '../DB/Database.dart';

import '../Model/Cart.dart' as Cart;

import '../DAO/UserDAO.dart';

class StartupController extends GetxController with StateMixin<void> {
  Rx<String> statusText = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    try {
      final startUpService = StartUpService();

      // Init global config
      statusText.value = 'Đang khởi tạo config...';
      await Get.putAsync(() => ConfigService().init(), permanent: true);

      // Init Database Services
      statusText.value = 'Đang khởi tạo database...';
      await Get.putAsync(() => DbService().init(), permanent: true);

      // Init Hiv services
      statusText.value = 'Đang register Adapter Hiv Service...';
      await startUpService.registerAdapterHivService();

      // Init Table Local
      statusText.value = 'Đang khởi tạo Table Local...';
      await Get.putAsync(() => TableLocalService().init(), permanent: true);

      // On Startup Run
      statusText.value = 'Đang setup onStartup...';
      await startUpService.onStartup();

      // Done
      statusText.value = 'Khởi tạo thành công';
      change(null, status: RxStatus.success());

      // Redirect
      Get.offNamed(AppConfig.initRoute);

      // Test case
      // testCase();

      // queryTestData();
    } catch (error, stack) {
      change(null, status: RxStatus.error());
      statusText.value =
          'Có lỗi khi khởi tạo, liên hệ anh đức đẹp trai, lỗi: \n${error.toString()} \nStack Trace: ${stack.toString()}';
    }
  }

  void testCase() async {
    final appDb = Get.find<AppDatabase>();
    // final billDAO = BillDAO(appDb);
    // final ad = await billDAO.getBillBetweenDay();

    final analyzeDAO = AnalyzeDAO(appDb);

    final yesterDay =
        Utils.dateExtension.getCurrentDay().subtract(Duration(hours: 24));
    final toDay = Utils.dateExtension.getCurrentDay();

    analyzeDAO.getRevenue(yesterDay, toDay);

    var ada;
  }

  void queryTestData() async {
    var db = Get.find<AppDatabase>();

    var users = await db.select(db.users).get();
    var items = await db.select(db.items).get();
    var categories = await db.select(db.categories).get();
    var itemCategories = await db.select(db.itemCategories).get();
    var itemProperties = await db.select(db.itemProperties).get();
    var tables = await db.select(db.tableOrders).get();
    var bills = await db.select(db.bills).get();
    var billItems = await db.select(db.billItems).get();
    var billItemProperties = await db.select(db.billItemProperties).get();
    var billCoupons = await db.select(db.billCoupons).get();
    var vc;
  }

  Future deleteFist() async {
    var db = Get.find<AppDatabase>();
    await db.delete(db.billCoupons).go();
    await db.delete(db.billItemProperties).go();
    await db.delete(db.billItems).go();
    await db.delete(db.bills).go();
  }
}
