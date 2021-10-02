import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/Model/TableLocal.dart';

class SelectTableDialogController extends GetxController {
  final tableLocalDAO = Get.find<TableLocalDAO>();
  final listTable = <TableLocal>[].obs;
  final tableIDSelected = Rxn<int>();

  @override
  void onInit() async {
    super.onInit();

    listTable.value = tableLocalDAO.getTableWithStatus(TableStatus.Empty);
  }

  void onSelectTableID(int? tableID) {
    tableIDSelected.value = tableID;
  }

  void onBtnConfirm() {
    final tableID = tableIDSelected.value;
    if (tableID == null) return Utils.showSnackBar('Lỗi', 'Hãy chọn bàn trống');

    final table = tableLocalDAO.getTable(tableID);
    if (table == null) return Utils.showSnackBar('Lỗi', 'Bàn không tìm thấy');

    if (table.status != TableStatus.Empty)
      return Utils.showSnackBar('Lỗi', 'Bàn này không trống');

    Get.back(result: table);
  }
}
