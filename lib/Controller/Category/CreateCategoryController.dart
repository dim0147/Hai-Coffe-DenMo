import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DB/Database.dart';

class CreateCategoryController extends GetxController {
  final TextEditingController nameC = TextEditingController();
  final AppDatabase db = Get.find<AppDatabase>();
  late final CategoryDAO categoryDAO;

  final Rx<CBaseState> cState = CBaseState(CState.DONE).obs;

  @override
  void onInit() async {
    super.onInit();
    categoryDAO = CategoryDAO(db);

    final cState = this.cState.value;
    cState.setGetC(this.cState);
  }

  void onCreate() async {
    final cState = this.cState.value;
    try {
      String categoryName = nameC.text;
      if (categoryName.length == 0) {
        return Utils.showSnackBar(
          'Lỗi',
          "Hãy nhập tên",
        );
      }

      cState.changeState(CState.LOADING);
      final Category? categogy =
          await categoryDAO.findCategoryByName(categoryName);
      if (categogy != null) {
        cState.changeState(CState.DONE);
        return Utils.showSnackBar(
          'Lỗi',
          "'$categoryName' đã tồn tại",
        );
      }

      final newCategory = CategoriesCompanion.insert(name: nameC.text);
      await categoryDAO.addNew(newCategory);
      Utils.showSnackBar(
        'Thành công',
        "Tạo danh mục '$categoryName' thành công",
      );
      cState.changeState(CState.DONE);
      nameC.clear();
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
    }
  }
}
