import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Menu/MenuController.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillController.dart';
import 'package:hai_noob/Controller/Table/TableLocalInfoController.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/Model/Cart.dart';
import 'package:hai_noob/Model/TableLocal.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

enum TableAction {
  GO_PAYMENT,
  MARK_EMPTY,
  MARK_HOLDING,
  CLEAR_CART,
  SEE_INFO,
}

enum ViewTableOption {
  ALL,
  EMPTY,
  HOLDING,
}

class TablePanelController extends GetxController {
  final TableLocalDAO _tableLocalDAO = Get.find<TableLocalDAO>();
  final RxList<TableLocal> tableLocals = <TableLocal>[].obs;
  final Rx<ViewTableOption> viewOption = ViewTableOption.ALL.obs;

  @override
  void onInit() {
    super.onInit();
    tableLocals.value = _tableLocalDAO.getAllWithList();
    tableLocals.bindStream(_tableLocalDAO.getTableLocalsStream());
  }

  void onChangeViewTableOption(ViewTableOption option) {
    viewOption.value = option;
  }

  void onTableAction(int tableID, TableAction? action) {
    if (action == null) return;

    // Get tabble
    final TableLocal? table = _tableLocalDAO.getTable(tableID);
    if (table == null)
      return Utils.showSnackBar(
          'Lỗi', 'Table không tìm thấy, ID: ${tableID.toString()}');

    switch (action) {
      case TableAction.MARK_EMPTY:
        markTableEmpty(tableID);
        break;
      case TableAction.MARK_HOLDING:
        markTableHolding(tableID);
        break;
      case TableAction.CLEAR_CART:
        cleatTableCart(tableID);
        break;
      case TableAction.GO_PAYMENT:
        makePayment(table, tableID);
        break;
      case TableAction.SEE_INFO:
        seeTableLocalInfo(tableID);
        break;
      default:
    }
  }

  void markTableEmpty(int tableID) {
    _tableLocalDAO.updateTable(
      tableID,
      status: TableStatus.Empty,
      cart: Cart(tableId: tableID, items: []),
    );
  }

  void markTableHolding(int tableID) {
    _tableLocalDAO.updateTable(
      tableID,
      status: TableStatus.Holding,
    );
  }

  void cleatTableCart(int tableID) {
    _tableLocalDAO.updateTable(
      tableID,
      cart: Cart(tableId: tableID, items: []),
    );
  }

  void makePayment(TableLocal table, int tableID) {
    final placeOrderScreenArgs = PlaceBillScreenArgs(
      cart: table.cart,
      tableID: tableID,
    );
    Get.toNamed('/place-bill', arguments: placeOrderScreenArgs);
  }

  void seeTableLocalInfo(int tableID) {
    final tableLocalInfoArgs = TableLocalInfoArgs(tableID);
    Get.toNamed('/table/local-info', arguments: tableLocalInfoArgs);
  }

  void onTapTable(int tableID) async {
    try {
      // Get table
      final TableLocal? table = _tableLocalDAO.getTable(tableID);
      if (table == null)
        return Utils.showSnackBar(
            'Lỗi', 'Không tìm thấy bàn ID: ' + tableID.toString());

      // Change HOLDING status
      if (table.status == TableStatus.Empty)
        await _tableLocalDAO.updateTable(tableID, status: TableStatus.Holding);

      // Go to menu
      final MenuScreenArgs menuScreenArgs = MenuScreenArgs(tableID: tableID);
      Get.toNamed('/menu', arguments: menuScreenArgs);
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }
}
