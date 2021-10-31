import 'package:moor/moor.dart';

class TableOrders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 250)();
  IntColumn get order => integer()();
}
