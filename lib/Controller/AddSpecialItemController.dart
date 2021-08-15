import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/MenuController.dart';

class PropertyAdded {
  final String name;
  final double amount;
  int quantity;
  double totalPrice;

  PropertyAdded(this.name, this.amount,
      {this.quantity = 0, this.totalPrice = 0.0});
}

class ItemDataReturn {
  final int id;
  final List<PropertyAdded> propertiesAdded;
  final int quantity;
  final double totalPrice;

  ItemDataReturn(
      {required this.id,
      required this.propertiesAdded,
      required this.quantity,
      required this.totalPrice});
}

class AddSpecialItemController extends GetxController {
  final ItemDataDisplay itemDataDisplay = Get.arguments;
  final listPropertyAdded = <PropertyAdded>[].obs;
  final itemAmount = 1.obs;
  final totalDonGia = 0.0.obs;
  final totalProperty = 0.0.obs;

  final TextEditingController customNameC = TextEditingController();
  final MoneyMaskedTextController customAmountC = MoneyMaskedTextController(
    precision: 3,
  );

  @override
  void onInit() {
    super.onInit();
    var rs = Get.arguments;

    // Setup default list property
    var defaultListPropertyAdded = itemDataDisplay.properties
        ?.map((e) => PropertyAdded(e.name, e.amount))
        .toList();

    if (defaultListPropertyAdded != null) {
      listPropertyAdded.value = defaultListPropertyAdded;
    }

    // Default totalDongia
    totalDonGia.value = 1 * itemDataDisplay.item.price;
  }

  void increaseProperty(PropertyAdded property) {
    var newListPropertyAdded = listPropertyAdded.map((element) {
      if (element.name == property.name) {
        element.quantity += 1;
        element.totalPrice += element.amount;
      }

      return element;
    }).toList();

    listPropertyAdded.value = newListPropertyAdded;
    totalProperty.value = _getTotalProperty();
  }

  void removeProperty(PropertyAdded property) {
    var newListPropertyAdded = listPropertyAdded.map((element) {
      if (element.name == property.name) {
        element.quantity = 0;
        element.totalPrice = 0;
      }

      return element;
    }).toList();

    listPropertyAdded.value = newListPropertyAdded;
    totalProperty.value = _getTotalProperty();
  }

  void addCustomProperty() {
    try {
      String name = customNameC.text;
      double amount = customAmountC.numberValue;

      PropertyAdded newProperty = PropertyAdded(name, amount);
      listPropertyAdded.add(newProperty);
      customNameC.clear();
      customAmountC.clear();
    } catch (err) {
      Get.snackbar('Lỗi', 'Lỗi khi thêm nhanh thuộc tính\n: ${err.toString()}');
    }
  }

  double _getTotalProperty() {
    var propertiesHaveQuantity =
        listPropertyAdded.where((e) => e.quantity > 0).toList();

    var total = propertiesHaveQuantity.fold(0.0,
        (double previousValue, element) => previousValue + element.totalPrice);

    return total;
  }

  void onChangeItemAmount(String amountString) {
    int? amount = int.tryParse(amountString);
    if (amount == null) {
      totalDonGia.value = 0.0;
      return;
    }
    itemAmount.value = amount;
    totalDonGia.value = itemAmount.value * itemDataDisplay.item.price;
  }

  void confirm() {
    double totalPriceOfAll = totalDonGia.value + totalProperty.value;
    List<PropertyAdded> listPropertyHaveQuantity =
        listPropertyAdded.where((e) => e.quantity > 0).toList();

    ItemDataReturn data = ItemDataReturn(
        id: itemDataDisplay.item.id,
        propertiesAdded: listPropertyHaveQuantity,
        quantity: itemAmount.value,
        totalPrice: totalPriceOfAll);

    Get.back(result: data);
  }

  void cancel() {
    Get.back();
  }
}
