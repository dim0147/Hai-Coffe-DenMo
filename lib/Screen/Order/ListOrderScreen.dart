import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Order/ListOrderController.dart';
import 'package:hai_noob/Controller/Phieu/ListPhieuController.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Component.dart';

class ListOrderScreen extends GetView<ListOrderController> {
  void onSubmit(Object? value) {
    if (value == null || !(value is PickerDateRange)) return;

    var ad = value;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tất cả bill'),
        ),
        drawer: NavigateMenu(),
        body: Column(
          children: [
            DateRangeSelected(),
            SearchBar(),
            TotalDisplay(),
            ListBill(),
          ],
        ),
      ),
    );
  }
}

class DateRangeSelected extends GetView<ListOrderController> {
  const DateRangeSelected({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          TextButton.icon(
            onPressed: () => controller
                .setShowDateRangePicker(!controller.showDateRangePicker.value),
            icon: Icon(Icons.date_range),
            label: Text(
              'Chọn ngày',
            ),
          ),
          if (controller.showDateRangePicker.value)
            SfDateRangePicker(
              controller: controller.dateRangePickerC,
              selectionMode: DateRangePickerSelectionMode.range,
              showActionButtons: true,
              selectionColor: AppConfig.MAIN_COLOR,
              todayHighlightColor: AppConfig.MAIN_COLOR,
              rangeSelectionColor: AppConfig.MAIN_COLOR.withOpacity(0.5),
              startRangeSelectionColor: AppConfig.MAIN_COLOR,
              endRangeSelectionColor: AppConfig.MAIN_COLOR,
              onSubmit: controller.onSubmitDateRange,
              onCancel: controller.onCancelDateRange,
            ),
        ],
      ),
    );
  }
}

class SearchBar extends GetView<ListOrderController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Nhập Bill ID...',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: controller.onSearchKeyword,
      ),
    );
  }
}

class TotalDisplay extends GetView<ListOrderController> {
  const TotalDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final double totalPriceAll = controller.listBill
            .fold(0.0, (pre, cur) => pre + cur.bill.totalPrice);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Tổng cộng: ${totalPriceAll.toPrecision(2)}đ'),
          ],
        );
      },
    );
  }
}

class ListBill extends GetView<ListOrderController> {
  const ListBill({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          if (controller.listBill.length == 0)
            return Center(child: Text('Không có data'));

          return ListView.builder(
            itemCount: controller.listBill.length,
            itemBuilder: (c, i) => ListItem(
              billEntity: controller.listBill[i],
            ),
          );
        },
      ),
    );
  }
}

class ListItem extends GetView<ListOrderController> {
  final BillEntity billEntity;

  const ListItem({
    Key? key,
    required this.billEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String paymentTitle =
        billEntity.bill.paymentType == BillPayment.Card ? 'Tiền mặt' : 'Thẻ';
    final String couponTitle = billEntity.coupons.length > 0
        ? '| Coupon: ${billEntity.coupons.length}'
        : '';
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(billEntity.bill.id.toString()),
          ),
          title: Text(
              ' ' + billEntity.bill.totalPrice.toPrecision(2).toString() + 'đ'),
          subtitle: Text('Loại: $paymentTitle $couponTitle'),
          trailing: Text(Utils.dateToDateWithTime(billEntity.bill.createdAt)),
          onTap: () => controller.onClickItem(billEntity),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Xoá',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => controller.onRemoveListItem(billEntity.bill.id),
        ),
      ],
    );
  }
}
