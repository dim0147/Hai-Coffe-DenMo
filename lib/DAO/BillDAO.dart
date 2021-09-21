import 'package:hai_noob/Controller/PlaceOrderCouponController.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Cart.dart';
import 'package:moor/moor.dart';
part 'BillDAO.g.dart';

@UseDao(tables: [Bills, BillItems, BillItemProperties, BillCoupons])
class BillDAO extends DatabaseAccessor<AppDatabase> with _$BillDAOMixin {
  BillDAO(AppDatabase db) : super(db);

  Future createBill(
    Cart cart,
    BillPayment paymentType,
    List<CouponScreenData> coupons,
    double totalPriceOfBill,
  ) {
    return transaction(() async {
      // Create bill
      BillsCompanion bill = BillsCompanion.insert(
        totalQuantities: cart.showTotalQuantity(),
        subTotal: cart.showTotalPrice(),
        totalPrice: totalPriceOfBill,
        paymentType: paymentType,
      );
      int billId = await into(bills).insert(bill);

      // List Future create item
      Iterable<Future<int>> createBillItemTasks = cart.items.map((e) async {
        // Insert bill item
        BillItemsCompanion item = BillItemsCompanion.insert(
          billId: billId,
          itemName: e.item.name,
          itemImg: e.item.img,
          itemPrice: e.item.price,
          totalQuantity: e.totalQuantity,
          totalPrice: e.showPriceMinusPropertiesItem(),
        );
        int billItemId = await into(billItems).insert(item);

        // Check if have properties
        if (e.showListPropertiesHaveQuantity().length == 0) return billItemId;

        // Insert properties
        List<BillItemPropertiesCompanion> properties = e
            .showListPropertiesHaveQuantity()
            .map((p) => BillItemPropertiesCompanion.insert(
                  billItemId: billItemId,
                  name: p.name,
                  propertyPrice: p.amount,
                  totalQuantity: p.quantity,
                  totalPrice: p.showTotalPrice(),
                ))
            .toList();
        await batch((batch) => batch.insertAll(billItemProperties, properties));
        return billItemId;
      });
      // Wait for create all bill items done
      var resultBillItems = await Future.wait(createBillItemTasks);

      // Coupon
      if (coupons.length == 0) return;
      var listCoupon = coupons
          .map((e) => BillCouponsCompanion.insert(
                billId: billId,
                name: e.name,
                price: e.price,
                percent: e.percent,
                couponType: e.type,
              ))
          .toList();
      await batch((batch) => batch.insertAll(billCoupons, listCoupon));
    });
  }
}
