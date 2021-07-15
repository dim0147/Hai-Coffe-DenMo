import 'package:moor/moor.dart';

enum TableStatus { Avaiable, NotAvailable, Full }

class Tables extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 250)();
  IntColumn get order => integer()();
  IntColumn get status => intEnum<TableStatus>()
      .withDefault(Constant(TableStatus.Avaiable.index))();
}
