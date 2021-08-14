import 'package:hai_noob/Controller/CreateItemController.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:collection/collection.dart';
import 'package:moor/moor.dart';
import 'package:hai_noob/Model/Item.dart';

part 'ItemDAO.g.dart';

class EntryItemWithCategoryWithProperties {
  Item item;
  Category? categories;
  ItemProperty? properties;

  EntryItemWithCategoryWithProperties(
      {required this.item, this.categories, this.properties});
}

class ItemDataClass {
  Item item;
  List<Category>? categories;
  List<ItemProperty>? properties;

  ItemDataClass({required this.item, this.categories, this.properties});
}

@UseDao(tables: [Items, ItemCategories, ItemProperty])
class ItemsDAO extends DatabaseAccessor<AppDatabase> with _$ItemsDAOMixin {
  ItemsDAO(AppDatabase db) : super(db);

  // Future removeAll() async {
  //   var categoriesI = await delete(db.itemCategories).go();
  //   var propertiesI = await delete(db.itemProperties).go();
  //   var items = await delete(db.items).go();
  //   print('');
  // }

  // Future test() async {
  //   var items = await select(db.items).get();
  //   var categories = await select(db.categories).get();
  //   var categoriesI = await select(db.itemCategories).get();
  //   var propertiesI = await select(db.itemProperties).get();
  //   print('');
  // }

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

  Future<List<ItemDataClass>> getAllItems() async {
    var query = select(db.items).join([
      leftOuterJoin(
          db.itemCategories, db.itemCategories.itemId.equalsExp(db.items.id)),
      leftOuterJoin(
          db.itemProperties, db.itemProperties.itemId.equalsExp(db.items.id)),
      leftOuterJoin(db.categories,
          db.categories.id.equalsExp(db.itemCategories.categoryId))
    ]);

    // Raw query result
    var queryResult = await query.get();

    // Convert to list entry data
    List<EntryItemWithCategoryWithProperties> listEntryData =
        queryResult.map((row) {
      return EntryItemWithCategoryWithProperties(
          item: row.readTable(db.items),
          categories: row.readTableOrNull(db.categories),
          properties: row.readTableOrNull(db.itemProperties));
    }).toList();

    // Implement group by, return map
    var MapGroupBy = groupBy(
        listEntryData, (EntryItemWithCategoryWithProperties e) => e.item.id);

    // Shape result into list from map
    List<ItemDataClass> listData = MapGroupBy.entries.map((entry) {
      List<EntryItemWithCategoryWithProperties> value = entry.value;

      // Get first index with item property
      var item = value[0].item;

      // Unique categories
      bool isCategoryAllNull = value.every((e) => e.categories == null);
      var categories = isCategoryAllNull
          ? null
          : value
              .map((e) => e.categories)
              .whereType<Category>()
              .toSet()
              .toList();

      // Unnique properties
      bool isPropertyAllNull = value.every((e) => e.properties == null);
      var properties = isPropertyAllNull
          ? null
          : value
              .map((e) => e.properties)
              .whereType<ItemProperty>()
              .toSet()
              .toList();

      // Create item class
      ItemDataClass itemData = ItemDataClass(
        item: item,
        categories: categories,
        properties: properties,
      );

      return itemData;
    }).toList();

    return listData;
  }
}
