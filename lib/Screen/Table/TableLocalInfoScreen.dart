import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Table/TableLocalInfoController.dart';
import 'package:hai_noob/Model/TableLocal.dart';

class TableLocalInfoScreen extends GetView<TableLocalInfoController> {
  const TableLocalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thông tin bàn'),
        ),
        body: Container(
          child: Center(
            child: controller.obx(
              (state) {
                if (state == null) return Text('Không có data');

                final String status = state.status == TableStatus.Empty
                    ? 'Bàn trống'
                    : 'Đang ngồi';
                final bool cartHaveQuantity =
                    state.cart.showTotalQuantity() > 0;
                final bool haveLastBillID = state.lastOrderId != null;

                final DateTime? date = state.lastUpdate;
                final String dateToString = date != null
                    ? '${date.hour}:${date.minute}  ${date.day}/${date.month}/${date.year}'
                    : '';

                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('ID: ${state.id}'),
                        SizedBox(height: 8.0),
                        Text('Tên: ${state.name}'),
                        SizedBox(height: 8.0),
                        Text('Số thứ tự: ${state.order}'),
                        SizedBox(height: 8.0),
                        Text(
                          'Trạng thái: $status',
                          style: TextStyle(
                            color: state.status == TableStatus.Empty
                                ? null
                                : Colors.green,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        if (cartHaveQuantity)
                          Column(
                            children: [
                              Text(
                                  'Giỏ hàng: ${Utils.formatDouble(state.cart.showTotalPrice())}đ'),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        if (haveLastBillID)
                          Column(
                            children: [
                              Text('Bill ID gần đây: #${state.lastOrderId}'),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        if (haveLastBillID)
                          Column(
                            children: [
                              Text('Cập nhật lần cuối: $dateToString'),
                              SizedBox(height: 8.0),
                            ],
                          ),
                      ],
                    ));
              },
              onLoading: Column(
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
