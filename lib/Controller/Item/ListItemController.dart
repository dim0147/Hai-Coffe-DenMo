import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';

class ListItemController extends GetxController
    with StateMixin<List<ItemDataClass>> {
  final appDB = Get.find<AppDatabase>();
  late final ItemsDAO itemDAO;

  final itemDatas = <ItemDataClass>[].obs;

  final searchString = ''.obs;

  void onInit() async {
    try {
      super.onInit();
      itemDAO = ItemsDAO(appDB);
      itemDatas.value = await itemDAO.getAllItems();
      change(itemDatas, status: RxStatus.success());
    } catch (err) {
      change(null,
          status: RxStatus.error('Có lỗi xảy ra:\n ${err.toString()}'));
    }
  }

  void onChangeSearchBar(String? string) {
    if (string == null) return;
    searchString.value = string;
    change(itemDatas, status: RxStatus.success());
  }

  void refreshListItem() async {
    itemDatas.value = await itemDAO.getAllItems();
    change(itemDatas, status: RxStatus.success());
  }

  void onEditListItem(int categoryId) async {
    // final args = EditCategoryScreenArgs(categoryId);
    // await Get.toNamed('/category/edit', arguments: args);
    refreshListItem();
  }

  void onRemoveListItem(int itemId) async {
    try {
      final resultDialog = await Utils.showDialog<bool>(
        'Chú ý',
        'Bạn có muốn xoá?',
        onConfirm: () => Get.back(result: true),
        onCancel: () {},
      );

      if (resultDialog == null || resultDialog == false) return;

      await itemDAO.deleteItemByItemId(itemId);
      refreshListItem();

      Utils.showSnackBar('Thành công', 'Xoá Item thành công');
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }
}
