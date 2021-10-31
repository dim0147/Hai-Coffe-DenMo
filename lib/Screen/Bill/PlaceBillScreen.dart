import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillController.dart';
import 'package:hai_noob/Controller/Constant.dart';
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
                SubTotalWidget(),
                Divider(
                  thickness: 3.0,
                  color: AppConfig.MAIN_COLOR,
                ),
                ListCoupons(),
                AddCouponWidget(),
                Divider(
                  thickness: 3.0,
                  color: AppConfig.MAIN_COLOR,
                ),
                PaymentTypeWidget(),
                CheckboxMarkTableEmpty(),
                TotalPriceWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubTotalWidget extends GetView<PlaceBillController> {
  const SubTotalWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Tổng Giá: ${Utils.formatDouble(controller.cart.value.showTotalPrice())}đ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
    );
  }
}

class ListCoupons extends GetView<PlaceBillController> {
  const ListCoupons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
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
                      onPressed: () => controller.onRemoveCoupon(e.name),
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
    );
  }
}

class AddCouponWidget extends GetView<PlaceBillController> {
  const AddCouponWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextButton.icon(
          onPressed: controller.onAddCoupon,
          icon: Icon(Icons.add),
          label: Text('Thêm Coupon/Discout')),
    );
  }
}

class PaymentTypeWidget extends GetView<PlaceBillController> {
  const PaymentTypeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
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
    );
  }
}

class CheckboxMarkTableEmpty extends GetView<PlaceBillController> {
  const CheckboxMarkTableEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.args?.tableID == null) return SizedBox();
    return Obx(
      () => CheckboxPrimary(
        title: 'Đánh dấu bàn trống sau khi thanh toán',
        value: controller.markTableEmptyWhenPaymentDone.value,
        onChanged: controller.onMarkTableEmptyWhenPaymentDone,
      ),
    );
  }
}

class TotalPriceWidget extends GetView<PlaceBillController> {
  const TotalPriceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
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
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Payment
            SizedBox(
              child: controller.cState.value.state != CState.LOADING
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
