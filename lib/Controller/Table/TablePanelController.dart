import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Menu/MenuController.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderController.dart';
import 'package:hai_noob/Controller/Table/TableLocalInfoController.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/Model/Cart.dart';
import 'package:hai_noob/Model/TableLocal.dart';

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
  final _tableLocalDAO = Get.find<TableLocalDAO>();
  final tableLocals = <TableLocal>[].obs;
  final viewOption = ViewTableOption.ALL.obs;

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
    final table = _tableLocalDAO.getTable(tableID);
    if (table == null)
      return Utils.showSnackBar(
          'Lỗi', 'Table không tìm thấy, ID: ${tableID.toString()}');

    switch (action) {
      case TableAction.MARK_EMPTY:
        _tableLocalDAO.updateTable(
          tableID,
          status: TableStatus.Empty,
          cart: Cart(tableId: tableID, items: []),
        );
        break;
      case TableAction.MARK_HOLDING:
        _tableLocalDAO.updateTable(
          tableID,
          status: TableStatus.Holding,
        );
        break;
      case TableAction.CLEAR_CART:
        _tableLocalDAO.updateTable(
          tableID,
          cart: Cart(tableId: tableID, items: []),
        );
        break;
      case TableAction.GO_PAYMENT:
        final placeOrderScreenArgs = PlaceOrderScreenArgs(
          cart: table.cart,
          tableID: tableID,
        );
        Get.toNamed('/place-order', arguments: placeOrderScreenArgs);
        break;
      case TableAction.SEE_INFO:
        final tableLocalInfoArgs = TableLocalInfoArgs(tableID);
        Get.toNamed('/table/local-info', arguments: tableLocalInfoArgs);
        break;
      default:
    }
  }

  void onTapTable(int tableID) async {
    try {
      // Get table
      final table = _tableLocalDAO.getTable(tableID);
      if (table == null)
        return Utils.showSnackBar(
            'Lỗi', 'Không tìm thấy bàn ID: ' + tableID.toString());

      // Change HOLDING status
      if (table.status == TableStatus.Empty)
        await _tableLocalDAO.updateTable(tableID, status: TableStatus.Holding);

      // Go to menu
      final menuScreenArgs = MenuScreenArgs(tableID: tableID);
      Get.toNamed('/menu', arguments: menuScreenArgs);
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }
}
