import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Category.dart';
import 'package:hai_noob/Model/Item.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:hai_noob/Model/TableOrders.dart';
import 'package:moor/moor.dart';
import '../DB/Database.dart';

part 'ImportExportDAO.g.dart';

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
}
