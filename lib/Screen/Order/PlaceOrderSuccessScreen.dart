import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderCouponController.dart';
import 'package:hai_noob/Controller/Order/PlaceOrderSuccessController.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Screen/Component.dart';

class PlaceOrderSuccessScreen extends GetView<PlaceOrderSuccessController> {
  const PlaceOrderSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final billID = controller.args?.billID;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thanh toán thành công'),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Icon(
                  Icons.check_circle,
                  size: 80.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Thanh toán thành công, bill ID: #${billID.toString()}',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: controller.onGoMenu,
                        child: Text('MENU'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(120, 40),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      ElevatedButton(
                        onPressed: controller.onGoTablePanel,
                        child: Text('Quản Lí Bàn'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(120, 40),
                        ),
                      ),
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
