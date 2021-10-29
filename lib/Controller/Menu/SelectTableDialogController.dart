import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/Model/TableLocal.dart';

class SelectTableDialogController extends GetxController {
  final TableLocalDAO tableLocalDAO = Get.find<TableLocalDAO>();
  final RxList<TableLocal> listTable = <TableLocal>[].obs;
  final Rxn<int> tableIDSelected = Rxn<int>();

  @override
  void onInit() async {
    super.onInit();

    listTable.value = tableLocalDAO.getTableWithStatus(TableStatus.Empty);
  }

  void onSelectTableID(int? tableID) {
    tableIDSelected.value = tableID;
  }

  void onBtnConfirm() {
    final int? tableID = tableIDSelected.value;
    if (tableID == null) return Utils.showSnackBar('Lỗi', 'Hãy chọn bàn trống');

    final TableLocal? table = tableLocalDAO.getTable(tableID);
    if (table == null) return Utils.showSnackBar('Lỗi', 'Bàn không tìm thấy');

    if (table.status != TableStatus.Empty)
      return Utils.showSnackBar('Lỗi', 'Bàn này không trống');

    Get.back(result: table);
  }
}
