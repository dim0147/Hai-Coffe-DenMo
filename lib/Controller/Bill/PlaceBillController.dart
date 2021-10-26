import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillCouponController.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillSuccessController.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Cart.dart';
import 'package:hai_noob/Model/TableLocal.dart';

enum StatusPlaceBill { LOADING, DONE, ERROR }

class PlaceBillScreenArgs {
  final int? tableID;
  final Cart cart;

  PlaceBillScreenArgs({
    required this.cart,
    this.tableID,
  });
}

class PlaceBillController extends GetxController {
  final args = Utils.tryCast<PlaceBillScreenArgs>(Get.arguments);
  final appDatabase = Get.find<AppDatabase>();
  final tableLocalDAO = Get.find<TableLocalDAO>();
  late final BillDAO billDAO;

  final status = StatusPlaceBill.DONE.obs;
  final cart = Cart(items: []).obs;
  final listCouponScreenData = <CouponScreenData>[].obs;
  final paymentType = BillPayment.Cash.obs;
  final markTableEmptyWhenPaymentDone = true.obs;

  @override
  void onInit() {
    super.onInit();
    billDAO = BillDAO(appDatabase);

    if (args == null) return;
    cart.value = args!.cart;
  }

  void onAddCoupon() async {
    CouponScreenData? couponScreenData =
        await Get.toNamed('/place-bill/add-coupon', arguments: cart.value)
            as CouponScreenData?;
    if (couponScreenData == null) return;

    listCouponScreenData.add(couponScreenData);
  }

  void onRemoveCoupon(String couponName) {
    listCouponScreenData.value =
        listCouponScreenData.where((e) => e.name != couponName).toList();
  }

  void onChangePaymentType(BillPayment? payment) {
    if (payment == null) return;
    paymentType.value = payment;
  }

  void onMarkTableEmptyWhenPaymentDone(bool? mark) {
    if (mark == null) return;
    markTableEmptyWhenPaymentDone.value = mark;
  }

  void onConfirm() async {
    try {
      status.value = StatusPlaceBill.LOADING;

      // Create bill
      final billID = await billDAO.createBill(
        cart.value,
        paymentType.value,
        listCouponScreenData,
        showTotalPriceWithCoupon(),
      );
      // Update table Cart
      await updateTableAfterPaymentDone(billID);

      await _printReceipt();

      // Goto success order screeen
      final placeOrderSuccesScreensArgs = PlaceBillSuccessScreenArgs(
        cart: cart.value,
        billID: billID,
        tableID: args!.tableID,
      );
      Get.offAllNamed(
        '/place-bill/success',
        arguments: placeOrderSuccesScreensArgs,
      );
      status.value = StatusPlaceBill.DONE;
    } catch (err) {
      status.value = StatusPlaceBill.ERROR;
      Utils.showSnackBar(
        'Lỗi',
        'Không thể tạo order:\n- ${err.toString()}',
      );
    }
  }

  Future<void> updateTableAfterPaymentDone(int billID) async {
    final tableID = args!.tableID;
    if (tableID == null) return;

    final table = tableLocalDAO.getTable(tableID);
    if (table == null)
      return Utils.showSnackBar(
          'Lỗi', 'Không tìm thấy bàn ID: ' + tableID.toString());

    return tableLocalDAO.updateTable(
      tableID,
      cart: Cart(
        tableId: tableID,
        items: [],
      ),
      lastOrderID: billID,
      lastUpdate: DateTime.now(),
      status: markTableEmptyWhenPaymentDone.value ? TableStatus.Empty : null,
    );
  }

  Future<void> _printReceipt() async {}

  double showTotalPriceWithCoupon() {
    double couponPrice = listCouponScreenData.fold(
        0.0,
        (previousValue, e) => e.type == CouponType.increase
            ? previousValue + e.price
            : previousValue - e.price);

    return cart.value.showTotalPrice() + couponPrice;
  }
}
