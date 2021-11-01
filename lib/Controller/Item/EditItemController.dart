import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:hai_noob/Controller/Item/CreateItemController.dart';
import 'package:moor/moor.dart' as moor;
import 'package:path/path.dart' as p;
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/CategoryDAO.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class EditItemScreenArgs {
  final int itemId;

  EditItemScreenArgs(this.itemId);
}

class EditItemController extends GetxController {
  final EditItemScreenArgs args = Get.arguments;
  final db = Get.find<AppDatabase>();
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
  final isSaveItem = false.obs;

  @override
  void onInit() async {
    try {
      super.onInit();

      itemDAO = ItemsDAO(db);
      categoryDAO = CategoryDAO(db);

      // Load category
      final listCategories = await categoryDAO.listAllCategory().then(
            (value) => value
                // Convert categories to checkbox
                .map((e) => CategoryCheckbox(id: e.id, name: e.name))
                .toList(),
          );
      categories.assignAll(listCategories);
      isLoadingCategory.value = false;

      // Load Item
      final itemId = args.itemId;
      final itemData = await itemDAO.getItemById(itemId);

      setDefaultItemData(itemData);
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }

  void setDefaultItemData(ItemDataClass itemData) {
    // Set data
    titleC.text = itemData.item.name;
    priceC.updateValue(itemData.item.price);
    visibility.value = itemData.item.visibility;

    setItemImg(itemData);
    setCategoryCheckboxes(itemData);
    setPropertyCheckboxes(itemData);
  }

  void setItemImg(ItemDataClass itemData) {
    if (itemData.item.image == '') return;
    final imgFile = Utils.getImgFile(itemData.item.image);
    if (imgFile == null) return;
    img.value = imgFile;
  }

  void setCategoryCheckboxes(ItemDataClass itemData) {
    final itemCategories = itemData.categories;
    if (itemCategories == null) return;

    final newListCategoryCheckboxs = categories.map((e) {
      // Check if current category is one of item categories
      final isIncludeInItemCategory = itemCategories.any((i) => i.id == e.id);
      if (isIncludeInItemCategory) e.checked = true;

      return e;
    }).toList();
    categories.value = newListCategoryCheckboxs;
  }

  void setPropertyCheckboxes(ItemDataClass itemData) {
    final itemProperties = itemData.properties;
    if (itemProperties == null) return;
    final listPropertyCheckboxes = itemProperties
        .map((e) => Property(name: e.name, amount: e.amount))
        .toList();
    properties.value = listPropertyCheckboxes;
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
    if (name == '') {
      Utils.showSnackBar('Lỗi', 'Nhập tên thuộc tính!');
      return;
    }
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

  void onSaveItem() async {
    // Create item
    try {
      final itemId = args.itemId;
      if (itemId == null) return;

      isSaveItem.value = true;
      String title = titleC.text;
      double? price = Utils.convertStringToDouble(priceC.text);
      String? imgName;

      // Validate
      if (title.length == 0) {
        isSaveItem.value = false;
        return Utils.showSnackBar('Lỗi', 'Tên trống');
      }

      if (price == null) {
        isSaveItem.value = false;
        return Utils.showSnackBar('Lỗi', 'Giá không hợp lệ');
      }

      // Save image if have
      if (img.value != null) {
        File? imgSaved = await Utils.saveImg(img.value as File);
        if (imgSaved == null) {
          isSaveItem.value = false;
          return;
        }
        imgName = p.basename(imgSaved.path);
      }

      // Create item to insert
      final itemUpdate = ItemsCompanion(
        name: moor.Value(title),
        image: imgName != null ? moor.Value(imgName) : moor.Value(''),
        price: moor.Value(price),
        visibility: moor.Value(visibility.value),
      );

      await itemDAO.updateItem(
        itemId,
        itemUpdate,
        categories,
        properties,
      );
      Get.back();
      Utils.showSnackBar('Thành công', 'Lưu item \'$title\' thành công');
    } catch (err, stackTrace) {
      Utils.showSnackBar(
          'Lỗi', 'Có lỗi xảy ra khi lưu item: \n ${err.toString()}');
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
    isSaveItem.value = false;
  }
}
