import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Phieu/ListPhieuController.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Component.dart';

class ListPhieuScreen extends GetView<ListPhieuController> {
  void onSubmit(Object? value) {
    if (value == null || !(value is PickerDateRange)) return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              Obx(() => Text('Tất cả Phiếu (${controller.listPhieu.length})')),
        ),
        drawer: controller.args == null ? NavigateMenu() : null,
        body: Column(
          children: [
            DateRangeSelected(),
            FilterPhieu(),
            TotalDisplay(),
            ListPhieu(),
          ],
        ),
        floatingActionButton: controller.args == null
            ? FloatingActionButton(
                onPressed: controller.onFloatingBtn,
                child: const Icon(Icons.add),
                backgroundColor: AppConfig.MAIN_COLOR,
              )
            : null,
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
    if (controller.args != null) return SizedBox();
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
              onSubmit: controller.onSubmitDateRange,
              onCancel: controller.onCancelDateRange,
              headerStyle: DateRangePickerHeaderStyle(
                textStyle: TextStyle(
                    color: AppConfig.REVENUE_DATEPICKER_HEADER_TEXT_COLOR),
              ),
              yearCellStyle: DateRangePickerYearCellStyle(
                textStyle: TextStyle(
                    color: AppConfig.REVENUE_DATEPICKER_HEADER_TEXT_COLOR),
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: TextStyle(
                    color: AppConfig.REVENUE_DATEPICKER_RANGE_TEXT_COLOR),
              ),
              rangeTextStyle: TextStyle(
                color: AppConfig.REVENUE_DATEPICKER_HEADER_TEXT_COLOR,
              ),
              backgroundColor: AppConfig.MAIN_COLOR.withOpacity(0.5),
              selectionColor: AppConfig.MAIN_COLOR,
              todayHighlightColor: AppConfig.MAIN_COLOR,
              rangeSelectionColor: AppConfig.MAIN_COLOR.withOpacity(0.5),
              startRangeSelectionColor: AppConfig.MAIN_COLOR,
              endRangeSelectionColor: AppConfig.MAIN_COLOR,
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
          FilterBtn(null, 'Tất cả'),
          SizedBox(width: 8.0),
          FilterBtn(PhieuType.PHIEU_THU, 'Phiếu thu'),
          SizedBox(width: 8.0),
          FilterBtn(PhieuType.PHIEU_CHI, 'Phiếu chi'),
        ],
      ),
    );
  }

  OutlinedButton FilterBtn(PhieuType? phieuType, String displayText) {
    final bool isSelected = controller.filterType.value == phieuType;

    return OutlinedButton(
      onPressed: () => controller.setFilterPhieuType(phieuType),
      style: isSelected
          ? OutlinedButton.styleFrom(
              backgroundColor: AppConfig.MAIN_COLOR,
            )
          : null,
      child: Text(displayText),
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
        final Widget? cStateWidget =
            Utils.cStateInLoadingOrError(controller.cState.value);
        if (cStateWidget != null) return cStateWidget;

        final double totalThu = controller.listPhieu
            .where((e) => e.type == PhieuType.PHIEU_THU)
            .fold(0.0, (prev, e) => prev + e.amount);
        final double totalChi = controller.listPhieu
            .where((e) => e.type == PhieuType.PHIEU_CHI)
            .fold(0.0, (prev, e) => prev + e.amount);
        final double totalAll = totalThu - totalChi;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tổng chi phí: ${Utils.formatDouble(totalAll)}đ'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Tổng thu: +${Utils.formatDouble(totalThu)}đ',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Tổng chi: -${Utils.formatDouble(totalChi)}đ',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
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
          final Widget? cStateWidget =
              Utils.cStateInLoadingOrError(controller.cState.value);
          if (cStateWidget != null) return cStateWidget;

          if (controller.listPhieu.length == 0)
            return Center(child: Text('Không có data'));

          List<Phieu> listPhieu = controller.listPhieu;
          PhieuType? filterType = controller.filterType.value;

          // Apply filter if have
          if (filterType != null)
            listPhieu = listPhieu.where((p) => p.type == filterType).toList();

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
            '+${Utils.formatDouble(phieu.amount)}đ',
            style: TextStyle(color: Colors.green),
          )
        : Text(
            '-${Utils.formatDouble(phieu.amount)}đ',
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
          subtitle:
              Text(Utils.dateExtension.dateToDateWithTime(phieu.createdAt)),
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
