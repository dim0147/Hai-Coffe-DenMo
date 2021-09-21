import 'package:get/get.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderCouponController.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Cart.dart';

enum StatusPlaceOrder { LOADING, DONE, ERROR }

class PlaceOrderController extends GetxController {
  final appDatabase = Get.find<AppDatabase>();
  late final BillDAO billDAO;

  final cart = Get.arguments as Cart;
  final listCouponScreenData = <CouponScreenData>[].obs;
  final status = StatusPlaceOrder.DONE.obs;

  @override
  void onInit() {
    super.onInit();
    billDAO = BillDAO(appDatabase);
  }

  void onAddCoupon() async {
    CouponScreenData? couponScreenData =
        await Get.toNamed('/menu/place-order/add-coupon', arguments: cart)
            as CouponScreenData?;
    if (couponScreenData == null) return;

    listCouponScreenData.add(couponScreenData);
  }

  void onRemoveCoupon(String couponName) {
    listCouponScreenData.value =
        listCouponScreenData.where((e) => e.name != couponName).toList();
  }

  void onConfirm() async {
    try {
      status.value = StatusPlaceOrder.LOADING;
      await billDAO.createBill(
        cart,
        BillPayment.Card,
        listCouponScreenData.value,
        showTotalPriceWithCoupon(),
      );
      status.value = StatusPlaceOrder.DONE;
      Get.snackbar('Thành công', 'Tạo order thành công');
    } catch (err) {
      status.value = StatusPlaceOrder.ERROR;
      Get.snackbar(
        'Lỗi',
        'Không thể tạo order:\n- ${err.toString()}',
      );
    }
  }

  double showTotalPriceWithCoupon() {
    double couponPrice = listCouponScreenData.fold(
        0.0,
        (previousValue, e) => e.type == CouponType.increase
            ? previousValue + e.price
            : previousValue - e.price);

    return cart.showTotalPrice() + couponPrice;
  }
}
