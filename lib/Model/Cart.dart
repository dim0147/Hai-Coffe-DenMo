import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'Cart.g.dart';

@HiveType(typeId: 0)
class Cart {
  @HiveField(0)
  final int tableId;

  @HiveField(1)
  List<CartItem> items;

  @HiveField(2)
  int totalQuantities;

  @HiveField(3)
  double totalPrice;

  Cart(
      {required this.tableId,
      this.items = const [],
      this.totalQuantities = 0,
      this.totalPrice = 0.0});
}

@HiveType(typeId: 1)
class Item {
  @HiveField(1)
  final int id;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final double price;

  Item({required this.id, required this.name, required this.price});
}

@HiveType(typeId: 2)
class CartItem {
  @HiveField(0)
  Item item;

  @HiveField(1)
  int quality;

  @HiveField(2)
  double price;

  @HiveField(3)
  List<CartItemProperty> properties;

  CartItem(
      {required this.quality,
      required this.price,
      required this.item,
      required this.properties});
}

@HiveType(typeId: 3)
class CartItemProperty {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double amount;

  CartItemProperty({required this.name, required this.amount});
}
