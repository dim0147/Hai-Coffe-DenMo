import 'package:get/get.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/Model/TableLocal.dart';

class TablePanelController extends GetxController {
  final _tableLocalDAO = Get.find<TableLocalDAO>();
  final tableLocals = <TableLocal>[].obs;

  @override
  void onInit() {
    super.onInit();
    tableLocals.value = _tableLocalDAO.getAllWithList();
    tableLocals.bindStream(_tableLocalDAO.getTableLocalsStream());
  }

  void onClick() {
    _tableLocalDAO.markTableHolding(1);
  }
}
