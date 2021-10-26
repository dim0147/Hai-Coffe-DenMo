import 'package:hai_noob/Model/Phieu.dart';
import 'package:moor/moor.dart';

import '../DB/Database.dart';

part 'PhieuDAO.g.dart';

@UseDao(tables: [Phieus])
class PhieuDAO extends DatabaseAccessor<AppDatabase> with _$PhieuDAOMixin {
  PhieuDAO(AppDatabase db) : super(db);

  Future<List<Phieu>> getPhieuBetweenDays(
    DateTime startDate,
    DateTime endDate,
  ) {
    return (select(db.phieus)
          ..where((tbl) => tbl.createdAt.isBetweenValues(startDate, endDate))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> addNewPhieu(PhieusCompanion phieu) {
    return into(db.phieus).insert(phieu);
  }

  Future<int> removePhieuById(int phieuId) {
    return (delete(db.phieus)..where((tbl) => tbl.id.equals(phieuId))).go();
  }
}
