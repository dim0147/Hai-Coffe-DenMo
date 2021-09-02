import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/PlaceOrderCouponController.dart';
import 'package:hai_noob/Screen/Component.dart';

class PlaceOrderCouponScreen extends GetWidget<PlaceOrderCouponController> {
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
                // Name
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Tên',
                      prefixIcon: Icon(Icons.library_add),
                    ),
                  ),
                ),

                // Price
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: Get.width * 0.5,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Giá',
                          prefixIcon: Icon(
                            Icons.local_offer,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Obx(
                  () => Column(
                    children: [
                      RadioPrimary<CouponType>(
                        title: 'Thêm',
                        originValue: CouponType.increase,
                        valueChanged: controller.couponType.value,
                        onChanged: controller.onChangeCouponType,
                      ),
                      // Radio(
                      //   value: CouponType.increase,
                      //   groupValue: controller.couponType.value,
                      //   onChanged: controller.onChangeCouponType,
                      // ),
                      // Text('Thêm'),

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
                      onPressed: () {},
                      icon: Icon(Icons.payment),
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
