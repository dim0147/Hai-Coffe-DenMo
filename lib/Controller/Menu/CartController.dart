import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillController.dart';
import 'package:hai_noob/Model/Cart.dart';

class CartScreenArgs {
  final int? tableID;
  final Cart cart;

  CartScreenArgs({
    required this.cart,
    this.tableID,
  });
}

class CartController extends GetxController {
  final args = Utils.tryCast<CartScreenArgs>(Get.arguments);
  final cart = Cart(items: []).obs;

  @override
  void onInit() {
    super.onInit();

    if (args == null) return;
    cart.value = args!.cart;
  }

  void onClickCartItem(CartItem cartItem) async {
    CartItem? newCartItem =
        await Get.toNamed('/menu/add-special-item', arguments: cartItem)
            as CartItem?;
    if (newCartItem == null) return;

    // Because this will gerenate new cart id
    cart.value.updateCart(newCartItem);
    cart.refresh();
  }

  void onRemoveCartItem(CartItem cartItem) {
    cart.value.removeCartItem(cartItem.uniqueKey);
    cart.refresh();
  }

  void onPayment() {
    final placeOrderScreenArgs =
        PlaceBillScreenArgs(cart: cart.value, tableID: args!.tableID);
    Get.toNamed('/place-bill', arguments: placeOrderScreenArgs);
  }
}
