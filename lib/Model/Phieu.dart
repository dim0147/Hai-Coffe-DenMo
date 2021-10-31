import 'package:moor/moor.dart';

enum PhieuType {
  PHIEU_CHI,
  PHIEU_THU,
}

class Phieus extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get amount => real()();
  TextColumn get reason => text()();
  IntColumn get type => intEnum<PhieuType>()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
