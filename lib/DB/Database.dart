import 'dart:io';

import 'package:get/get.dart' as getx;
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Model/ConfigGlobal.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;

import '../Model/Bill.dart';
import '../Model/Category.dart';
import '../Model/Item.dart';
import '../Model/TableOrders.dart';

part 'Database.g.dart';

// <Implement>
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // Get DB Folder
    final ConfigGlobal configGlobal = getx.Get.find<ConfigGlobal>();
    final String? dbPath = configGlobal.dbPath;
    if (dbPath == null) return Future.error('DB Path is null');

    // Get DB File
    final String dbFilePath = p.join(dbPath, AppConfig.DB_FILE_NAME);
    final File dbFile = File(dbFilePath);
    return VmDatabase(dbFile);
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
