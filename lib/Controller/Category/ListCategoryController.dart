import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
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

  void onEditListItem(int categoryId) {
    Get.defaultDialog(onConfirm: () {}, onCancel: () {});
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

      categories.value =
          categories.value.where((e) => e.id != categoryId).toList();
      change(categories, status: RxStatus.success());

      Utils.showSnackBar('Thành công', 'Xoá danh mục thành công');
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }
}
