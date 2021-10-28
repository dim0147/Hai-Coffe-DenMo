import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Bill/ListBillController.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Component.dart';

class ListBillScreen extends GetView<ListBillController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() => Text('Tất cả Bill (${controller.listBill.length})')),
        ),
        drawer: controller.args == null ? NavigateMenu() : null,
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

class DateRangeSelected extends GetView<ListBillController> {
  const DateRangeSelected({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.args != null) return SizedBox();
    return Obx(
      () => Column(
        children: [
          TextButton.icon(
            onPressed: () => controller.setVisibleDateRangePicker(
                !controller.showDateRangePicker.value),
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

class SearchBar extends GetView<ListBillController> {
  @override
  Widget build(BuildContext context) {
    if (controller.args != null) return SizedBox();
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

class TotalDisplay extends GetView<ListBillController> {
  const TotalDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final Widget? cStateWidget =
            Utils.cStateInLoadingOrError(controller.cState.value);
        if (cStateWidget != null) return cStateWidget;

        final double totalPriceAll = controller.listBill
            .fold(0.0, (pre, cur) => pre + cur.bill.totalPrice);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Tổng cộng: ${Utils.formatDouble(totalPriceAll)}đ'),
          ],
        );
      },
    );
  }
}

class ListBill extends GetView<ListBillController> {
  const ListBill({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          final Widget? cStateWidget =
              Utils.cStateInLoadingOrError(controller.cState.value);
          if (cStateWidget != null) return cStateWidget;

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

class ListItem extends GetView<ListBillController> {
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
          title:
              Text(' ' + Utils.formatDouble(billEntity.bill.totalPrice) + 'đ'),
          subtitle: Text('Loại: $paymentTitle $couponTitle'),
          trailing: Text(Utils.dateExtension
              .dateToDateWithTime(billEntity.bill.createdAt)),
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
