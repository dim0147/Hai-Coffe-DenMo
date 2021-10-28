import 'dart:io';

import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../Model/Bill.dart';
import '../Model/Category.dart';
import '../Model/Item.dart';
import '../Model/TableOrders.dart';

part 'Database.g.dart';

// <Implement>
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppConfig.DB_FILE_NAME));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [
  Categories,
  Items,
  ItemCategories,
  ItemProperties,
  TableOrders,
  Bills,
  BillItems,
  BillItemProperties,
  BillCoupons,
  Phieus,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  void insertTest() async {}

  void _seedData() async {}

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        print('onCreate');
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        print('onUpgrade');
      }, beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
        if (details.wasCreated) {
          print('First Time Init Database, Start Seed Data');
          _seedData();
        }

        print('beforeOpen');
      });
}
