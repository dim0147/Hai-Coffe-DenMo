import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillCouponController.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillSuccessController.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Cart.dart';
import 'package:hai_noob/Model/TableLocal.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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

  final Rx<CBaseState> cState = CBaseState(CState.DONE).obs;
  final cart = Cart(items: []).obs;
  final listCouponScreenData = <CouponScreenData>[].obs;
  final paymentType = BillPayment.Cash.obs;
  final markTableEmptyWhenPaymentDone = true.obs;

  @override
  void onInit() {
    super.onInit();
    billDAO = BillDAO(appDatabase);
    final cState = this.cState.value;
    cState.setGetC(this.cState);

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
    final cState = this.cState.value;
    try {
      cState.changeState(CState.LOADING);

      final billID = await billDAO.createBill(
        cart.value,
        paymentType.value,
        listCouponScreenData,
        showTotalPriceWithCoupon(),
      );

      await updateTableAfterPaymentDone(billID);
      cState.changeState(CState.DONE);

      await _printReceipt();

      final placeOrderSuccesScreensArgs = PlaceBillSuccessScreenArgs(
        cart: cart.value,
        billID: billID,
        tableID: args!.tableID,
      );
      Get.offAllNamed(
        '/place-bill/success',
        arguments: placeOrderSuccesScreensArgs,
      );
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
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
