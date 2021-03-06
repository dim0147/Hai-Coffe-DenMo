import 'dart:io';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moor/moor.dart' as moor;
import 'package:path/path.dart' as p;
import 'package:sentry_flutter/sentry_flutter.dart';

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
  final TextEditingController titleC = TextEditingController();
  final MoneyMaskedTextController priceC = MoneyMaskedTextController(
    decimalSeparator: '',
    precision: 0,
  );
  final TextEditingController propertyNameC = TextEditingController();
  final MoneyMaskedTextController propertyAmountC = MoneyMaskedTextController(
    decimalSeparator: '',
    precision: 0,
  );

  // Value
  final RxList<CategoryCheckbox> categories = <CategoryCheckbox>[].obs;
  final RxList<Property> properties = <Property>[].obs;
  final visibility = true.obs;
  final img = Rxn<File>();

  // Loading
  final Rx<bool> isLoadingCategory = true.obs;
  final isCreateItem = false.obs;

  @override
  void onInit() async {
    super.onInit();
    itemDAO = ItemsDAO(db);
    categoryDAO = CategoryDAO(db);

    try {
      // Load category
      final listCategories = await categoryDAO.listAllCategory().then((value) =>
          value.map((e) => CategoryCheckbox(id: e.id, name: e.name)).toList());
      categories.assignAll(listCategories);
      isLoadingCategory.value = false;
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
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
  }

  void removeProperty(Property property) {
    properties.removeWhere(
      (element) =>
          element.name == property.name && element.amount == property.amount,
    );
  }

  void onChangeVisibility(bool? newValue) {
    if (newValue == null) return;
    visibility.value = newValue;
  }

  void onAddImg() async {
    // Pick an image
    final image = await _picker.pickImage(source: ImageSource.gallery);
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
    final ItemsCompanion itemToInsert = ItemsCompanion.insert(
      name: title,
      image: imgName ?? '',
      price: price,
      visibility: moor.Value(visibility.value),
    );

    // Create item
    try {
      await itemDAO.createItem(itemToInsert, categories, properties);
      Get.offAllNamed('/item/list');
      Utils.showSnackBar(
        'Thành công',
        'Tạo item \'$title\' thành công',
      );
    } catch (err, stackTrace) {
      Utils.showSnackBar(
        'Lỗi',
        'Có lỗi xảy ra khi tạo item: \n ${err.toString()}',
      );
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
    isCreateItem.value = false;
  }
}
