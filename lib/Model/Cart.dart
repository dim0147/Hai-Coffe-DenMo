import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'Cart.g.dart';

@HiveType(typeId: 0)
class Cart {
  @HiveField(0)
  int? tableId;

  @HiveField(1)
  List<CartItem> items;

  Cart({
    this.tableId,
    required this.items,
  });

  double showTotalPrice() {
    return this
        .items
        .fold(0.0, (previousValue, e) => previousValue + e.totalPrice);
  }

  int showTotalQuantity() {
    return this
        .items
        .fold(0, (previousValue, e) => previousValue + e.totalQuantity);
  }

  void addItemByCartItem(CartItem cartItem) {
    _addItemByCartItem(cartItem);
    _cartBoxUpdate();
  }

  void _addItemByCartItem(CartItem cartItem) {
    // Check if have properties
    bool haveProperties = cartItem.properties.length > 0;

    // Add new cart item if have any properties
    if (haveProperties) return this.items.add(cartItem);

    //  Check item is exist in cart
    bool itemIsExistInCart =
        this.items.any((e) => e.item.id == cartItem.item.id);

    // Increase if exist in cart
    if (itemIsExistInCart) {
      final newListItems = this.items.map((e) {
        if (e.item.id == cartItem.item.id) {
          e.totalQuantity += cartItem.totalQuantity;
          e.totalPrice += cartItem.totalPrice;
        }
        return e;
      }).toList();
      this.items = newListItems;
      return;
    }

    // Add new item
    this.items.add(cartItem);
  }

  /// In menu screen, we create ItemDataDisplay which don't have cartItemKey so that why we need itemId
  void decreaseItem({String? cartItemKey, int? itemId}) {
    _decreaseItem(cartItemKey: cartItemKey, itemId: itemId);
    _cartBoxUpdate();
  }

  void _decreaseItem({String? cartItemKey, int? itemId}) {
    if (cartItemKey == null && itemId == null) return;

    CartItem? itemToDecrease;

    // Find by unique key
    if (cartItemKey != null) {
      // Found cart need to delete
      itemToDecrease =
          this.items.firstWhereOrNull((e) => e.uniqueKey == cartItemKey);
      if (itemToDecrease == null) return;
    }

    // Find by item id key
    if (itemId != null) {
      // Found cart need to delete
      itemToDecrease = this.items.lastWhereOrNull((e) => e.item.id == itemId);
      if (itemToDecrease == null) return;
    }

    // This won't happen
    if (itemToDecrease == null) return;

    // Check if decrease quality equal zero, we remove, no decrease
    if (itemToDecrease.totalQuantity - 1 <= 0) {
      this.removeCartItem(itemToDecrease.uniqueKey);
      return;
    }

    // Decrease quantity of cart item
    itemToDecrease.totalQuantity -= 1;

    // Decrease 1 item price and plus the total properties price if have
    double priceProperties = itemToDecrease.properties.fold(
        0.0, (double previousValue, e) => previousValue + e.showTotalPrice());
    itemToDecrease.totalPrice -= (itemToDecrease.item.price + priceProperties);
  }

  void removeCartItem(String cartItemKey) {
    _removeCartItem(cartItemKey);
    _cartBoxUpdate();
  }

  void _removeCartItem(String cartItemKey) {
    CartItem? cartItemKnowledge =
        this.items.firstWhereOrNull((e) => e.uniqueKey == cartItemKey);

    if (cartItemKnowledge == null) return;

    // Remove item from list
    List<CartItem> newList =
        this.items.where((e) => e.uniqueKey != cartItemKey).toList();
    this.items = newList;
  }

  void updateCart(CartItem updatedCart) {
    _updateCart(updatedCart);
    _cartBoxUpdate();
  }

  void _updateCart(CartItem updatedCart) {
    final bool isExistInCart =
        this.items.any((e) => e.uniqueKey == updatedCart.uniqueKey);
    if (!isExistInCart) return;

    List<CartItem> newList = this.items.map((e) {
      if (e.uniqueKey == updatedCart.uniqueKey) {
        e = updatedCart;
      }
      return e;
    }).toList();

    this.items = newList;
  }

  Future<void> _cartBoxUpdate() async {
    // Check if this cart have table
    int? tableID = this.tableId;
    if (tableID == null) return;

    // Update into box
    final tableLocalDAO = Get.find<TableLocalDAO>();
    return tableLocalDAO.updateTable(tableID, cart: this);
  }
}

@HiveType(typeId: 1)
class CartItem {
  @HiveField(0)
  String uniqueKey = Utils.generateRandomId();

  @HiveField(1)
  Item item;

  @HiveField(2)
  List<CartItemProperty> properties;

  @HiveField(3)
  int totalQuantity;

  /// Equal total (quality * item price)  + total properties price
  @HiveField(4)
  double totalPrice;

  /// Equal this.quantity * this.item.price
  double showPriceMinusItemQuantity() {
    return this.totalQuantity * this.item.price;
  }

  List<CartItemProperty> showListPropertiesHaveQuantity() {
    return this.properties.where((e) => e.quantity > 0).toList();
  }

  CartItem({
    required this.totalQuantity,
    required this.totalPrice,
    required this.item,
    required this.properties,
  });
}

@HiveType(typeId: 2)
class Item {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String img;

  Item(
      {required this.id,
      required this.name,
      required this.price,
      required this.img});
}

@HiveType(typeId: 3)
class CartItemProperty {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final int quantity;

  double showTotalPrice() => this.amount * this.quantity;

  double showTotalPriceMinusItemQuantity(int itemQuantity) =>
      this.showTotalPrice() * itemQuantity;

  CartItemProperty(
      {required this.name, required this.amount, required this.quantity});
}
