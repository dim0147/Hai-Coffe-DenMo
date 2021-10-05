import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Item/EditItemController.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Item.dart';

class ListItemController extends GetxController
    with StateMixin<List<ItemDataClass>> {
  final appDB = Get.find<AppDatabase>();
  late final ItemsDAO itemDAO;

  final itemDatas = <ItemDataClass>[].obs;

  final searchString = ''.obs;
  final visibilityFilter = Rxn<bool>();

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

  void onChangeFilterStatus(bool? visibility) {
    visibilityFilter.value = visibility;
    change(itemDatas, status: RxStatus.success());
  }

  void refreshListItem() async {
    itemDatas.value = await itemDAO.getAllItems();
    change(itemDatas, status: RxStatus.success());
  }

  void onEditListItem(int itemId) async {
    final args = EditItemScreenArgs(itemId);
    await Get.toNamed('/item/edit', arguments: args);
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
