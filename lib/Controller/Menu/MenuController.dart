import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillController.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/Controller/Menu/CartController.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Cart.dart' as CartModel;
import 'package:hai_noob/Model/ConfigGlobal.dart';
import 'package:hai_noob/Model/TableLocal.dart';
import 'package:hai_noob/Screen/Menu/SelectTableDialogScreen.dart';

class MenuScreenArgs {
  final int? tableID;

  MenuScreenArgs({this.tableID});
}

class ItemDataDisplay extends ItemDataClass {
  int quality;

  ItemDataDisplay({
    required Item item,
    List<Category>? categories,
    List<ItemProperty>? properties,
    required this.quality,
  }) : super(item: item, categories: categories, properties: properties);
}

class MenuController extends GetxController with SingleGetTickerProviderMixin {
  final MenuScreenArgs args = Get.arguments;
  final AppDatabase db = Get.find<AppDatabase>();
  final TableLocalDAO tableLocalDAO = Get.find<TableLocalDAO>();
  late ItemsDAO itemsDAO;
  late CategoryDAO categoryDAO;

  final Rx<CBaseState> cState = CBaseState(CState.LOADING).obs;
  final Rx<CartModel.Cart> cart = CartModel.Cart(items: []).obs;
  final Rxn<int> tableIDLocal = Rxn<int>();
  final RxString tableName = ''.obs;
  final RxList<ItemDataDisplay> itemsDataDisplay = <ItemDataDisplay>[].obs;
  final RxList<Category> categories = <Category>[].obs;
  final Rxn<int> choosenCategoryId = Rxn<int>();
  final searchString = ''.obs;

  Future<void> setDefaultArgs() async {
    final int? tableID = args.tableID;
    if (tableID == null) return;

    // Get cart table
    final table = tableLocalDAO.getTable(tableID);
    if (table == null)
      return Future.error(
        'Table not exist in TableLocal, tableID:' + tableID.toString(),
      );

    tableIDLocal.value = tableID;
    tableName.value = table.name;
    cart.value = table.cart;
  }

  @override
  void onInit() async {
    super.onInit();
    itemsDAO = ItemsDAO(db);
    categoryDAO = CategoryDAO(db);

    final CBaseState cState = this.cState.value;
    cState.setGetC(this.cState);

    try {
      await setDefaultArgs();

      // Get menu items
      final List<ItemDataClass> menuItems = await itemsDAO.getAllItemsInMenu();
      final List<ItemDataDisplay> itemDataDisplayList = menuItems
          .map((e) => ItemDataDisplay(
                item: e.item,
                categories: e.categories,
                properties: e.properties,
                quality: 0,
              ))
          .toList();
      this.itemsDataDisplay.value = itemDataDisplayList;

      // Get categories
      categories.value = await categoryDAO.listAllCategory();

      // Assign default as the first category
      if (categories.length > 0) choosenCategoryId.value = categories.first.id;
      cState.changeState(CState.DONE);
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
    }
  }

  void changeCategory(int? categoryId) {
    choosenCategoryId.value = categoryId;
  }

  void onChangeSearchString(String? string) {
    if (string == null) {
      searchString.value = '';
      return;
    }

    searchString.value = string;
  }

  void increaseItem(ItemDataDisplay item) async {
    final List<ItemProperty>? propertyList = item.properties;
    final CartModel.CartItem newCartItem;

    if (propertyList != null) {
      // Add item have properties, user may press cancel button in AddSpecialItemScreen, if this happen return null
      final CartModel.CartItem? newCartItemMayCancel =
          await createCartItemHaveProperty(
        item,
        propertyList,
      );
      if (newCartItemMayCancel == null) return;

      newCartItem = newCartItemMayCancel;
    } else {
      // Add item without properties
      newCartItem = createCartItemWithoutProperty(item);
    }

    // Add new or increate item in cart
    cart.value.addItemByCartItem(newCartItem);
    cart.refresh();

    // Update itemDisplayData
    final List<ItemDataDisplay> newItemDisplayDataList = itemsDataDisplay.map(
      (e) {
        if (e.item.id == item.item.id) e.quality += newCartItem.totalQuantity;

        return e;
      },
    ).toList();
    updateItemDisplayDataList(newItemDisplayDataList);
  }

