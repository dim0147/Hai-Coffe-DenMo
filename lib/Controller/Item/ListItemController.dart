import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/Controller/Item/EditItemController.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';

class ListItemController extends GetxController {
  final appDB = Get.find<AppDatabase>();
  late final ItemsDAO itemDAO;

  final Rx<CBaseState> cState = CBaseState(CState.LOADING).obs;
  final itemDatas = <ItemDataClass>[].obs;
  final searchString = ''.obs;
  final visibilityFilter = Rxn<bool>();

  void onInit() async {
    super.onInit();
    itemDAO = ItemsDAO(appDB);
    final cState = this.cState.value;
    cState.setGetC(this.cState);
    try {
      itemDatas.value = await itemDAO.getAllItems();
      cState.changeState(CState.DONE);
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
    }
  }

  void onChangeSearchBar(String? string) {
    if (string == null) return;
    searchString.value = string;
  }

  void onChangeFilterStatus(bool? visibility) {
    visibilityFilter.value = visibility;
  }

  void refreshListItem() async {
    itemDatas.value = await itemDAO.getAllItems();
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

  void onFloatingBtn() {
    Get.offNamed('/item/add');
  }
}
