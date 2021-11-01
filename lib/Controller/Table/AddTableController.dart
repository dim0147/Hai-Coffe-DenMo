import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/DAO/TableOrderDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Cart.dart';
import 'package:hai_noob/Model/TableLocal.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AddTableController extends GetxController {
  late final TableOrderDAO tableOrderDAO;
  final TableLocalDAO tableLocalDAO = Get.find<TableLocalDAO>();

  final TextEditingController nameC = TextEditingController();
  final TextEditingController orderC = TextEditingController();

  final Rx<CBaseState> cState = CBaseState(CState.LOADING).obs;

  @override
  void onInit() async {
    super.onInit();
    final AppDatabase db = Get.find<AppDatabase>();
    tableOrderDAO = TableOrderDAO(db);

    final CBaseState cState = this.cState.value;
    cState.setGetC(this.cState);

    try {
      // Get highest table order
      final int? highestOrder = await tableOrderDAO.getHighestTableOrder();
      cState.changeState(CState.DONE);
      if (highestOrder == null)
        orderC.text = '1';
      else {
        orderC.text = (highestOrder + 1).toString();
      }
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }

  void onAdd() async {
    final CBaseState cState = this.cState.value;
    try {
      final String name = nameC.text;
      final int? order = int.tryParse(orderC.text);

      if (name.length == 0)
        return Utils.showSnackBar('Lỗi', 'Tên không được để trống');
      if (order == null)
        return Utils.showSnackBar('Lỗi', 'Thứ tự không hợp lệ');

      cState.changeState(CState.LOADING);

      // Check table is exist
      final TableOrder? tableOrderKnowledge =
          await tableOrderDAO.findTableByName(name);
      if (tableOrderKnowledge != null) {
        cState.changeState(CState.DONE);
        return Utils.showSnackBar('Lỗi', 'Bàn \' $name\' đã tồn tại');
      }

      final int tableID = await tableOrderDAO.createTable(name, order);

      // Add to locaL table
      final TableLocal newTableLocal = TableLocal(
        id: tableID,
        name: name,
        cart: Cart(tableId: tableID, items: []),
        order: order,
      );
      await tableLocalDAO.addNew(newTableLocal);

      cState.changeState(CState.DONE);

      Utils.showSnackBar('Thành công', 'Tạo bàn \'$name\' thành công');
      orderC.text = (int.parse(orderC.text) + 1).toString();
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }
}
