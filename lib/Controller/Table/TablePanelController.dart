import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/Model/TableLocal.dart';

enum TableAction {
  GO_PAYMENT,
  MARK_EMPTY,
  MARK_HOLDING,
  CLEAR_CART,
}

class TablePanelController extends GetxController {
  final _tableLocalDAO = Get.find<TableLocalDAO>();
  final tableLocals = <TableLocal>[].obs;

  @override
  void onInit() {
    super.onInit();
    tableLocals.value = _tableLocalDAO.getAllWithList();
    tableLocals.bindStream(_tableLocalDAO.getTableLocalsStream());
  }

  void onTableAction(int tableID, TableAction? action) {}

  void onTapTable(int tableID) {
    _tableLocalDAO.markTableHolding(1);
  }
}
