import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/DAO/TableOrderDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:moor/src/runtime/data_class.dart' as moorRuntime;

class EditTableScreenArgs {
  final int tableId;

  EditTableScreenArgs(this.tableId);
}

class EditTableController extends GetxController {
  final EditTableScreenArgs args = Get.arguments;
  late final TableOrderDAO tableOrderDAO;
  final TableLocalDAO tableLocalDAO = Get.find<TableLocalDAO>();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController orderC = TextEditingController();

  @override
  void onInit() async {
    try {
      super.onInit();

      final AppDatabase db = Get.find<AppDatabase>();
      tableOrderDAO = TableOrderDAO(db);

      final TableOrder? table = await tableOrderDAO.findTableById(args.tableId);
      if (table == null) {
        return Utils.showSnackBar('Lỗi', 'Bàn không tìm thấy');
      }

      nameC.text = table.name;
      orderC.text = table.order.toString();
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }

  void onSave() async {
    try {
      final String name = nameC.text;
      final int? order = int.tryParse(orderC.text);

      if (name.length == 0)
        return Utils.showSnackBar('Lỗi', 'Tên không được để trống');
      if (order == null)
        return Utils.showSnackBar('Lỗi', 'Thứ tự không hợp lệ');

      // Update on DB
      final TableOrdersCompanion tableUpdate = TableOrdersCompanion(
        name: moorRuntime.Value(name),
        order: moorRuntime.Value(order),
      );
      await tableOrderDAO.updateTable(args.tableId, tableUpdate);

      // Update to table locaL
      await tableLocalDAO.updateTable(args.tableId, name: name, order: order);

      Get.back();
      Utils.showSnackBar('Thành công', 'Lưu bàn \'$name\' thành công');
      orderC.text = (int.parse(orderC.text) + 1).toString();
    } catch (err) {
      Utils.showSnackBar('Lỗi', 'Có lỗi xảy ra:\n ${err.toString()}');
    }
  }
}
