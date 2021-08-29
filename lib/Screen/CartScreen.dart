import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/CartController.dart';
import 'package:hai_noob/Model/Cart.dart' as CartModel;

class CartScreen extends GetWidget<CartController> {
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
                Row(
                  children: [
                    Expanded(flex: 6, child: Text('Tên + Giá')),
                    Expanded(child: Text('Số Lượng')),
                    Expanded(child: Text('Tổng Cộng')),
                  ],
                ),
                Divider(),

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
                        'Tổng cộng: ${controller.cart.value.showTotalPrice()}đ'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final CartModel.CartItem cartItem;

  const CartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          // Item
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FadeInImage(
                        placeholder: AssetImage(AppConfig.DEFAULT_IMG_ITEM),
                        image: Utils.getImg(cartItem.item.img),
                        height: Get.height * 0.1,
                        width: Get.width * 0.2,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${cartItem.item.name} (${cartItem.item.price}đ)',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Text('x${cartItem.quality}')),
              Expanded(
                  flex: 1,
                  child:
                      Text(cartItem.showPriceWithQuality().toString() + 'đ')),
            ],
          ),

          if (cartItem.properties.any((e) => e.quantity > 0))
            // Properties
            Column(
                children: cartItem.properties
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
                            Expanded(child: Text('x${cartItem.quality}')),
                            Expanded(
                                child: Text(
                                    '${e.showTotalPriceMinusItemQuantity(cartItem.quality)}đ'))
                          ],
                        ))
                    .toList()

                // [
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Text('+ Thêm dường (10.0đ)'),
                //       Text('x2'),
                //       Text('10.000đ')
                //     ],
                //   ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Text('+ Thêm dường (1.0đ)'),
                //       Text('x5'),
                //       Text('10.000đ')
                //     ],
                //   ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [Text('+ Thêm dường'), Text('x5'), Text('10.000đ')],
                //   ),
                // ],
                )
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
          // Cancel
          Expanded(
            flex: 3,
            child: OutlinedButton.icon(
              onPressed: controller.onCancelClick,
              icon: Icon(Icons.arrow_back),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    width: 2.0, color: Get.theme.primaryColor.withOpacity(0.5)),
              ),
              label: Text('Quay Lại'),
            ),
          ),

          SizedBox(width: 5),

          // Payment
          Expanded(
            flex: 3,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.payment),
              label: Text('Payment'),
            ),
          )
        ],
      ),
    );
  }
}
