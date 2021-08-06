import 'package:hai_noob/DB/Database.dart';
import 'package:moor/moor.dart';
import 'package:hai_noob/Model/Item.dart';

part 'ItemDAO.g.dart';

@UseDao(tables: [Items, ItemCategories, ItemProperty])
class ItemsDAO extends DatabaseAccessor<AppDatabase> with _$ItemsDAOMixin {
  $ItemsTable? itemTable;
  $ItemCategoriesTable? itemCategoryTable;
  $ItemPropertiesTable? itemPropertyTable;

  ItemsDAO(AppDatabase db) : super(db) {
    itemTable = db.items;
    itemCategoryTable = db.itemCategories;
    itemPropertyTable = db.itemProperties;
  }
}
