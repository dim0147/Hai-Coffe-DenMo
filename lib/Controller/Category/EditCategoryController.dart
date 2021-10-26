import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:moor/src/runtime/data_class.dart' as MOOR_RUNTIME;

class EditCategoryScreenArgs {
  final int categoryId;

  EditCategoryScreenArgs(this.categoryId);
}

class EditCategoryController extends GetxController with StateMixin<Category> {
  final args = Utils.tryCast<EditCategoryScreenArgs>(Get.arguments);

  final appDb = Get.find<AppDatabase>();
  late final CategoryDAO categoryDAO;
  final category = Rxn<Category>();

  final nameC = TextEditingController();

  @override
  void onInit() async {
    try {
      super.onInit();
      final categoryId = args?.categoryId;
      if (categoryId == null)
        return change(null, status: RxStatus.error('Category Id không có'));

      categoryDAO = CategoryDAO(appDb);

      category.value = await categoryDAO.findCategoryById(categoryId);
      if (category.value == null)
        return change(null,
            status: RxStatus.error(
                'Không tìm thấy category, Category Id: $categoryId'));

      nameC.text = category.value!.name;
      change(category.value, status: RxStatus.success());
    } catch (err) {
      return change(null, status: RxStatus.error(err.toString()));
    }
  }

  void onSave() async {
    try {
      String categoryName = nameC.text;
      if (category.value == null)
        return change(null, status: RxStatus.error('Danh mục không tồn tại'));

      // Not empty
      if (categoryName.length == 0) {
        return change(null, status: RxStatus.error('Hãy nhập tên'));
      }

      // Check name is exist already
      final categoryExist = await categoryDAO.findCategoryByName(categoryName);
      if (categoryExist != null) {
        return change(null,
            status: RxStatus.error("'$categoryName' đã tồn tại"));
      }

      // Edit
      change(null, status: RxStatus.loading());
      final categoryCompanion =
          CategoriesCompanion(name: MOOR_RUNTIME.Value(categoryName));
      await categoryDAO.updateCategoryById(
        category.value!.id,
        categoryCompanion,
      );

      change(null, status: RxStatus.success());
      Utils.showSnackBar('Thành công', 'Chỉnh sửa thành công');
    } catch (err) {
      return change(null,
          status: RxStatus.error(
              'Có lỗi xảy ra, báo cáo anh đức lìn: \n${err.toString()}'));
    }
  }
}
