import 'package:hai_noob/Controller/CreateItemController.dart';
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

  Future removeAll() async {
    var categoriesI = await delete(db.itemCategories).go();
    var propertiesI = await delete(db.itemProperties).go();
    var items = await delete(db.items).go();
    print('');
  }

  Future test() async {
    var items = await select(db.items).get();
    var categories = await select(db.categories).get();
    var categoriesI = await select(db.itemCategories).get();
    var propertiesI = await select(db.itemProperties).get();
    print('');
  }

  Future createItem(ItemsCompanion item, List<CategoryCheckbox> categories,
      List<Property> properties) async {
    return transaction(() async {
      // Add item
      int itemId = await into(db.items).insert(item);

      // Add properties
      if (properties.length > 0) {
        List<ItemPropertiesCompanion> propertiesToInsert = properties
            .map((property) => ItemPropertiesCompanion.insert(
                itemId: itemId, name: property.name, amount: property.amount))
            .toList();
        await batch((batch) {
          batch.insertAll(db.itemProperties, propertiesToInsert);
        });
      }

      // Add category
      List<ItemCategoriesCompanion> categoriesToInsert = categories
          .where((category) => category.checked)
          .map((category) => ItemCategoriesCompanion.insert(
              itemId: itemId, categoryId: category.id))
          .toList();
      if (categoriesToInsert.length > 0) {
        await batch((batch) {
          batch.insertAll(db.itemCategories, categoriesToInsert);
        });
      }

      return true;
    });
  }
}
