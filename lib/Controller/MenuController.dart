import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';

class MenuController extends GetxController with SingleGetTickerProviderMixin {
  AppDatabase db = Get.find<AppDatabase>();
  late ItemsDAO itemsDAO;

  // Tab controller
  late TabController _tabController;
  get tabController => this._tabController;
  late List<Tab> tabs;

  // Loading value
  final isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();

    // Init tab
    _tabController = TabController(length: 2, vsync: this);
    tabs = <Tab>[
      Tab(text: 'LEFT'),
      Tab(text: 'RIGHT'),
    ];

    itemsDAO = ItemsDAO(db);
    isLoading.value = false;

    List<ItemDataClass> items = await itemsDAO.getAllItems();
  }
}
