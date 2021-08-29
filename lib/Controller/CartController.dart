import 'package:get/get.dart';
import 'package:hai_noob/Model/Cart.dart';

class CartController extends GetxController {
  final cart = Cart(items: []).obs;

  @override
  void onInit() {
    super.onInit();
    Cart cartArguments = Get.arguments;
    cart.value = cartArguments;

    var d;
  }

  void onCancelClick() {
    Get.back();
  }
}
