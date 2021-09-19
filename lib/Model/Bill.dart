import 'package:moor/moor.dart';

enum BillPayment { Cash, Card }

enum CouponType { increase, decrease }

class Bills extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get totalQuantities => integer()();
  RealColumn get totalPrice => real()();
  IntColumn get paymentType => intEnum<BillPayment>()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}

// One bill have many items
class BillItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get billId => integer().customConstraint('REFERENCES bills(id)')();
  TextColumn get itemName => text()();
  TextColumn get itemImg => text()();
  RealColumn get itemPrice => real()();
  IntColumn get totalQuantity => integer()();
  RealColumn get totalPrice => real()();
}

// One item have many properties, eg: Thêm đường
class BillItemProperties extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get billItemId =>
      integer().customConstraint('REFERENCES bill_items(id)')();
  TextColumn get name => text()();
  RealColumn get propertyPrice => real()();
  IntColumn get totalQuantity => integer()();
  RealColumn get totalPrice => real()();
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
