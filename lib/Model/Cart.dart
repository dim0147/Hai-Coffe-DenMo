import 'package:collection/collection.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'Cart.g.dart';

@HiveType(typeId: 0)
class Cart {
  @HiveField(0)
  final int? tableId;

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
    return this.items.fold(0, (previousValue, e) => previousValue + e.quality);
  }

  void addItemByCartItem(CartItem cartItem) {
    // Check if have properties
    bool haveProperties = cartItem.properties.length > 0;

    // Add new cart item if have any properties
    if (haveProperties) return this.items.add(cartItem);

    // Mean no properties, we will add if don't exist in cart or increase if exist in cart
    bool existInCart = this.items.any((e) => e.item.id == cartItem.item.id);

    // We increase
    if (existInCart) {
      this.items.forEach((e) {
        if (e.item.id == cartItem.item.id) {
          e.quality += cartItem.quality;
          e.totalPrice += cartItem.totalPrice;
        }
      });
    }
    // No exist in cart
    else {
      // Add new item
      this.items.add(cartItem);
    }
  }

  void decreaseItem({String? cartItemKey, int? itemId}) {
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
    if (itemToDecrease.quality - 1 <= 0) {
      this.removeCartItem(itemToDecrease.uniqueKey);
      return;
    }

    // Decrease quantity of cart item
    itemToDecrease.quality -= 1;

    // Decrease 1 item price and plus the total properties price if have
    double priceProperties = itemToDecrease.properties.fold(
        0.0, (double previousValue, e) => previousValue + e.showTotalPrice());
    itemToDecrease.totalPrice -= (itemToDecrease.item.price + priceProperties);
  }

  void removeCartItem(String cartItemKey) {
    CartItem? cartItemKnowledge =
        this.items.firstWhereOrNull((e) => e.uniqueKey == cartItemKey);

    if (cartItemKnowledge == null) return;

    // Remove item from list
    List<CartItem> newList =
        this.items.where((e) => e.uniqueKey != cartItemKey).toList();
    this.items = newList;
  }

  void updateCart(CartItem updatedCart) {
    bool isExistInCart =
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
  int quality;

  /// Equal total (quality * item price)  + total properties price
  @HiveField(4)
  double totalPrice;

  double showPriceWithQuality() {
    return this.quality * this.item.price;
  }

  CartItem({
    required this.quality,
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
