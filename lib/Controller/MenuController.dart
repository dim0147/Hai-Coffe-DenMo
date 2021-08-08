import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController with SingleGetTickerProviderMixin {
  TabController? _tabController;
  get tabController => this._tabController;

  late List<Tab> tabs;

  final isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = false;
    _tabController = TabController(length: 2, vsync: this);
    tabs = <Tab>[
      Tab(text: 'LEFT'),
      Tab(text: 'RIGHT'),
    ];
  }
}
