import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderCouponController.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Cart.dart';

enum StatusPlaceOrder { LOADING, DONE, ERROR }

class PlaceOrderScreenArgs {
  final int? tableID;
  final Cart cart;

  PlaceOrderScreenArgs({
    required this.cart,
    this.tableID,
  });
}

class PlaceOrderController extends GetxController {
  final args = Utils.tryCast<PlaceOrderScreenArgs>(Get.arguments);
  final appDatabase = Get.find<AppDatabase>();
  late final BillDAO billDAO;

  final cart = Cart(items: []).obs;
  final listCouponScreenData = <CouponScreenData>[].obs;
  final paymentType = BillPayment.Cash.obs;
  final status = StatusPlaceOrder.DONE.obs;

  @override
  void onInit() {
    super.onInit();
    billDAO = BillDAO(appDatabase);

    if (args == null) return;
    cart.value = args!.cart;
  }

  void onAddCoupon() async {
    CouponScreenData? couponScreenData =
        await Get.toNamed('/menu/place-order/add-coupon', arguments: cart.value)
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

  void onConfirm() async {
    try {
      status.value = StatusPlaceOrder.LOADING;
      await billDAO.createBill(
        cart.value,
        paymentType.value,
        listCouponScreenData,
        showTotalPriceWithCoupon(),
      );
      await _printReceipt();
      status.value = StatusPlaceOrder.DONE;
      Utils.showSnackBar('Thành công', 'Tạo order thành công');
    } catch (err) {
      status.value = StatusPlaceOrder.ERROR;
      Utils.showSnackBar(
        'Lỗi',
        'Không thể tạo order:\n- ${err.toString()}',
      );
    }
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
