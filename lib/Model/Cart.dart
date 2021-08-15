import 'package:collection/collection.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/AddSpecialItemController.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hai_noob/DB/Database.dart' as DBModel;

part 'Cart.g.dart';

@HiveType(typeId: 0)
class Cart {
  @HiveField(0)
  final int? tableId;

  @HiveField(1)
  List<CartItem> items;

  @HiveField(2)
  int totalQuantities;

  @HiveField(3)
  double totalPrice;

  Cart(
      {this.tableId,
      required this.items,
      this.totalQuantities = 0,
      this.totalPrice = 0.0});

  void addItem(DBModel.Item item, ItemDataReturn data) {
    // Convert item to cart item
    Item itemInCartItem = Item(id: item.id, name: item.name, price: item.price);

    // Convert PropertiesAdded to CartItemProperty
    List<CartItemProperty> properties = data.propertiesAdded
        .map((e) => CartItemProperty(
            name: e.name,
            amount: e.amount,
            quantity: e.quantity,
            totalPrice: e.totalPrice))
        .toList();

    // Check if properties is empty
    if (properties.length == 0)
      _addItemWithNonProperty(item: itemInCartItem, data: data);
    else
      _addItemWithProperty(
          properties: properties, item: itemInCartItem, data: data);

    // Update price and quantities
    this.totalPrice += data.totalPrice;
    this.totalQuantities += data.quantity;
  }

  void _addItemWithNonProperty(
      {required Item item, required ItemDataReturn data}) {
    // Check if cart  have this item already
    bool isExistInCart = this.items.any((e) => e.item.id == item.id);

    // If exist
    if (isExistInCart) {
      // Update quantity and price of exist item
      this.items = this.items.map((e) {
        if (e.item.id == item.id) {
          e.quality += data.quantity;
          e.totalPrice += data.totalPrice;
        }

        return e;
      }).toList();

      return;
    }
    // Not exist, create new item
    else {
      // Create new cart
      CartItem cartItem = CartItem(
          quality: data.quantity,
          totalPrice: data.totalPrice,
          item: item,
          properties: List.empty());

      // Add new item
      this.items.add(cartItem);
    }
  }

  void _addItemWithProperty(
      {required List<CartItemProperty> properties,
      required Item item,
      required ItemDataReturn data}) {
    // Create new cart
    CartItem cartItem = CartItem(
        quality: data.quantity,
        totalPrice: data.totalPrice,
        item: item,
        properties: properties);

    // Add new item
    this.items.add(cartItem);
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

    // Decrease price of 1 and plus the properties total price if have
    double priceProperties = itemToDecrease.properties
        .fold(0.0, (double previousValue, e) => previousValue + e.totalPrice);
    itemToDecrease.totalPrice -= (itemToDecrease.item.price + priceProperties);

    // Decease total price and quality of cart
    this.totalPrice -= (itemToDecrease.item.price + priceProperties);
    this.totalQuantities -= 1;

    //TODO: Add remove method for itemToDecrease if smaller then 0

    //TODO: Add set to 0 if totalPrice equal 0
  }

  void removeCartItem(String cartItemKey) {
    CartItem? cartItemKnowledge =
        this.items.firstWhereOrNull((e) => e.uniqueKey == cartItemKey);

    if (cartItemKnowledge == null) return;

    // Remove item from list
    List<CartItem> newList =
        this.items.where((e) => e.uniqueKey != cartItemKey).toList();
    this.items = newList;

    // Decrease total price and quantity
    this.totalPrice -= cartItemKnowledge.totalPrice;
    this.totalQuantities -= cartItemKnowledge.quality;
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

  Item({required this.id, required this.name, required this.price});
}

@HiveType(typeId: 3)
class CartItemProperty {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final double totalPrice;

  CartItemProperty(
      {required this.name,
      required this.amount,
      required this.quantity,
      required this.totalPrice});
}
