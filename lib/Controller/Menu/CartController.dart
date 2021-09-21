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

  void onClickCartItem(CartItem cartItem) async {
    bool haveProperties = cartItem.properties.length > 0;

    CartItem? newCartItem =
        await Get.toNamed('/menu/add-special-item', arguments: cartItem)
            as CartItem?;
    if (newCartItem == null) return;

    // Because this will gerenate new cart id
    cart.value.updateCart(newCartItem);
    cart.refresh();
  }

  void onRemoveCartItem(CartItem cartItem) {
    print('Hello');
    cart.value.removeCartItem(cartItem.uniqueKey);
    cart.refresh();
  }

  void onPayment() {
    Get.toNamed('/menu/place-order', arguments: cart.value);
  }

  void onCancelClick() {
    Get.back();
  }
}
