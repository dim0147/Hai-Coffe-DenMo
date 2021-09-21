import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/DAO/TableDAO.dart';
import 'package:hai_noob/DB/Database.dart';

class AddTableController extends GetxController {
  late final TableOrderDAO tableOrderDAO;
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
        return Get.snackbar('Lỗi', 'Tên không được để trống');
      if (order == null) return Get.snackbar('Lỗi', 'Thứ tự không hợp lệ');

      var tableOrderKnowledge = await tableOrderDAO.findTableByName(name);
      if (tableOrderKnowledge != null)
        return Get.snackbar('Lỗi', 'Bàn \' $name\' đã tồn tại');

      await tableOrderDAO.createTable(name, order);
      Get.offAllNamed('/menu');
      Get.snackbar('Thành công', 'Tạo bàn \' $name\' thành công!');
    } catch (err) {
      Get.snackbar('Lỗi', 'Có lỗi xảy ra:\n ${err.toString()}');
    }
  }
}
