import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Phieu/ListPhieuController.dart';
import 'package:hai_noob/DB/Database.dart';

import '../Component.dart';

class ListPhieuScreen extends GetView<ListPhieuController> {
  void onSubmit(Object? value) {
    if (value == null || !(value is PickerDateRange)) return;

    var ad = value;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tất cả phiếu'),
        ),
        drawer: NavigateMenu(),
        body: Column(
          children: [
            DateRangeSelected(),
            FilterPhieu(),
            TotalDisplay(),
            ListPhieu(),
          ],
        ),
      ),
    );
  }
}

class DateRangeSelected extends GetView<ListPhieuController> {
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
            icon: Icon(Icons.expand),
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

class FilterPhieu extends GetView<ListPhieuController> {
  const FilterPhieu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: () => controller.setFilterPhieuType(null),
            style: controller.filterType.value == null
                ? OutlinedButton.styleFrom(
                    backgroundColor: AppConfig.MAIN_COLOR,
                  )
                : null,
            child: Text('Tất cả'),
          ),
          SizedBox(width: 8.0),
          OutlinedButton(
            onPressed: () => controller.setFilterPhieuType(PhieuType.PHIEU_THU),
            child: Text('Phiếu thu'),
            style: controller.filterType.value == PhieuType.PHIEU_THU
                ? OutlinedButton.styleFrom(
                    backgroundColor: AppConfig.MAIN_COLOR,
                  )
                : null,
          ),
          SizedBox(width: 8.0),
          OutlinedButton(
            onPressed: () => controller.setFilterPhieuType(PhieuType.PHIEU_CHI),
            child: Text('Phiếu chi'),
            style: controller.filterType.value == PhieuType.PHIEU_CHI
                ? OutlinedButton.styleFrom(
                    backgroundColor: AppConfig.MAIN_COLOR,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class TotalDisplay extends GetView<ListPhieuController> {
  const TotalDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final double totalThu = controller.listPhieu
            .where((e) => e.type == PhieuType.PHIEU_THU)
            .fold(0.0, (prev, e) => prev + e.amount);
        final double totalChi = controller.listPhieu
            .where((e) => e.type == PhieuType.PHIEU_CHI)
            .fold(0.0, (prev, e) => prev + e.amount);
        final double totalAll = totalThu - totalChi;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Tổng chi phí: ${totalAll.toPrecision(2)}đ'),
            Text(
              'Tổng thu: +${totalThu.toPrecision(2)}đ',
              style: TextStyle(color: Colors.green),
            ),
            Text(
              'Tổng chi: -${totalChi.toPrecision(2)}đ',
              style: TextStyle(color: Colors.red),
            ),
          ],
        );
      },
    );
  }
}

class ListPhieu extends GetView<ListPhieuController> {
  const ListPhieu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          if (controller.listPhieu.length == 0)
            return Center(child: Text('Không có data'));

          List<Phieu> listPhieu = controller.listPhieu;
          PhieuType? filterType = controller.filterType.value;

          // Apply filter if have
          if (filterType != null)
            listPhieu = controller.listPhieu
                .where((p) => p.type == filterType)
                .toList();

          return ListView.builder(
            itemCount: listPhieu.length,
            itemBuilder: (c, i) => ListItem(
              phieu: listPhieu[i],
            ),
          );
        },
      ),
    );
  }
}

class ListItem extends GetView<ListPhieuController> {
  final Phieu phieu;

  const ListItem({
    Key? key,
    required this.phieu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget trailingText = phieu.type == PhieuType.PHIEU_THU
        ? Text(
            '+${phieu.amount}đ',
            style: TextStyle(color: Colors.green),
          )
        : Text(
            '-${phieu.amount}đ',
            style: TextStyle(color: Colors.red),
          );

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(phieu.id.toString()),
          ),
          title: Text(phieu.reason),
          subtitle: Text(Utils.dateToDateWithTime(phieu.createdAt)),
          trailing: trailingText,
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Xoá',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => controller.onRemoveListItem(phieu.id),
        ),
      ],
    );
  }
}
