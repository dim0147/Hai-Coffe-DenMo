import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillSuccessController.dart';

class PlaceBillSuccessScreen extends GetView<PlaceBillSuccessController> {
  const PlaceBillSuccessScreen({Key? key}) : super(key: key);

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
                BillStatus(billID: billID),
                Spacer(),
                NavigateBtns(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BillStatus extends GetView<PlaceBillSuccessController> {
  const BillStatus({
    Key? key,
    this.billID,
  }) : super(key: key);

  final int? billID;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Thanh toán thành công, bill ID: #${billID.toString()}',
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }
}

class NavigateBtns extends GetView<PlaceBillSuccessController> {
  const NavigateBtns({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
