import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:hai_noob/Model/Revenue.dart';
import 'package:moor/moor.dart';
part 'AnalyzeDAO.g.dart';

@UseDao(tables: [Bills, Phieus])
class AnalyzeDAO extends DatabaseAccessor<AppDatabase> with _$AnalyzeDAOMixin {
  AnalyzeDAO(AppDatabase db) : super(db);

  Future getRevenue(DateTime startDate, DateTime endDate) async {
    BillRevenue? billRevenue;
    PhieuRevenue? phieuThuRevenue;
    PhieuRevenue? phieuChiRevenue;

    final Future<BillRevenue> billRevenueTask =
        getBillRevenue(startDate, endDate).then((value) => billRevenue = value);

    final Future<PhieuRevenue> phieuChiRevenueTask =
        getPhieuRevenue(startDate, endDate, PhieuType.PHIEU_CHI)
            .then((value) => phieuChiRevenue = value);

    final Future<PhieuRevenue> phieuThuRevenueTask =
        getPhieuRevenue(startDate, endDate, PhieuType.PHIEU_THU)
            .then((value) => phieuThuRevenue = value);

    await Future.wait<void>(
        [billRevenueTask, phieuChiRevenueTask, phieuThuRevenueTask]);

    if (billRevenue == null ||
        phieuThuRevenue == null ||
        phieuChiRevenue == null)
      return Future.error('Một trong những task get Revenue is null');

    final Revenue revenue = Revenue(
      billRevenue as BillRevenue,
      phieuThuRevenue as PhieuRevenue,
      phieuChiRevenue as PhieuRevenue,
    );

    var ad;
  }

  Future<BillRevenue> getBillRevenue(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final Expression<int> amountOfBills = countAll();
    final Expression<double?> totalRevenue = bills.totalPrice.sum();

    final TypedResult queryResult = await (db.select(bills)
          ..where((tbl) => tbl.createdAt.isBetweenValues(startDate, endDate)))
        .addColumns([amountOfBills, totalRevenue]).getSingle();

    final BillRevenue billRevenue = BillRevenue(
      queryResult.read(amountOfBills),
      queryResult.read(totalRevenue),
      startDate,
      endDate,
    );

    return billRevenue;
  }

  Future<PhieuRevenue> getPhieuRevenue(
    DateTime startDate,
    DateTime endDate,
    PhieuType phieuType,
  ) async {
    final Expression<int> ammountOfPhieus = countAll();
    final Expression<double?> totalRevenue = phieus.amount.sum();

    final TypedResult queryResult = await (select(phieus)
          ..where((tbl) => tbl.createdAt.isBetweenValues(startDate, endDate))
          ..where((tbl) => tbl.type.equalsValue(phieuType)))
        .addColumns([ammountOfPhieus, totalRevenue]).getSingle();

    final PhieuRevenue phieuRevenue = PhieuRevenue(
      queryResult.read(ammountOfPhieus),
      queryResult.read(totalRevenue),
      startDate,
      endDate,
      phieuType,
    );

    return phieuRevenue;
  }
}
