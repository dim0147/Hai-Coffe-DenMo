import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DB/Database.dart';

class CreateCategoryController extends GetxController with StateMixin<String> {
  final TextEditingController nameC = TextEditingController();
  AppDatabase? db;
  CategoryDAO? categoryDAO;

  @override
  void onInit() async {
    change(null, status: RxStatus.success());
    super.onInit();
    db = Get.find<AppDatabase>();
    categoryDAO = CategoryDAO(db!);
  }

  void onCreate() async {
    try {
      String categoryName = nameC.text;

      // Not empty
      if (categoryName.length == 0) {
        return change(null, status: RxStatus.error('Hãy nhập tên'));
      }

      // Check exist already
      var categoryExist = await categoryDAO!.findCategoryByName(categoryName);
      if (categoryExist != null) {
        return change(null,
            status: RxStatus.error("'$categoryName' đã tồn tại"));
      }

      // Create new one
      change(null, status: RxStatus.loading());
      CategoriesCompanion newCategory =
          CategoriesCompanion.insert(name: nameC.text);
      await categoryDAO!.addNew(newCategory);

      // Notify on screen
      nameC.clear();
      change(
        "Tạo danh mục '$categoryName' thành công",
        status: RxStatus.success(),
      );
    } catch (err) {
      return change(null,
          status: RxStatus.error(
              'Có lỗi xảy ra, báo cáo anh đức lìn: ${err.toString()}'));
    }
  }
}
