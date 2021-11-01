import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/Controller/Table/EditTableController.dart';
import 'package:hai_noob/DAO/TableOrderDAO.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/TableLocal.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ListTableController extends GetxController {
  final AppDatabase appDb = Get.find<AppDatabase>();

  final TableLocalDAO tableLocalDAO = Get.find<TableLocalDAO>();
  late final TableOrderDAO tableOrderDAO;

  final Rx<CBaseState> cState = CBaseState(CState.LOADING).obs;
  final RxList<TableLocal> listTables = <TableLocal>[].obs;

  @override
  void onInit() async {
    super.onInit();
    tableOrderDAO = TableOrderDAO(appDb);
    final CBaseState cState = this.cState.value;
    cState.setGetC(this.cState);

    try {
      listTables.value = tableLocalDAO.getAllWithList();
      listTables.bindStream(tableLocalDAO.getTableLocalsStream());
      cState.changeState(CState.DONE);
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }

  void onEditListItem(int itemId) async {
    final EditTableScreenArgs args = EditTableScreenArgs(itemId);
    await Get.toNamed('/table/edit', arguments: args);
  }

  void onRemoveListItem(int itemId) async {
    try {
      await tableOrderDAO.removeTable(itemId);
      await tableLocalDAO.removeTable(itemId);
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }

  void onFloatingBtn() {
    Get.offNamed('/table/add');
  }
}
