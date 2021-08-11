import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';

class ItemDataDisplay extends ItemDataClass {
  int quality;
  double totalPrice;

  ItemDataDisplay({
    required Item item,
    List<Category>? categories,
    List<ItemProperty>? properties,
    required this.quality,
    required this.totalPrice,
  }) : super(item: item, categories: categories, properties: properties);
}

class MenuController extends GetxController with SingleGetTickerProviderMixin {
  AppDatabase db = Get.find<AppDatabase>();
  late ItemsDAO itemsDAO;
  late CategoryDAO categoryDAO;
  late final imgPath = Rxn<String>();

  // Data
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
      imgPath.value = await AppConfig.getImgDirectory();

      // Get items
      List<ItemDataClass> items = await itemsDAO.getAllItems();
      itemsDataDisplay.value = items
          .map((e) => ItemDataDisplay(
              item: e.item,
              categories: e.categories,
              properties: e.properties,
              quality: 0,
              totalPrice: 0.0))
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

  void increaseItem(ItemDataDisplay item) {
    var newList = itemsDataDisplay.map((e) {
      if (e.item.id == item.item.id) {
        int quantityAdded = 1;
        double itemPrice = e.item.price;
        double priceAdded = itemPrice * quantityAdded;

        e.quality += quantityAdded;
        e.totalPrice += priceAdded;
      }

      return e;
    }).toList();
    itemsDataDisplay.value = newList;
  }

  void decreaseItem(ItemDataDisplay item) {
    var newList = itemsDataDisplay.map((e) {
      if (e.item.id == item.item.id) {
        int quantityDecrease = 1;
        double itemPrice = e.item.price;
        double priceRemoved = itemPrice * quantityDecrease;

        e.quality -= quantityDecrease;
        e.totalPrice -= priceRemoved;

        if (e.quality <= 0) e.quality = 0;
        if (e.totalPrice <= 0.0) e.totalPrice = 0.0;
      }

      return e;
    }).toList();
    itemsDataDisplay.value = newList;
  }
}
