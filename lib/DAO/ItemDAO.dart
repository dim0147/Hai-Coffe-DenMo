import 'package:hai_noob/Controller/Item/CreateItemController.dart';
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

  Future createItem(
    ItemsCompanion item,
    List<CategoryCheckbox> categories,
    List<Property> properties,
  ) async {
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

    return getListItemDataFromQuery(queryResult);
  }

  Future<List<ItemDataClass>> getAllItemsInMenu() async {
    final query =
        (select(db.items)..where((tbl) => tbl.visibility.equals(true))).join([
      leftOuterJoin(
          db.itemCategories, db.itemCategories.itemId.equalsExp(db.items.id)),
      leftOuterJoin(
          db.itemProperties, db.itemProperties.itemId.equalsExp(db.items.id)),
      leftOuterJoin(db.categories,
          db.categories.id.equalsExp(db.itemCategories.categoryId))
    ]);

    // Raw query result
    final queryResult = await query.get();

    return getListItemDataFromQuery(queryResult);
  }

  Future<ItemDataClass> getItemById(int itemId) async {
    final query =
        (select(db.items)..where((tbl) => tbl.id.equals(itemId))).join([
      leftOuterJoin(
          db.itemCategories, db.itemCategories.itemId.equalsExp(db.items.id)),
      leftOuterJoin(
          db.itemProperties, db.itemProperties.itemId.equalsExp(db.items.id)),
      leftOuterJoin(db.categories,
          db.categories.id.equalsExp(db.itemCategories.categoryId))
    ]);

    final queryResult = await query.get();
    final listItemData = getListItemDataFromQuery(queryResult);
    if (listItemData.length == 0) return Future.error('Không tìm thấy item');

    // Return first item
    return listItemData[0];
  }

  List<ItemDataClass> getListItemDataFromQuery(
    List<TypedResult> queryResult,
  ) {
    // Convert to list entry data
    final listEntryData = queryResult.map((row) {
      return EntryItemWithCategoryWithProperties(
          item: row.readTable(db.items),
          categories: row.readTableOrNull(db.categories),
          properties: row.readTableOrNull(db.itemProperties));
    }).toList();

    // Implement group by, return map
    final mapGroupBy = groupBy(
        listEntryData, (EntryItemWithCategoryWithProperties e) => e.item.id);

    // Shape result into list from map
    final listData = mapGroupBy.entries.map((entry) {
      final value = entry.value;

      // Get first index with item property
      final item = value[0].item;

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

  Future<int> deleteItemByItemId(int itemId) async {
    return transaction(() async {
      await deleteItemCategoryByItemId(itemId);
      await deleteItemPropertyByItemId(itemId);
      return (delete(db.items)..where((tbl) => tbl.id.equals(itemId))).go();
    });
  }

  Future<int> deleteItemCategoryByItemId(int itemId) async {
    return (delete(db.itemCategories)
          ..where((tbl) => tbl.itemId.equals(itemId)))
        .go();
  }

  Future<int> deleteItemCategoryByCategoryId(int categoryId) async {
    return (delete(db.itemCategories)
          ..where((tbl) => tbl.categoryId.equals(categoryId)))
        .go();
  }

  Future<int> deleteItemPropertyByItemId(int itemId) async {
    return (delete(db.itemProperties)
          ..where((tbl) => tbl.itemId.equals(itemId)))
        .go();
  }
}
