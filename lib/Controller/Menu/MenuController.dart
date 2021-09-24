import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Contants.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Cart.dart' as CartModel;
import 'package:hai_noob/Screen/Order/PlaceOrderScreen.dart';

class MenuScreenArgs extends DefaultScreentArgs {
  final CartModel.Cart? cart;
  final int? tableID;

  MenuScreenArgs({this.cart, this.tableID, ShowSnackBarArgs? showSnackBarArgs})
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
  AppDatabase db = Get.find<AppDatabase>();
  late ItemsDAO itemsDAO;
  late CategoryDAO categoryDAO;
  late final imgPath = Rxn<String>();

  // Data
  final cart = CartModel.Cart(items: []).obs;
  int? tableId;
  final itemsDataDisplay = <ItemDataDisplay>[].obs;
  final categories = <Category>[].obs;
  final choosenCategoryId = Rxn<int>();

  // Loading value
  final isLoading = true.obs;

  void setArgs() {
    final args = Utils.tryCast<MenuScreenArgs>(Get.arguments);
    if (args == null) return;

    args.runOnInit();
    final cartArg = args.cart;
    final tableIdArg = args.tableID;

    if (cartArg != null) cart.value = cartArg;
    tableId = tableIdArg;
  }

  @override
  void onInit() async {
    super.onInit();

    try {
      setArgs();

      // Init required
      itemsDAO = ItemsDAO(db);
      categoryDAO = CategoryDAO(db);
      imgPath.value = await Utils.getImgDirectory();

      // Get items
      List<ItemDataClass> items = await itemsDAO.getAllItems();
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
    await Get.toNamed('/menu/cart', arguments: cart.value);
    cart.refresh();
    itemsDataDisplay.refresh();
  }

  void onClickPayment() async {
    Get.toNamed('/menu/place-order', arguments: cart.value);
  }
}
