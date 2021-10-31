import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/Model/Category.dart';
import 'package:moor/moor.dart';
import '../DB/Database.dart';

part 'CategoryDAO.g.dart';

@UseDao(tables: [Categories])
class CategoryDAO extends DatabaseAccessor<AppDatabase>
    with _$CategoryDAOMixin {
  $CategoriesTable? table;
  late final ItemsDAO itemDAO;

  CategoryDAO(AppDatabase db) : super(db) {
    table = db.categories;
    itemDAO = ItemsDAO(db);
  }

  Future<List<Category>> listAllCategory() async {
    return select(table!).get();
  }

  Future<Category?> findCategoryByName(String name) async {
    return (select(table!)..where((tbl) => tbl.name.equals(name)))
        .getSingleOrNull();
  }

  Future<Category?> findCategoryById(int categoryId) async {
    return (select(table!)..where((tbl) => tbl.id.equals(categoryId)))
        .getSingleOrNull();
  }

  Future<bool> addNew(CategoriesCompanion category) async {
    await into(table!).insert(category);
    return true;
  }

  Future updateCategoryById(
    int categoryId,
    CategoriesCompanion categoryCompanion,
  ) async {
    return (update(db.categories)..where((tbl) => tbl.id.equals(categoryId)))
        .write(categoryCompanion);
  }

  Future<void> deleteCategoryById(int categoryId) async {
    return transaction(() async {
      // Delete item tables
      await itemDAO.deleteItemCategoryByCategoryId(categoryId);

      await (delete(categories)..where((tbl) => tbl.id.equals(categoryId)))
          .go();
    });
  }

  Future<int> deleteAll() async {
    return delete(table!).go();
  }
}
