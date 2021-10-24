import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Menu/CartController.dart';
import 'package:hai_noob/Model/Cart.dart' as CartModel;

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
            child: Obx(() => Column(
                  children: [
                    // Item
                    ...controller.cart.value.items
                        .map((e) => Column(
                              children: [
                                CartItem(cartItem: e),
                                Divider(
                                  color: AppConfig.MAIN_COLOR,
                                ),
                              ],
                            ))
                        .toList(),

                    // Total
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Tổng cộng: ${Utils.formatDouble(controller.cart.value.showTotalPrice())}đ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class CartItem extends GetView<CartController> {
  final CartModel.CartItem cartItem;

  const CartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.onClickCartItem(cartItem),
      child: Column(
        children: [
          // Item
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: TextButton.icon(
                    onPressed: () => controller.onRemoveCartItem(cartItem),
                    icon: Icon(Icons.close),
                    label: Text('')),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FadeInImage(
                        placeholder: AssetImage(AppConfig.DEFAULT_IMG_ITEM),
                        image: Utils.getImg(cartItem.item.img),
                        height: Get.height * 0.1,
                        width: Get.width * 0.1,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${cartItem.item.name} (${Utils.formatDouble(cartItem.item.price)}đ)',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    'x${cartItem.totalQuantity}',
                    style: TextStyle(color: Colors.white),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    Utils.formatDouble(cartItem.showPriceMinusItemQuantity()) +
                        'đ',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),

          if (cartItem.properties.any((e) => e.quantity > 0))
            // Properties
            Column(
                children: cartItem.properties
                    .where((e) => e.quantity > 0)
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      '+ ${e.name} (${e.amount}đ x ${e.quantity})'),
                                )),
                            Expanded(
                                child: Text(
                              'x${cartItem.totalQuantity}',
                              style: TextStyle(color: Colors.white),
                            )),
                            Expanded(
                                child: Text(
                              '${Utils.formatDouble(e.showTotalPriceMinusItemQuantity(cartItem.totalQuantity))}đ',
                              style: TextStyle(color: Colors.white),
                            ))
                          ],
                        ))
                    .toList())
        ],
      ),
    );
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
        color: Colors.orangeAccent[200],
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
