import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Item.dart';

class CategoryCheckbox {
  int id;
  String name;
  bool checked;

  CategoryCheckbox(
      {required this.id, required this.name, this.checked = false});
}

class Property {
  String name;
  double amount;

  Property({required this.name, required this.amount});
}

class CreateItemController extends GetxController {
  AppDatabase db = Get.find<AppDatabase>();
  late ItemsDAO itemDAO;
  late CategoryDAO categoryDAO;

  // Value
  TextEditingController titleC = TextEditingController();
  RxList<CategoryCheckbox> categories = <CategoryCheckbox>[].obs;
  List<Property> properties = List.empty();
  Status status = Status.InStock;
  bool visibility = true;

  // Loading
  final Rx<bool> isLoadingCategory = true.obs;
  bool isCreateItem = false;

  @override
  void onInit() async {
    itemDAO = ItemsDAO(db);
    categoryDAO = CategoryDAO(db);
    var listCategories = await categoryDAO.listAllCategory().then((value) =>
        value.map((e) => CategoryCheckbox(id: e.id, name: e.name)).toList());
    categories.assignAll(listCategories);
    isLoadingCategory.value = false;

    super.onInit();
  }

  void onChangeCategoryCheckbox(bool? checked, int id) {
    categories.forEach((category) {
      if (category.id == id && checked != null) {
        category.checked = checked;
      }
    });

    categories.refresh();
  }
}
