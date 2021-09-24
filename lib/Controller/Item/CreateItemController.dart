import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:moor/moor.dart' as moor;
import 'package:path/path.dart' as p;
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Item.dart';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker _picker = ImagePicker();

  // Value
  final TextEditingController titleC = TextEditingController();
  final MoneyMaskedTextController priceC = MoneyMaskedTextController(
    precision: 3,
  );
  final RxList<CategoryCheckbox> categories = <CategoryCheckbox>[].obs;
  final TextEditingController propertyNameC = TextEditingController();
  final MoneyMaskedTextController propertyAmountC = MoneyMaskedTextController(
    precision: 3,
  );
  final RxList<Property> properties = <Property>[].obs;
  final status = Status.InStock.obs;
  final visibility = true.obs;
  final img = Rxn<File>();

  // Loading
  final Rx<bool> isLoadingCategory = true.obs;
  final isCreateItem = false.obs;

  @override
  void onInit() async {
    itemDAO = ItemsDAO(db);
    categoryDAO = CategoryDAO(db);

    // Load category
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

  void addProperty() {
    String name = propertyNameC.text;
    double? amount = Utils.convertStringToDouble(propertyAmountC.text);
    if (amount == null) {
      Utils.showSnackBar('Lỗi', 'Giá thuộc tính không hợp lệ!');
      return;
    }

    Property newProperty = Property(name: name, amount: amount);
    properties.add(newProperty);

    propertyNameC.text = '';
    propertyAmountC.text = '0,000';

    print(name);
  }

  void removeProperty(Property property) {
    properties.removeWhere((element) =>
        element.name == property.name && element.amount == property.amount);
  }

  void onChangeStatus(Status? newStatus) {
    if (newStatus == null) return;

    status.value = newStatus;
  }

  void onChangeVisibility(bool? newValue) {
    if (newValue == null) return;

    visibility.value = newValue;
  }

  void onAddImg() async {
    // Pick an image
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    img.value = File(image.path);
  }

  void onRemoveImg() {
    img.value = null;
  }

  void onCreateItem() async {
    isCreateItem.value = true;
    String title = titleC.text;
    double? price = Utils.convertStringToDouble(priceC.text);
    String? imgName;

    // Validate
    if (title.length == 0) {
      isCreateItem.value = false;
      return Utils.showSnackBar('Lỗi', 'Tên trống');
    }

    if (price == null) {
      isCreateItem.value = false;
      return Utils.showSnackBar('Lỗi', 'Giá không hợp lệ');
    }

    // Save image if have
    if (img.value != null) {
      File? imgSaved = await Utils.saveImg(img.value as File);
      if (imgSaved == null) {
        isCreateItem.value = false;
        return;
      }
      imgName = p.basename(imgSaved.path);
    }

    // Create item to insert
    ItemsCompanion itemToInsert = ItemsCompanion.insert(
      name: title,
      image: imgName ?? '',
      price: price,
      status: status.value,
      visibility: moor.Value(visibility.value),
    );

    // Create item
    try {
      await itemDAO.createItem(itemToInsert, categories, properties);
      Utils.showSnackBar('Thành công', 'Tạo item \'$title\' thành công');
    } catch (err) {
      Utils.showSnackBar(
          'Lỗi', 'Có lỗi xảy ra khi tạo item: \n ${err.toString()}');
    }
    isCreateItem.value = false;
  }
}
