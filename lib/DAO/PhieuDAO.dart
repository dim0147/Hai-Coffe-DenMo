import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/Model/Category.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:moor/moor.dart';
import '../DB/Database.dart';

part 'PhieuDAO.g.dart';

@UseDao(tables: [Phieus])
class PhieuDAO extends DatabaseAccessor<AppDatabase> with _$PhieuDAOMixin {
  PhieuDAO(AppDatabase db) : super(db);

  Future<int> addNewPhieu(PhieusCompanion phieu) {
    return into(db.phieus).insert(phieu);
  }

  Future<int> removePhieuById(int phieuId) {
    return (delete(db.phieus)..where((tbl) => tbl.id.equals(phieuId))).go();
  }
}
