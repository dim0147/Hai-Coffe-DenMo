import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/Model/TableLocal.dart';

class TableLocalInfoArgs {
  final int tableID;

  TableLocalInfoArgs(this.tableID);
}

class TableLocalInfoController extends GetxController
    with StateMixin<TableLocal> {
  final args = Utils.tryCast<TableLocalInfoArgs>(Get.arguments);
  final tableLocalDAO = Get.find<TableLocalDAO>();

  @override
  void onInit() async {
    super.onInit();

    // Get table ID arg
    final tableID = args?.tableID;
    if (tableID == null)
      return change(null,
          status: RxStatus.error('Argument Table ID not found'));

    // Get table
    final table = tableLocalDAO.getTable(tableID);
    if (table == null)
      return change(null,
          status: RxStatus.error('Không tìm thấy table, ID: $tableID'));

    change(table, status: RxStatus.success());
  }
}
