import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Category/EditCategoryController.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DB/Database.dart';

class ListCategoryController extends GetxController
    with StateMixin<List<Category>> {
  final appDB = Get.find<AppDatabase>();
  late final CategoryDAO categoryDAO;

  final categories = <Category>[].obs;

  void onInit() async {
    try {
      super.onInit();
      categoryDAO = CategoryDAO(appDB);
      categories.value = await categoryDAO.listAllCategory();
      change(categories, status: RxStatus.success());
    } catch (err) {
      change(null,
          status: RxStatus.error('Có lỗi xảy ra:\n ${err.toString()}'));
    }
  }

  void refreshListCategory() async {
    categories.value = await categoryDAO.listAllCategory();
    change(categories, status: RxStatus.success());
  }

  void onEditListItem(int categoryId) async {
    final args = EditCategoryScreenArgs(categoryId);
    await Get.toNamed('/category/edit', arguments: args);
    refreshListCategory();
  }

  void onRemoveListItem(int categoryId) async {
    try {
      final resultDialog = await Utils.showDialog<bool>(
        'Chú ý',
        'Bạn có muốn xoá?',
        onConfirm: () => Get.back(result: true),
        onCancel: () {},
      );

      if (resultDialog == null || resultDialog == false) return;

      await categoryDAO.deleteCategoryById(categoryId);

      refreshListCategory();

      Utils.showSnackBar('Thành công', 'Xoá danh mục thành công');
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }

  void onFloatingBtn() {
    Get.offNamed('/category/add');
  }
}
