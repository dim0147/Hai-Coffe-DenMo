import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/AddSpecialItemController.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Cart.dart' as CartModel;

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
  final itemsDataDisplay = <ItemDataDisplay>[].obs;
  final categories = <Category>[].obs;
  final choosenCategoryId = Rxn<int>();

  // Loading value
  final isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();

    try {
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
      Get.snackbar('Lỗi', err.toString());
    }
  }

  void changeCategory(int? categoryId) {
    choosenCategoryId.value = categoryId;
  }

  void increaseItem(ItemDataDisplay item) async {
    var knowledgeItem =
        itemsDataDisplay.firstWhereOrNull((e) => e.item.id == item.item.id);

    if (knowledgeItem == null) return;

    // Add Special item
    ItemDataReturn? itemAdded;
    if (knowledgeItem.properties != null) {
      // navigate to new screen
      itemAdded =
          await Get.toNamed('/menu/add-special-item', arguments: knowledgeItem)
              as ItemDataReturn?;

      // If null mean cancel
      if (itemAdded == null) return;

      // Add item with properties
      cart.value.addItem(item.item, itemAdded);
    } else {
      // Add or increase item to cart with non-special item, we create data return payload with quantity equal 1
      ItemDataReturn itemPayload = ItemDataReturn(
        id: knowledgeItem.item.id,
        propertiesAdded: List.empty(),
        quantity: 1,
        // We only add one item so total price equan item price
        totalPrice: knowledgeItem.item.price,
      );

      cart.value.addItem(item.item, itemPayload);
    }

    // Increase from current list
    List<ItemDataDisplay> newList = itemsDataDisplay.map((e) {
      if (e.item.id == item.item.id) {
        int quantityAdded;
        // If is custom item
        quantityAdded = itemAdded != null ? itemAdded.quantity : 1;
        e.quality += quantityAdded;
      }

      return e;
    }).toList();
    itemsDataDisplay.value = newList;
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

  void addItemWithSpecial(ItemDataDisplay item) {}
}
