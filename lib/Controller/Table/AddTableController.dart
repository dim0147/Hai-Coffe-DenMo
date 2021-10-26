import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/DAO/TableOrderDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Cart.dart';
import 'package:hai_noob/Model/TableLocal.dart';

class AddTableController extends GetxController {
  late final TableOrderDAO tableOrderDAO;
  final tableLocalDAO = Get.find<TableLocalDAO>();
  final nameC = TextEditingController();
  final orderC = TextEditingController();

  @override
  void onInit() async {
    super.onInit();

    var db = Get.find<AppDatabase>();
    tableOrderDAO = TableOrderDAO(db);

    // Get highest table order
    final highestOrder = await tableOrderDAO.getHighestTableOrder();
    if (highestOrder == null)
      orderC.text = '1';
    else {
      orderC.text = (highestOrder + 1).toString();
    }
  }

  void onAdd() async {
    try {
      String name = nameC.text;
      int? order = int.tryParse(orderC.text);

      if (name.length == 0)
        return Utils.showSnackBar('Lỗi', 'Tên không được để trống');
      if (order == null)
        return Utils.showSnackBar('Lỗi', 'Thứ tự không hợp lệ');

      var tableOrderKnowledge = await tableOrderDAO.findTableByName(name);
      if (tableOrderKnowledge != null)
        return Utils.showSnackBar('Lỗi', 'Bàn \' $name\' đã tồn tại');

      int tableID = await tableOrderDAO.createTable(name, order);

      // Add to table locaL
      final newTableLocal = TableLocal(
        id: tableID,
        name: name,
        cart: Cart(tableId: tableID, items: []),
        order: order,
      );
      await tableLocalDAO.addNew(newTableLocal);

      Utils.showSnackBar('Thành công', 'Tạo bàn \'$name\' thành công');
      orderC.text = (int.parse(orderC.text) + 1).toString();
    } catch (err) {
      Utils.showSnackBar('Lỗi', 'Có lỗi xảy ra:\n ${err.toString()}');
    }
  }
}
