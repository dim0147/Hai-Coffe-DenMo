import 'package:get/get.dart';
import 'package:hai_noob/Model/Cart.dart';

class PlaceOrderController extends GetxController {
  final cart = Get.arguments as Cart;

  void onAddCoupon() async {
    var coupon = await Get.toNamed('/menu/place-order/add-coupon');
  }
}
