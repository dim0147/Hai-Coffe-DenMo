import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/TableOrders.dart';
import 'package:moor/moor.dart';

part 'TableDAO.g.dart';

@UseDao(tables: [TableOrders])
class TableOrderDAO extends DatabaseAccessor<AppDatabase>
    with _$TableOrderDAOMixin {
  TableOrderDAO(AppDatabase db) : super(db);

  Future<int> createTable(String name, int order) {
    final table = TableOrdersCompanion.insert(name: name, order: order);
    return into(tableOrders).insert(table);
  }

  Future<TableOrder?> findTableByName(String name) {
    final query = select(tableOrders)..where((tbl) => tbl.name.equals(name));
    return query.getSingleOrNull();
  }

  Future<int?> getHighestTableOrder() {
    var highestOrder = tableOrders.order.max();
    final query = selectOnly(tableOrders)..addColumns([highestOrder]);

    return query.map((row) => row.read(highestOrder)).getSingleOrNull();
  }
}
