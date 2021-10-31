import 'package:collection/collection.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillCouponController.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Cart.dart';
import 'package:moor/moor.dart';
part 'BillDAO.g.dart';

class EntryBillWithJoinData {
  final Bill bill;
  final BillItem item;
  final BillItemPropertie? property;
  final BillCoupon? coupon;

  EntryBillWithJoinData({
    required this.bill,
    required this.item,
    required this.property,
    required this.coupon,
  });
}

class BillItemEntity {
  final BillItem item;
  final List<BillItemPropertie> properties;

  BillItemEntity(this.item, this.properties);
}

class BillEntity {
  final Bill bill;
  final List<BillItemEntity> items;
  final List<BillCoupon> coupons;

  BillEntity(this.bill, this.items, this.coupons);
}

@UseDao(tables: [Bills, BillItems, BillItemProperties, BillCoupons])
class BillDAO extends DatabaseAccessor<AppDatabase> with _$BillDAOMixin {
  BillDAO(AppDatabase db) : super(db);
  Future<List<BillEntity>> getBillBetweenDay(
      DateTime startDay, DateTime endDay) async {
    final List<TypedResult> queryResult = await (select(db.bills)
          ..where((tbl) => tbl.createdAt.isBetweenValues(startDay, endDay))
          ..orderBy(
            [
              (t) => OrderingTerm.desc(t.createdAt),
            ],
          ))
        .join([
      leftOuterJoin(
        db.billItems,
        db.billItems.billId.equalsExp(db.bills.id),
      ),
      leftOuterJoin(
        db.billItemProperties,
        db.billItemProperties.billItemId.equalsExp(db.billItems.id),
      ),
      leftOuterJoin(
        db.billCoupons,
        db.billCoupons.billId.equalsExp(db.bills.id),
      ),
    ]).get();
    return convertQueryResultToListBillEntity(queryResult);
  }

  Future<BillEntity?> getById(int billId) async {
    final List<TypedResult> queryResult =
        await (select(db.bills)..where((tbl) => tbl.id.equals(billId))).join([
      leftOuterJoin(
        db.billItems,
        db.billItems.billId.equalsExp(db.bills.id),
      ),
      leftOuterJoin(
        db.billItemProperties,
        db.billItemProperties.billItemId.equalsExp(db.billItems.id),
      ),
      leftOuterJoin(
        db.billCoupons,
        db.billCoupons.billId.equalsExp(db.bills.id),
      ),
    ]).get();
    final bills = convertQueryResultToListBillEntity(queryResult);
    if (bills.length == 0) return null;
    return bills[0];
  }

  List<BillEntity> convertQueryResultToListBillEntity(
    List<TypedResult> queryResult,
  ) {
    // Convert to list entry data
    List<EntryBillWithJoinData> listEntryData = queryResult.map((row) {
      return EntryBillWithJoinData(
          bill: row.readTable(db.bills),
          item: row.readTable(db.billItems),
          property: row.readTableOrNull(db.billItemProperties),
          coupon: row.readTableOrNull(db.billCoupons));
    }).toList();

    // Group bill by bill id
    Map<int, List<EntryBillWithJoinData>> billGroupBy =
        groupBy<EntryBillWithJoinData, int>(
            listEntryData, (EntryBillWithJoinData e) => e.bill.id);

    // Convert EntryBillWithJoinData to BillEntity
    List<BillEntity> bills = billGroupBy.entries.map((e) {
      Bill bill = e.value[0].bill;

      // Convert item with list properties  (BillItemEntity)
      Map<int, List<EntryBillWithJoinData>> itemGroupBy =
          groupBy(e.value, (EntryBillWithJoinData ev) => ev.item.id);
      List<BillItemEntity> items = convertItemMapToBillItemEntity(itemGroupBy);

      // Get coupon
      List<BillCoupon> coupons = e.value
          .map((ev) => ev.coupon)
          .whereType<BillCoupon>()
          .toSet()
          .toList();

      return BillEntity(bill, items, coupons);
    }).toList();

    return bills;
  }

  List<BillItemEntity> convertItemMapToBillItemEntity(
    Map<int, List<EntryBillWithJoinData>> itemGroupBy,
  ) {
    return itemGroupBy.entries.map((e) {
      BillItem item = e.value[0].item;
      // Final property
      List<BillItemPropertie> properties = e.value
          .map((e) => e.property)
          .whereType<BillItemPropertie>()
          .toSet()
          .toList();

      return BillItemEntity(item, properties);
    }).toList();
  }

  Future<int> createBill(
    Cart cart,
    BillPayment paymentType,
    List<CouponScreenData> coupons,
    double totalPriceOfBill, [
    DateTime? randomTime,
  ]) {
    return transaction<int>(() async {
      // Validate
      if (cart.items.length == 0)
        return Future.error('Không có item nào trong giỏ hàng!');

      // Create bill
      BillsCompanion bill = BillsCompanion.insert(
        totalQuantities: cart.showTotalQuantity(),
        subTotal: cart.showTotalPrice(),
        totalPrice: totalPriceOfBill,
        paymentType: paymentType,
        createdAt: randomTime == null ? Value.absent() : Value(randomTime),
      );
      int billId = await into(bills).insert(bill);

      // List Future create items
      final createBillItemTasks = cart.items.map((e) async {
        // Insert bill item
        BillItemsCompanion item = BillItemsCompanion.insert(
          billId: billId,
          itemName: e.item.name,
          itemImg: e.item.img,
          itemPrice: e.item.price,
          totalQuantity: e.totalQuantity,
          totalPrice: e.showPriceMinusItemQuantity(),
          totalPriceWithProperty: e.totalPrice,
        );
        int billItemId = await into(billItems).insert(item);

        // Check if don't have properties
        if (e.showListPropertiesHaveQuantity().length == 0) return billItemId;

        // Insert properties
        final properties = e
            .showListPropertiesHaveQuantity()
            .map((p) => BillItemPropertiesCompanion.insert(
                  billItemId: billItemId,
                  name: p.name,
                  propertyPrice: p.amount,
                  totalQuantity: p.quantity,
                  totalPrice: p.showTotalPrice(),
                  totalPriceMinusItemQuantity:
                      p.showTotalPriceMinusItemQuantity(e.totalQuantity),
                ))
            .toList();
        await batch((batch) => batch.insertAll(billItemProperties, properties));
        return billItemId;
      });
      // Wait for create all bill items done
      await Future.wait(createBillItemTasks);

      // Coupon
      if (coupons.length == 0) return billId;
      final listCoupon = coupons
          .map((e) => BillCouponsCompanion.insert(
                billId: billId,
                name: e.name,
                price: e.price,
                percent: e.percent,
                couponType: e.type,
              ))
          .toList();
      await batch((batch) => batch.insertAll(billCoupons, listCoupon));

      return billId;
    });
  }

  Future removeById(int billId) {
    return transaction(() async {
      final billItem = await (select(db.billItems)
            ..where((tbl) => tbl.billId.equals(billId)))
          .get();
      final billItemIds = billItem.map((e) => e.id);

      await (delete(db.billItemProperties)
            ..where((tbl) => tbl.billItemId.isIn(billItemIds)))
          .go();

      await (delete(db.billItems)..where((tbl) => tbl.billId.equals(billId)))
          .go();

      await (delete(db.billCoupons)..where((tbl) => tbl.billId.equals(billId)))
          .go();

      await (delete(db.bills)..where((tbl) => tbl.id.equals(billId))).go();

      return;
    });
  }
}
