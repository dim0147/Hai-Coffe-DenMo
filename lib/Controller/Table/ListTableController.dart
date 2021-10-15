import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/TableOrderDAO.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/TableLocal.dart';

class ListTableController extends GetxController
    with StateMixin<List<TableLocal>> {
  final AppDatabase appDb = Get.find<AppDatabase>();

  final TableLocalDAO tableLocalDAO = Get.find<TableLocalDAO>();
  late final TableOrderDAO tableOrderDAO;

  final RxList<TableLocal> listTables = <TableLocal>[].obs;

  @override
  void onInit() {
    super.onInit();
    listTables.value = tableLocalDAO.getAllWithList();
    listTables.bindStream(tableLocalDAO.getTableLocalsStream());

    tableOrderDAO = TableOrderDAO(appDb);

    change(listTables, status: RxStatus.success());
  }

  void onEditListItem(int itemId) async {}

  void onRemoveListItem(int itemId) async {
    try {
      await tableOrderDAO.removeTable(itemId);
      await tableLocalDAO.removeTable(itemId);
      change(listTables, status: RxStatus.success());
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }
}
