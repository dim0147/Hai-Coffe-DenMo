import 'package:moor/moor.dart';

enum Status { InStock, OutStock }

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 250)();
  TextColumn get image => text()();
  RealColumn get price => real()();
  IntColumn get ancestorItemId =>
      integer().nullable().customConstraint('REFERENCES items(id)')();
  BoolColumn get visibility => boolean().withDefault(Constant(true))();
  IntColumn get status => intEnum<Status>()();
}

// One item have many categories
@DataClassName("ItemCategory")
class ItemCategories extends Table {
  IntColumn get itemId => integer().customConstraint('REFERENCES items(id)')();
  IntColumn get categoryId =>
      integer().customConstraint('REFERENCES categories(id)')();

  @override
  Set<Column> get primaryKey => {itemId, categoryId};
}

// One item have many properties
@DataClassName("ItemProperty")
class ItemProperties extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().customConstraint('REFERENCES items(id)')();
  TextColumn get name => text()();
  RealColumn get amount => real()();
}
