import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/PlaceOrderController.dart';

class PlaceOrderScreen extends GetWidget<PlaceOrderController> {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thanh Toán'),
        ),
        bottomNavigationBar: Footer(),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                // Total
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tổng Giá: ${controller.cart.showTotalPrice()}đ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),

                // Divider
                Divider(
                  thickness: 3.0,
                  color: AppConfig.MAIN_COLOR,
                ),

                // Custom price list
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('- Discount'),
                          ),
                          Expanded(child: SizedBox()),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text('+15.000đ'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Add custom price
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton.icon(
                      onPressed: controller.onAddCoupon,
                      icon: Icon(Icons.add),
                      label: Text('Thêm Coupon/Discout')),
                ),
                // Divider
                Divider(
                  thickness: 3.0,
                  color: AppConfig.MAIN_COLOR,
                ),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      'TỔNG CỘNG: 800.000Đ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Footer extends GetView<PlaceOrderController> {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          // color: Colors.orangeAccent[200],
          ),
      // height: Get.height * 0.15,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Payment
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.payment),
            label: Text('Thanh Toán'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity,
                  30), // double.infinity is the width and 30 is the height
            ),
          ),
        ],
      ),
    );
  }
}
