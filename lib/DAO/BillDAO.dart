import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Cart.dart';
import 'package:moor/moor.dart';
part 'BillDAO.g.dart';

@UseDao(tables: [Bills])
class BillDAO extends DatabaseAccessor<AppDatabase> with _$BillDAOMixin {
  BillDAO(AppDatabase db) : super(db);

  Future createBill(Cart cart, BillPayment paymentType) {
    return transaction(() async {
      // Create bill
      BillsCompanion bill = BillsCompanion.insert(
        totalQuantities: cart.showTotalQuantity(),
        totalPrice: cart.showTotalPrice(),
        paymentType: paymentType,
      );
    });
  }
}
