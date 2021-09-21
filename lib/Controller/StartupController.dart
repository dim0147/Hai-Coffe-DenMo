import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
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
      // Init Database Services
      statusText.value = 'Đang khởi tạo database...';
      await Get.putAsync(() => DbService().init(), permanent: true);

      // Init Hiv services
      statusText.value = 'Đang khởi tạo Hiv services...';
      await Get.putAsync(() => HivService().init(), permanent: true);

      // Init global config
      statusText.value = 'Đang khởi tạo config...';
      await Get.putAsync(() => ConfigService().init(), permanent: true);

      // Done
      statusText.value = 'Khởi tạo thành công';
      change(null, status: RxStatus.success());

      // Redirect
      Get.offNamed(AppConfig.initRoute);

      // queryTestData();
    } catch (error) {
      change(null, status: RxStatus.error());
      statusText.value =
          'Có lỗi khi khởi tạo, liên hệ anh đức đẹp trai, lỗi: ${error.toString()}';
    }
  }

  void queryTestData() async {
    var db = Get.find<AppDatabase>();

    // await deleteFist();

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
