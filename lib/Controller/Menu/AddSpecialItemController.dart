import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Model/Cart.dart';

class PropertyAdded {
  final String name;
  final double amount;
  int quantity;

  double showTotalPrice() => this.amount * this.quantity;

  PropertyAdded(this.name, this.amount, {this.quantity = 0});
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
  final CartItem cartItem = Get.arguments;
  final listPropertyAdded = <PropertyAdded>[].obs;
  final itemAmount = 1.obs;
  final totalDonGia = 0.0.obs;
  final totalProperty = 0.0.obs;

  final TextEditingController customNameC = TextEditingController();
  final MoneyMaskedTextController customAmountC = MoneyMaskedTextController(
    precision: 0,
  );

  @override
  void onInit() {
    super.onInit();

    // Setup default list property
    List<PropertyAdded> defaultListPropertyAdded = cartItem.properties
        .map((e) => PropertyAdded(e.name, e.amount, quantity: e.quantity))
        .toList();

    listPropertyAdded.value = defaultListPropertyAdded;

    // Default
    itemAmount.value = cartItem.totalQuantity;
    totalProperty.value = _getTotalProperty();
    totalDonGia.value = cartItem.totalQuantity * cartItem.item.price;
  }

  void increaseProperty(PropertyAdded property) {
    List<PropertyAdded> newListPropertyAdded = listPropertyAdded.map((element) {
      if (element.name == property.name) {
        element.quantity += 1;
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
      Utils.showSnackBar(
          'Lỗi', 'Lỗi khi thêm nhanh thuộc tính\n: ${err.toString()}');
    }
  }

  double _getTotalProperty() {
    var propertiesHaveQuantity =
        listPropertyAdded.where((e) => e.quantity > 0).toList();

    var total = propertiesHaveQuantity.fold(
        0.0,
        (double previousValue, element) =>
            previousValue + element.showTotalPrice());

    return total;
  }

  void onChangeItemAmount(String amountString) {
    int? amount = int.tryParse(amountString);
    if (amount == null) {
      totalDonGia.value = 0.0;
      return;
    }
    itemAmount.value = amount;
    totalDonGia.value = itemAmount.value * cartItem.item.price;
  }

  void confirm() {
    double allTotalPropertyMinusItemQuantity =
        (totalProperty.value * itemAmount.value);

    double totalPriceOfAll =
        allTotalPropertyMinusItemQuantity + totalDonGia.value;

    cartItem.totalQuantity = itemAmount.value;
    cartItem.totalPrice = totalPriceOfAll;
    cartItem.properties = listPropertyAdded
        .map((e) => CartItemProperty(
              name: e.name,
              amount: e.amount,
              quantity: e.quantity,
            ))
        .toList();

    Get.back(result: cartItem);
  }

  void cancel() {
    Get.back();
  }
}
