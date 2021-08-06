import 'package:hai_noob/Model/Category.dart';
import 'package:moor/moor.dart';
import '../DB/Database.dart';

part 'CategoryDAO.g.dart';

@UseDao(tables: [Categories])
class CategoryDAO extends DatabaseAccessor<AppDatabase>
    with _$CategoryDAOMixin {
  $CategoriesTable? table;

  CategoryDAO(AppDatabase db) : super(db) {
    table = db.categories;
  }

  Future<List<Category>> listAllCategory() async {
    return select(table!).get();
  }

  Future<Category?> findCategoryByName(String name) async {
    return (select(table!)..where((tbl) => tbl.name.equals(name)))
        .getSingleOrNull();
  }

  Future<bool> addNew(CategoriesCompanion category) async {
    await into(table!).insert(category);
    return true;
  }

  Future<int> deleteAll() async {
    return delete(table!).go();
  }
}