  Future<CartModel.CartItem?> createCartItemHaveProperty(
    ItemDataDisplay item,
    List<ItemProperty> propertyList,
  ) async {
    // Create propertiesInCartItem from propertyList
    final List<CartModel.CartItemProperty> propertiesInCartItem = propertyList
        .map(
          (e) => CartModel.CartItemProperty(
            name: e.name,
            amount: e.amount,
            quantity: 0,
          ),
        )
        .toList();

    // Create new Cart Item
    final CartModel.CartItem cartItem = CartModel.CartItem(
      totalQuantity: 1,
      totalPrice: item.item.price,
      item: CartModel.Item(
        id: item.item.id,
        name: item.item.name,
        price: item.item.price,
        img: item.item.image,
      ),
      properties: propertiesInCartItem,
    );

    // Navigate to AddSpecialItemScreen
    final CartModel.CartItem? newCartItem = await Get.toNamed(
      '/menu/add-special-item',
      arguments: cartItem,
    ) as CartModel.CartItem?;

    return newCartItem;
  }

  CartModel.CartItem createCartItemWithoutProperty(ItemDataDisplay item) {
    final CartModel.CartItem newCartItem = CartModel.CartItem(
      totalQuantity: 1,
      totalPrice: item.item.price,
      item: CartModel.Item(
        id: item.item.id,
        name: item.item.name,
        price: item.item.price,
        img: item.item.image,
      ),
      properties: [],
    );
    return newCartItem;
  }

  void decreaseItem(ItemDataDisplay item) {
    cart.value.decreaseItem(itemId: item.item.id);
    cart.refresh();

    final List<ItemDataDisplay> newItemDisplayDataList =
        itemsDataDisplay.map((e) {
      if (e.item.id == item.item.id) {
        int quantityDecrease = 1;
        e.quality -= quantityDecrease;
        if (e.quality <= 0) e.quality = 0;
      }

      return e;
    }).toList();
    updateItemDisplayDataList(newItemDisplayDataList);
  }

  void updateItemDisplayDataList(List<ItemDataDisplay> itemDisplayDataList) {
    itemsDataDisplay.value = itemDisplayDataList;
    itemsDataDisplay.refresh();
  }

  void onClickShowCart() async {
    final cartScreenArgs = CartScreenArgs(
      tableID: tableIDLocal.value,
      cart: cart.value,
    );
    await Get.toNamed('/menu/cart', arguments: cartScreenArgs);

    // Refresh cart if have any update
    cart.refresh();
    itemsDataDisplay.refresh();
  }

  void onClickPayment() async {
    final placeOrderScreenArgs =
        PlaceBillScreenArgs(cart: cart.value, tableID: tableIDLocal.value);
    Get.toNamed('/place-bill', arguments: placeOrderScreenArgs);
  }

  void onClickSelectTable() async {
    try {
      final table = await Get.defaultDialog<TableLocal?>(
        title: 'Chọn Bàn',
        backgroundColor: AppConfig.BACKGROUND_COLOR,
        content: SelectTableDialogScreen(),
      );

      // If dont select
      if (table == null) return;

      // Set cart table  and update table cart
      cart.value.tableId = table.id;
      await tableLocalDAO.updateTable(
        table.id,
        cart: cart.value,
        status: TableStatus.Holding,
      );

      // Set display field
      tableIDLocal.value = table.id;
      tableName.value = table.name;
      Utils.showSnackBar('Thành công', 'Chọn bàn ${table.name} thành công');
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }

  int showItemQuantity(int itemId) {
    return cart.value.items
        .where((e) => e.item.id == itemId)
        .fold(0, (previousValue, e) => previousValue + e.totalQuantity);
  }
}
