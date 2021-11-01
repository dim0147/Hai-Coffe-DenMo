import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Menu/CartController.dart';
import 'package:hai_noob/Model/Cart.dart' as CartModel;
import 'package:hai_noob/Model/Cart.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Giỏ Hàng')),
        bottomNavigationBar: Footer(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                CartList(),
                CartTotal(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartList extends GetView<CartController> {
  const CartList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<CartItem> cartItemList = controller.cart.value.items;

      return Column(
        children: cartItemList
            .map(
              (e) => Column(
                children: [
                  CartItemWidget(cartItem: e),
                  Divider(color: AppConfig.MAIN_COLOR),
                ],
              ),
            )
            .toList(),
      );
    });
  }
}

class CartItemWidget extends GetView<CartController> {
  final CartModel.CartItem cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool itemHaveProperty =
        cartItem.properties.any((e) => e.quantity > 0);
    final Iterable<CartItemProperty> propertyList =
        cartItem.properties.where((e) => e.quantity > 0);

    return InkWell(
      onTap: () => controller.onClickCartItem(cartItem),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ItemDelBtn(),
              ItemHeader(),
              ItemQuantity(),
              ItemSubTotal(),
            ],
          ),
          PropertyList(itemHaveProperty, propertyList)
        ],
      ),
    );
  }

  Container ItemDelBtn() {
    return Container(
      child: IconButton(
        onPressed: () => controller.onRemoveCartItem(cartItem),
        icon: Icon(Icons.close),
      ),
    );
  }

  Expanded ItemHeader() {
    final double cartItemSinglePrice = cartItem.item.price;

    return Expanded(
      flex: 3,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FadeInImage(
              placeholder: AssetImage(AppConfig.DEFAULT_IMG_ITEM),
              image: Utils.getImgProvider(cartItem.item.img),
              height: Get.height * 0.1,
              width: Get.width * 0.1,
            ),
          ),
          Expanded(
            child: Text(
              '${cartItem.item.name} (${Utils.formatDouble(cartItemSinglePrice)}đ)',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Expanded ItemQuantity() {
    return Expanded(
      flex: 1,
      child: Text(
        'x${cartItem.totalQuantity}',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Expanded ItemSubTotal() {
    final double cartItemSubTotal = cartItem.showPriceMinusItemQuantity();

    return Expanded(
      flex: 1,
      child: Text(
        '${Utils.formatDouble(cartItemSubTotal)}đ',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget PropertyList(
    bool itemHaveProperty,
    Iterable<CartModel.CartItemProperty> propertyList,
  ) {
    if (!itemHaveProperty) return SizedBox();
    return Column(
      children: propertyList.map((e) => PropertyRow(e)).toList(),
    );
  }

  Row PropertyRow(CartModel.CartItemProperty e) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [PropertyHeader(e), PropertyItemAmount(), PropertyTotal(e)],
    );
  }

  Expanded PropertyHeader(CartModel.CartItemProperty e) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            '+ ${e.name} (${Utils.formatDouble(e.amount)}đ x ${e.quantity})'),
      ),
    );
  }

  Expanded PropertyItemAmount() {
    final int cartItemQuantity = cartItem.totalQuantity;

    return Expanded(
      child: Text(
        'x${cartItemQuantity}',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Expanded PropertyTotal(CartModel.CartItemProperty e) {
    final int cartItemQuantity = cartItem.totalQuantity;

    return Expanded(
      child: Text(
        '${Utils.formatDouble(e.showTotalPriceMinusItemQuantity(cartItemQuantity))}đ',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class CartTotal extends GetView<CartController> {
  const CartTotal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final double cartTotal = controller.cart.value.showTotalPrice();

      return Container(
        child: Align(
          alignment: Alignment.topRight,
          child: Text(
            'Tổng cộng: ${Utils.formatDouble(cartTotal)}đ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });
  }
}

class Footer extends GetView<CartController> {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppConfig.FOOTER_MENU_CONTAINER_COLOR,
      ),
      child: Row(
        children: [
          SizedBox(width: 5),

          // Payment
          Expanded(
            flex: 3,
            child: ElevatedButton.icon(
              onPressed: controller.cart.value.showTotalQuantity() > 0
                  ? controller.onPayment
                  : null,
              icon: Icon(Icons.payment),
              label: Text('Thanh Toán'),
            ),
          )
        ],
      ),
    );
  }
}
