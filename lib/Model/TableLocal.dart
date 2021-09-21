import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hai_noob/Model/Cart.dart';

part 'TableLocal.g.dart';

@HiveType(typeId: 4)
enum TableStatus {
  @HiveField(0)
  Empty,

  @HiveField(1)
  Holding,
}

@HiveType(typeId: 5)
class TableLocal {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int order;

  @HiveField(3)
  final TableStatus status;

  @HiveField(4)
  Cart? cart;

  TableLocal({
    required this.id,
    required this.name,
    required this.order,
    required this.status,
    Cart? cart,
  });
}
