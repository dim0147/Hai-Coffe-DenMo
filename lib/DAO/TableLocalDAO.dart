import 'package:hai_noob/Model/TableLocal.dart';
import 'package:hive/hive.dart';

class TableLocalDAO {
  final Box<TableLocal> _box;

  TableLocalDAO({required Box<TableLocal> box}) : _box = box;

  // Query
  Map<dynamic, TableLocal> getAllWithMap() {
    return _box.toMap();
  }

  List<TableLocal> getAllWithList() {
    return _box.values.toList();
  }

  TableLocal? getTable(int tableID) {
    return _box.get(tableID);
  }

  // Create new
  Future<void> addNew(TableLocal tableLocal) {
    return _box.put(tableLocal.id, tableLocal);
  }

  // Update
  Future<void> updateTable(TableLocal tableLocal) {
    return _box.put(tableLocal.id, tableLocal);
  }

  Future<void> updateAllByMap(Map<dynamic, TableLocal> entries) {
    return _box.putAll(entries);
  }

  Future<void> markTableHolding(int tableID) async {
    final table = _box.get(tableID);
    if (table == null) return Future.error('Not found table');

    table.status = TableStatus.Holding;
    updateTable(table);
  }

  // https://stackoverflow.com/questions/68609519/flutter-how-to-bind-hive-watching-into-rxlist-object-in-getx
  Stream<List<TableLocal>> getTableLocalsStream() {
    return _box.watch().map((event) => getAllWithList());
  }
}
