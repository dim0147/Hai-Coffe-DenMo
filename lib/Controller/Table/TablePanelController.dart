import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/Model/TableLocal.dart';

enum TableAction {
  GO_PAYMENT,
  MARK_EMPTY,
  MARK_HOLDING,
  CLEAR_CART,
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

  void onTableAction(int tableID, TableAction? action) {}

  void onTapTable(int tableID) {
    _tableLocalDAO.markTableHolding(1);
  }
}
