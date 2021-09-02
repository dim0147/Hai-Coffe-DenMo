import 'package:get/get.dart';

enum CouponType { increase, decrease }

class PlaceOrderCouponController extends GetxController {
  final couponType = CouponType.decrease.obs;

  void onChangeCouponType(CouponType? value) {
    if (value == null) return;

    couponType.value = value;
  }

  void onCancelClick() {}
}
