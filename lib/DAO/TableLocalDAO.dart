import 'package:hai_noob/Model/Cart.dart';
import 'package:hai_noob/Model/TableLocal.dart';
import 'package:hive/hive.dart';

class TableLocalDAO {
  final Box<TableLocal> _box;

  TableLocalDAO({required Box<TableLocal> box}) : _box = box;

  // Query
  // https://stackoverflow.com/questions/68609519/flutter-how-to-bind-hive-watching-into-rxlist-object-in-getx
  Stream<List<TableLocal>> getTableLocalsStream() {
    return _box.watch().map((event) => getAllWithList());
  }

  Map<dynamic, TableLocal> getAllWithMap() {
    return _box.toMap();
  }

  List<TableLocal> getAllWithList() {
    return _box.values.toList();
  }

  List<TableLocal> getTableWithStatus(TableStatus status) {
    return _box.values.where((e) => e.status == status).toList();
  }

  TableLocal? getTable(int tableID) {
    return _box.get(tableID);
  }

  // Create new
  Future<void> addNew(TableLocal tableLocal) {
    return _box.put(tableLocal.id, tableLocal);
  }

  // Update
  Future<void> _updateTable(TableLocal tableLocal) {
    return _box.put(tableLocal.id, tableLocal);
  }

  Future<void> updateAllByMap(Map<dynamic, TableLocal> entries) {
    return _box.putAll(entries);
  }

  Future<void> updateTable(
    int tableID, {
    String? name,
    int? order,
    TableStatus? status,
    Cart? cart,
    int? lastOrderID,
    DateTime? lastUpdate,
  }) async {
    final table = getTable(tableID);
    if (table == null) return Future.error('Not found table');

    // Update default
    if (name != null) table.name = name;
    if (order != null) table.order = order;
    if (status != null) table.status = status;
    if (cart != null) table.cart = cart;
    if (lastOrderID != null) table.lastOrderId = lastOrderID;
    if (lastUpdate != null) table.lastUpdate = lastUpdate;

    return _updateTable(table);
  }

  Future<void> setNullProperty(
    int tableID, {
    bool? lastOrderID,
    bool? lastUpdate,
  }) async {
    final table = getTable(tableID);
    if (table == null) return Future.error('Not found table');

    // Update nullable field
    if (lastOrderID != null && lastOrderID) table.lastOrderId = null;
    if (lastUpdate != null && lastUpdate) table.lastUpdate = null;

    return _updateTable(table);
  }

  Future<void> removeTable(int tableID) {
    return _box.delete(tableID);
  }

  Future<void> removeAll() {
    return _box.clear();
  }
}
