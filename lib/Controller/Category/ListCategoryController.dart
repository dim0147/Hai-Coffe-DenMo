import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Category/EditCategoryController.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ListCategoryController extends GetxController {
  final appDB = Get.find<AppDatabase>();
  late final CategoryDAO categoryDAO;

  final Rx<CBaseState> cState = CBaseState(CState.LOADING).obs;
  final categories = <Category>[].obs;

  void onInit() async {
    super.onInit();
    categoryDAO = CategoryDAO(appDB);
    final cState = this.cState.value;
    cState.setGetC(this.cState);
    try {
      categories.value = await categoryDAO.listAllCategory();
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

  void refreshListCategory() async {
    categories.value = await categoryDAO.listAllCategory();
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
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }

  void onFloatingBtn() {
    Get.offNamed('/category/add');
  }
}
