import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderController.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderCouponController.dart';
import 'package:hai_noob/Model/Bill.dart';

class PlaceOrderScreen extends GetView<PlaceOrderController> {
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

                // Coupon list
                Obx(
                  () => Column(
                    children: controller.listCouponScreenData
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text('* ${e.name}'),
                                ),
                                Expanded(child: SizedBox()),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: e.type == CouponType.increase
                                      ? Text('+ ${e.price}đ (${e.percent}%)')
                                      : Text('- ${e.price}đ (${e.percent}%)'),
                                ),
                                IconButton(
                                  color: AppConfig.MAIN_COLOR,
                                  onPressed: () =>
                                      controller.onRemoveCoupon(e.name),
                                  icon: Icon(
                                    Icons.remove,
                                    size: 20.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
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
                Obx(
                  () => Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'TỔNG CỘNG: ${controller.showTotalPriceWithCoupon()}Đ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    ],
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
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Payment
            SizedBox(
              child: controller.status.value != StatusPlaceOrder.LOADING
                  ? ElevatedButton.icon(
                      onPressed: controller.onConfirm,
                      icon: Icon(Icons.check),
                      label: Text('Xác Nhận'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity,
                            30), // double.infinity is the width and 30 is the height
                      ),
                    )
                  : ElevatedButton(
                      onPressed: null,
                      child: CircularProgressIndicator(),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity,
                            30), // double.infinity is the width and 30 is the height
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
