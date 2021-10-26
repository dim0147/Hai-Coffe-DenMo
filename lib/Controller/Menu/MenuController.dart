import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Contants.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillController.dart';
import 'package:hai_noob/Controller/Menu/CartController.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Cart.dart' as CartModel;
import 'package:hai_noob/Model/TableLocal.dart';
import 'package:hai_noob/Screen/Menu/SelectTableDialogScreen.dart';

class MenuScreenArgs extends DefaultScreentArgs {
  final int? tableID;

  MenuScreenArgs({this.tableID, ShowSnackBarArgs? showSnackBarArgs})
      : super(showSnackBarArgs);
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
  final args = Utils.tryCast<MenuScreenArgs>(Get.arguments);
  final db = Get.find<AppDatabase>();
  final tableLocalDAO = Get.find<TableLocalDAO>();
  late ItemsDAO itemsDAO;
  late CategoryDAO categoryDAO;
  late final imgPath = Rxn<String>();

  // Data
  final cart = CartModel.Cart(items: []).obs;
  final tableIDLocal = Rxn<int>();
  final tableName = ''.obs;
  final itemsDataDisplay = <ItemDataDisplay>[].obs;
  final categories = <Category>[].obs;
  final choosenCategoryId = Rxn<int>();
  final searchString = ''.obs;

  // Loading value
  final isLoading = true.obs;

  Future<void> setArgs() async {
    final menuScreenArgument = args;
    if (menuScreenArgument == null) return;

    // For show snackbar
    menuScreenArgument.runOnInit();

    tableIDLocal.value = menuScreenArgument.tableID;
    if (tableIDLocal.value == null) return;

    // Get table cart
    final table = tableLocalDAO.getTable(tableIDLocal.value as int);
    if (table == null)
      return Future.error(
          'Table not exist in TableLocal, tableID:' + tableIDLocal.toString());

    tableName.value = table.name;
    cart.value = table.cart;
  }

  @override
  void onInit() async {
    super.onInit();

    try {
      await setArgs();

      // Init required
      itemsDAO = ItemsDAO(db);
      categoryDAO = CategoryDAO(db);
      imgPath.value = await Utils.getImgDirectory();

      // Get items
      List<ItemDataClass> items = await itemsDAO.getAllItemsInMenu();
      itemsDataDisplay.value = items
          .map((e) => ItemDataDisplay(
                item: e.item,
                categories: e.categories,
                properties: e.properties,
                quality: 0,
              ))
          .toList();

      // Get categories
      categories.value = await categoryDAO.listAllCategory();

      // Assign default choosen category
      if (categories.length > 0) choosenCategoryId.value = categories.first.id;

      isLoading.value = false;
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }

  void changeCategory(int? categoryId) {
    choosenCategoryId.value = categoryId;
  }

  void onChangeSearchString(String? string) {
    if (string == null) return;
    searchString.value = string;
  }

  void increaseItem(ItemDataDisplay item) async {
    var knowledgeItem =
        itemsDataDisplay.firstWhereOrNull((e) => e.item.id == item.item.id);

    if (knowledgeItem == null) return;

    // Add item with properties
    CartModel.CartItem? newCartItem;
    if (knowledgeItem.properties != null) {
      // Create propertiesInCartItem
      List<CartModel.CartItemProperty> propertiesInCartItem =
          knowledgeItem.properties != null
              ? knowledgeItem.properties!
                  .map((e) => CartModel.CartItemProperty(
                        name: e.name,
                        amount: e.amount,
                        quantity: 0,
                      ))
                  .toList()
              : [];
      // Create new Cart Item
      CartModel.CartItem cartItem = CartModel.CartItem(
          totalQuantity: 1,
          totalPrice: knowledgeItem.item.price,
          item: CartModel.Item(
            id: knowledgeItem.item.id,
            name: knowledgeItem.item.name,
            price: knowledgeItem.item.price,
            img: knowledgeItem.item.image,
          ),
          properties: propertiesInCartItem);
      // navigate to new screen
      newCartItem =
          await Get.toNamed('/menu/add-special-item', arguments: cartItem)
              as CartModel.CartItem?;

      // If null mean cancel
      if (newCartItem == null) return;

      // Add item with properties
      cart.value.addItemByCartItem(newCartItem);
    }
    // Add item without properties
    else {
      // Add or increase item to cart with non-special item, we create data return payload with quantity equal 1

      newCartItem = CartModel.CartItem(
          totalQuantity: 1,
          totalPrice: knowledgeItem.item.price,
          item: CartModel.Item(
            id: knowledgeItem.item.id,
            name: knowledgeItem.item.name,
            price: knowledgeItem.item.price,
            img: knowledgeItem.item.image,
          ),
          properties: []);

      cart.value.addItemByCartItem(newCartItem);
    }

    // Increase data display from current list
    List<ItemDataDisplay> newList = itemsDataDisplay.map((e) {
      if (e.item.id == item.item.id) {
        int quantityAdded = newCartItem != null ? newCartItem.totalQuantity : 1;

        e.quality += quantityAdded;
      }

      return e;
    }).toList();
    itemsDataDisplay.value = newList;
    itemsDataDisplay.refresh();
    cart.refresh();
  }

  void decreaseItem(ItemDataDisplay item) {
    cart.value.decreaseItem(itemId: item.item.id);
    cart.refresh();

    List<ItemDataDisplay> newList = itemsDataDisplay.map((e) {
      if (e.item.id == item.item.id) {
        int quantityDecrease = 1;
        e.quality -= quantityDecrease;
        if (e.quality <= 0) e.quality = 0;
      }

      return e;
    }).toList();
    itemsDataDisplay.value = newList;
  }

  int showItemQuantity(int itemId) {
    return cart.value.items
        .where((e) => e.item.id == itemId)
        .fold(0, (previousValue, e) => previousValue + e.totalQuantity);
  }

  void onClickShowCart() async {
    // navigate to new screen
    final cartScreenArgs =
        CartScreenArgs(tableID: tableIDLocal.value, cart: cart.value);
    await Get.toNamed('/menu/cart', arguments: cartScreenArgs);
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

      // Set cart table local
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
}
