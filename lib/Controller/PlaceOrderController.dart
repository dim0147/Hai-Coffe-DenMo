import 'package:get/get.dart';
import 'package:hai_noob/Controller/PlaceOrderCouponController.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Cart.dart';

class PlaceOrderController extends GetxController {
  final cart = Get.arguments as Cart;
  final listCouponScreenData = <CouponScreenData>[].obs;

  void onAddCoupon() async {
    CouponScreenData? couponScreenData =
        await Get.toNamed('/menu/place-order/add-coupon', arguments: cart)
            as CouponScreenData?;
    if (couponScreenData == null) return;

    listCouponScreenData.add(couponScreenData);
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
