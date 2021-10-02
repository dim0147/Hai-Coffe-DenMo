import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderCouponController.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Screen/Component.dart';

class PlaceOrderCouponScreen extends GetView<PlaceOrderCouponController> {
  const PlaceOrderCouponScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Coupon/Discount'),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Giá: ${controller.cart.showTotalPrice()}đ'),
                ),

                // Name
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller.nameC,
                    decoration: InputDecoration(
                      labelText: 'Tên',
                      prefixIcon: Icon(Icons.library_add),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: controller.onChangePrice,
                        controller: controller.priceC,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Giá',
                          prefixIcon: Icon(
                            Icons.local_offer,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '=',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    // Percent
                    Expanded(
                      child: TextField(
                        controller: controller.percentC,
                        onChanged: controller.onChangePercent,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Phần trăm (%)',
                          prefixIcon: Icon(
                            Icons.local_offer,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Price
                Obx(
                  () => Column(
                    children: [
                      RadioPrimary<CouponType>(
                        title: 'Thêm',
                        originValue: CouponType.increase,
                        valueChanged: controller.couponType.value,
                        onChanged: controller.onChangeCouponType,
                      ),
                      RadioPrimary<CouponType>(
                        title: 'Giảm',
                        originValue: CouponType.decrease,
                        valueChanged: controller.couponType.value,
                        onChanged: controller.onChangeCouponType,
                      ),
                    ],
                  ),
                ),

                // Footer
                Column(
                  children: [
                    // Add
                    ElevatedButton.icon(
                      onPressed: controller.onAdd,
                      icon: Icon(Icons.add),
                      label: Text('Thêm'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
