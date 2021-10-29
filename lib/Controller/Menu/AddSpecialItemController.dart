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

final int DEFAULT_ITEM_AMOUNT = 1;
final double DEFAULT_PRICE = 0.0;

class AddSpecialItemController extends GetxController {
  final CartItem cartItem = Get.arguments;

  final TextEditingController customNameC = TextEditingController();
  final MoneyMaskedTextController customAmountC = MoneyMaskedTextController(
    precision: 0,
  );

  final RxList<PropertyAdded> listPropertyAdded = <PropertyAdded>[].obs;
  final Rx<int> itemAmount = DEFAULT_ITEM_AMOUNT.obs;

  @override
  void onInit() {
    super.onInit();

    // Setup default list property
    final List<PropertyAdded> defaultListPropertyAdded = cartItem.properties
        .map((e) => PropertyAdded(e.name, e.amount, quantity: e.quantity))
        .toList();
    listPropertyAdded.value = defaultListPropertyAdded;

    // Assign default item values
    itemAmount.value = cartItem.totalQuantity;
  }

  void addCustomProperty() {
    try {
      final String name = customNameC.text;
      final double amount = customAmountC.numberValue;

      if (name == '')
        return Utils.showSnackBar('Lỗi', 'Hãy nhập tên thuộc tính');

      final PropertyAdded newProperty = PropertyAdded(name, amount);
      listPropertyAdded.add(newProperty);

      customNameC.clear();
      customAmountC.clear();
    } catch (err) {
      Utils.showSnackBar(
        'Lỗi',
        'Lỗi khi thêm nhanh thuộc tính\n: ${err.toString()}',
      );
    }
  }

  void increaseProperty(PropertyAdded property) {
    final List<PropertyAdded> newListPropertyAdded = listPropertyAdded.map(
      (element) {
        if (element.name == property.name) element.quantity += 1;
        return element;
      },
    ).toList();
    listPropertyAdded.value = newListPropertyAdded;
  }

  void removeProperty(PropertyAdded property) {
    var newListPropertyAdded = listPropertyAdded.map(
      (element) {
        if (element.name == property.name) element.quantity = 0;
        return element;
      },
    ).toList();
    listPropertyAdded.value = newListPropertyAdded;
  }

  void onChangeItemAmount(String amountString) {
    final int? amount = int.tryParse(amountString);
    if (amount == null) {
      itemAmount.value = 0;
      return;
    }
    itemAmount.value = amount;
  }

  void confirm() {
    cartItem.properties = listPropertyAdded
        .map((e) => CartItemProperty(
              name: e.name,
              amount: e.amount,
              quantity: e.quantity,
            ))
        .toList();
    cartItem.totalQuantity = itemAmount.value;
    cartItem.totalPrice = totalPrice();

    Get.back(result: cartItem);
  }

  double getTotalProperty() {
    final List<PropertyAdded> propertiesHaveQuantity =
        listPropertyAdded.where((e) => e.quantity > 0).toList();

    final double total = propertiesHaveQuantity.fold(
        0.0,
        (double previousValue, element) =>
            previousValue + element.showTotalPrice());

    return total;
  }

  double totalPropertyMinusItemQuantity() =>
      getTotalProperty() * itemAmount.value;

  double getItemSubTotal() {
    return itemAmount.value * cartItem.item.price;
  }

  double totalPrice() => totalPropertyMinusItemQuantity() + getItemSubTotal();

  void cancel() {
    Get.back();
  }
}
