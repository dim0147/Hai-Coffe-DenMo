import 'package:moor/moor.dart';

enum BillPayment { Cash, Card }

enum CouponType { increase, decrease }

class Bills extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get totalQuantities => integer()();
  RealColumn get discount => real().nullable()();
  RealColumn get totalPrice => real()();
  IntColumn get issueId => integer().customConstraint('REFERENCES users(id)')();
  IntColumn get payment => intEnum<BillPayment>()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}

// One bill have many bill items
class BillItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get billId => integer().customConstraint('REFERENCES bills(id)')();
  TextColumn get itemName => text()();
  IntColumn get quality => integer()();
  RealColumn get price => real()();
}

// One bill item have many properties, eg: Thêm đường
class BillItemProperties extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get billItemId =>
      integer().customConstraint('REFERENCES bill_items(id)')();
  TextColumn get name => text()();
  RealColumn get amount => real()();
}

// Bill can have many coupon, eg: Khuyễn mãi cho e linh
class BillCoupons extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get billId => integer().customConstraint('REFERENCES bills(id)')();
  TextColumn get name => text()();
  RealColumn get price => real()();
  IntColumn get percent => integer()();
  IntColumn get couponType => intEnum<CouponType>()();
}
