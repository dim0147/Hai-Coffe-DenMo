import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:moor/src/runtime/data_class.dart' as MOOR_RUNTIME;
import 'package:sentry_flutter/sentry_flutter.dart';

class EditCategoryScreenArgs {
  final int categoryId;

  EditCategoryScreenArgs(this.categoryId);
}

class EditCategoryController extends GetxController {
  final EditCategoryScreenArgs args = Get.arguments;

  final appDb = Get.find<AppDatabase>();
  late final CategoryDAO categoryDAO;

  final Rx<CBaseState> cState = CBaseState(CState.LOADING).obs;
  final category = Rxn<Category>();
  final nameC = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    final categoryId = args.categoryId;
    categoryDAO = CategoryDAO(appDb);
    final cState = this.cState.value;
    cState.setGetC(this.cState);

    try {
      category.value = await categoryDAO.findCategoryById(categoryId);
      if (category.value == null) {
        Utils.showSnackBar(
          'Lỗi',
          'Không tìm thấy category, Category Id: $categoryId',
        );
        cState.changeState(
          CState.ERROR,
          'Không tìm thấy category, Category Id: $categoryId',
        );
        return;
      }

      nameC.text = category.value!.name;
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

  void onSave() async {
    final cState = this.cState.value;
    try {
      String categoryName = nameC.text;

      // Not empty
      if (categoryName.length == 0)
        return Utils.showSnackBar('Lỗi', 'Hãy nhập tên');

      cState.changeState(CState.LOADING);
      // Check name is exist already
      final categoryExist = await categoryDAO.findCategoryByName(categoryName);
      if (categoryExist != null) {
        cState.changeState(CState.DONE);
        return Utils.showSnackBar(
          'Lỗi',
          "'$categoryName' đã tồn tại",
        );
      }

      // Edit
      final categoryCompanion =
          CategoriesCompanion(name: MOOR_RUNTIME.Value(categoryName));
      await categoryDAO.updateCategoryById(
        category.value!.id,
        categoryCompanion,
      );
      cState.changeState(CState.DONE);
      Utils.showSnackBar('Thành công', 'Chỉnh sửa thành công');
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
