import 'dart:io';

import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Category.dart';
import 'package:hai_noob/Model/ConfigGlobal.dart';
import 'package:hai_noob/Model/Item.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:hai_noob/Model/TableOrders.dart';
import 'package:moor/moor.dart';
import '../DB/Database.dart';

part 'ImportExportDAO.g.dart';

class TableCount {
  final int categies;
  final int items;
  final int itemCategories;
  final int itemProperties;
  final int TableOrders;
  final int Bills;
  final int BillItems;
  final int BillItemProperties;
  final int BillCoupons;
  final int Phieus;

  TableCount({
    required this.categies,
    required this.items,
    required this.itemCategories,
    required this.itemProperties,
    required this.TableOrders,
    required this.Bills,
    required this.BillItems,
    required this.BillItemProperties,
    required this.BillCoupons,
    required this.Phieus,
  });
}

class ExportInfo {
  final TableCount tableCount;
  final FolderStatExtension imgFolder;
  final FolderStatExtension dbFolder;

  ExportInfo({
    required this.tableCount,
    required this.imgFolder,
    required this.dbFolder,
  });
}

@UseDao(tables: [
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
class ImportExportDAO extends DatabaseAccessor<AppDatabase>
    with _$ImportExportDAOMixin {
  ImportExportDAO(AppDatabase db) : super(db);

  Future<ExportInfo> getExportInfo() async {
    final Future<TableCount> tableCountFuture = _getTableCount();
    final Future<FolderStatExtension> imgFolderFuture = _getImgFolder();
    final Future<FolderStatExtension> dbFolderFuture = _getDBFolder();

    final List<Future<Object>> futures = [
      tableCountFuture,
      imgFolderFuture,
      dbFolderFuture,
    ];

    final List<Object> result = await Future.wait(futures);
    return ExportInfo(
      tableCount: result[0] as TableCount,
      imgFolder: result[1] as FolderStatExtension,
      dbFolder: result[2] as FolderStatExtension,
    );
  }

  Future<FolderStatExtension> _getImgFolder() async {
    final ConfigGlobal configGlobal = Get.find<ConfigGlobal>();
    final String? stringImgDir = configGlobal.imgPath;
    if (stringImgDir == null) return Future.error('Image Dir null');

    final FolderStatExtension imgDir =
        Utils.fileExtension.dirStatSync(stringImgDir);
    return imgDir;
  }

  Future<FolderStatExtension> _getDBFolder() async {
    final ConfigGlobal configGlobal = Get.find<ConfigGlobal>();
    final String? stringDBDir = configGlobal.dbPath;
    if (stringDBDir == null) return Future.error('DB Dir null');

    final FolderStatExtension dbDir =
        Utils.fileExtension.dirStatSync(stringDBDir);
    return dbDir;
  }

  Future<TableCount> _getTableCount() async {
    final futureList = _getTableCountFutureList();

    final List<int> result = await Future.wait(futureList);

    // Return result
    final TableCount tableCount = TableCount(
      categies: result[0],
      items: result[1],
      itemCategories: result[2],
      itemProperties: result[3],
      TableOrders: result[4],
      Bills: result[5],
      BillItems: result[6],
      BillItemProperties: result[7],
      BillCoupons: result[8],
      Phieus: result[9],
    );

    return tableCount;
  }

  List<Future<int>> _getTableCountFutureList() {
    final Future<int> categoryCount = _getTotalRowsInTable(categories);

    final Future<int> itemCount = _getTotalRowsInTable(items);
    final Future<int> itemCategoryCount = _getTotalRowsInTable(itemCategories);
    final Future<int> itemPropertyCount = _getTotalRowsInTable(itemProperties);

    final Future<int> tableOrderCount = _getTotalRowsInTable(tableOrders);

    final Future<int> billCount = _getTotalRowsInTable(bills);
    final Future<int> billItemCount = _getTotalRowsInTable(billItems);
    final Future<int> billItemPropertyCount =
        _getTotalRowsInTable(billItemProperties);
    final Future<int> billCouponCount = _getTotalRowsInTable(billCoupons);

    final Future<int> phieuCount = _getTotalRowsInTable(phieus);

    return [
      categoryCount,
      itemCount,
      itemCategoryCount,
      itemPropertyCount,
      tableOrderCount,
      billCount,
      billItemCount,
      billItemPropertyCount,
      billCouponCount,
      phieuCount,
    ];
  }

  Future<int> _getTotalRowsInTable<T extends HasResultSet, R>(
    ResultSetImplementation<T, R> table,
  ) async {
    final Expression<int> countAllColumn = countAll();
    final queryResult =
        await (db.selectOnly(table)..addColumns([countAllColumn])).getSingle();

    return queryResult.read(countAllColumn);
  }
}
