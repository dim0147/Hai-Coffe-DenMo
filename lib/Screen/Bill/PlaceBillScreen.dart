import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillController.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Screen/Component.dart';

class PlaceBillScreen extends GetView<PlaceBillController> {
  const PlaceBillScreen({Key? key}) : super(key: key);

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
                    'Tổng Giá: ${Utils.formatDouble(controller.cart.value.showTotalPrice())}đ',
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
                                      ? Text(
                                          '+ ${Utils.formatDouble(e.price)}đ (${e.percent}%)')
                                      : Text(
                                          '- ${Utils.formatDouble(e.price)}đ (${e.percent}%)'),
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

                // Payment Type
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hình thức:  '),
                      DropdownButton<BillPayment>(
                        dropdownColor: AppConfig.MAIN_COLOR,
                        value: controller.paymentType.value,
                        items: [
                          DropdownMenuItem(
                            child: Text('Tiền mặt'),
                            value: BillPayment.Cash,
                          ),
                          DropdownMenuItem(
                            child: Text('Thẻ'),
                            value: BillPayment.Card,
                          ),
                        ],
                        onChanged: controller.paymentType,
                      ),
                    ],
                  ),
                ),

                // Checkbox mark table empty when payment done
                if (controller.args?.tableID != null)
                  Obx(
                    () => CheckboxPrimary(
                      title: 'Đánh dấu bàn trống sau khi thanh toán',
                      value: controller.markTableEmptyWhenPaymentDone.value,
                      onChanged: controller.onMarkTableEmptyWhenPaymentDone,
                    ),
                  ),

                // Total Price
                Obx(
                  () => Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'TỔNG CỘNG: ${Utils.formatDouble(controller.showTotalPriceWithCoupon())}Đ',
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

class Footer extends GetView<PlaceBillController> {
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
              child: controller.status.value != StatusPlaceBill.LOADING
                  ? ElevatedButton.icon(
                      onPressed: controller.onConfirm,
                      icon: Icon(Icons.check),
                      label: Text('Xác Nhận'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          double.infinity,
                          45,
                        ), // double.infinity is the width and 30 is the height
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