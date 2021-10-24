import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/RevenueController.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:hai_noob/Model/Revenue.dart';
import 'package:hai_noob/Screen/Component.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../App/Config.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class RevenueScreen extends GetView<RevenueController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Doanh Thu')),
        drawer: NavigateMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FilterDateType(),
              DateRangePicker(),
              GraphRevenue(),
              ListRevenue()
            ],
          ),
        ),
      ),
    );
  }
}

class FilterDateType extends GetView<RevenueController> {
  const FilterDateType({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final RevenueScreenViewType viewType = controller.viewType.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Thông kê theo:'),
          SizedBox(
            width: 10,
          ),
          DropdownButton<RevenueScreenViewType>(
            dropdownColor: AppConfig.MAIN_COLOR,
            items: [
              DropdownMenuItem(
                child: Text('Tháng'),
                value: RevenueScreenViewType.MONTH,
              ),
              DropdownMenuItem(
                child: Text('Ngày'),
                value: RevenueScreenViewType.DAY,
              ),
            ],
            value: viewType,
            onChanged: controller.onChangeViewType,
          ),
        ],
      );
    });
  }
}

class DateRangePicker extends GetView<RevenueController> {
  // final RevenueController controller;

  const DateRangePicker({
    Key? key,
    // required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final RevenueScreenViewType viewType = controller.viewType.value;

      return Container(
        key: Key(viewType.toString()),
        child: SfDateRangePicker(
          view: viewType == RevenueScreenViewType.MONTH
              ? DateRangePickerView.year
              : DateRangePickerView.month,
          allowViewNavigation:
              viewType == RevenueScreenViewType.MONTH ? false : true,
          selectionMode: DateRangePickerSelectionMode.range,
          showActionButtons: true,
          selectionColor: AppConfig.MAIN_COLOR,
          todayHighlightColor: AppConfig.MAIN_COLOR,
          rangeSelectionColor: AppConfig.MAIN_COLOR.withOpacity(0.5),
          startRangeSelectionColor: AppConfig.MAIN_COLOR,
          endRangeSelectionColor: AppConfig.MAIN_COLOR,
          // onSubmit: (Object? ad) => print('cc?'),
          onSubmit: controller.onSubmitDateRange,
        ),
      );
    });
  }
}

class GraphRevenue extends GetView<RevenueController> {
  const GraphRevenue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gridColor = AppConfig.MENU_ITEM_CONTAINER_COLOR;
    final textColor = Colors.white;

    return Obx(() {
      final List<Revenue> listRevenues = controller.listRevenues.value;
      final String headerTitle =
          controller.viewType.value == RevenueScreenViewType.MONTH
              ? 'Theo tháng'
              : 'Theo ngày';

      return Container(
        child: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(enable: true),
          borderColor: AppConfig.MAIN_COLOR.withOpacity(0.5),
          backgroundColor: AppConfig.MAIN_COLOR.withOpacity(0.5),
          plotAreaBorderColor: gridColor,
          title: ChartTitle(
            text: 'Biểu đồ',
            textStyle: TextStyle(color: textColor),
          ),
          // Initialize category axis
          primaryXAxis: CategoryAxis(
            title: AxisTitle(
              text: headerTitle,
              textStyle: TextStyle(color: textColor),
            ),
            majorGridLines: const MajorGridLines(width: 0),
            labelStyle: TextStyle(color: textColor),
            axisLine: AxisLine(color: gridColor),
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compactCurrency(locale: 'vi'),
            title: AxisTitle(
              text: 'Doanh thu (đ)',
              textStyle: TextStyle(color: textColor),
            ),
            majorGridLines: MajorGridLines(color: gridColor),
            labelStyle: TextStyle(color: textColor),
            axisLine: AxisLine(color: gridColor),
          ),
          // Init data
          series: <LineSeries<Revenue, String>>[
            LineSeries<Revenue, String>(
              name: '',
              // Bind data source
              dataSource: listRevenues,
              xValueMapper: (Revenue revenue, _) =>
                  'Tháng ${revenue.startDate.month}',
              yValueMapper: (Revenue revenue, _) => revenue.total(),
              markerSettings: MarkerSettings(isVisible: true),
              color: AppConfig.MAIN_COLOR,
            )
          ],
        ),
      );
    });
  }
}

class ListRevenue extends GetView<RevenueController> {
  const ListRevenue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<Revenue> listRevenues = controller.listRevenues.value;
      listRevenues.sort((a, b) => (b.total() - a.total()).toInt());
      final String headerTitle =
          controller.viewType.value == RevenueScreenViewType.MONTH
              ? 'Theo tháng'
              : 'Theo ngày';
      return Column(
        children: [
          Divider(
            thickness: 3.0,
          ),
          Text(
            'Chi Tiết ($headerTitle)',
            style: TextStyle(fontSize: 20.0),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            height: 500,
            child: ListView.builder(
                itemCount: listRevenues.length,
                itemBuilder: (c, i) => RevenueItem(
                      revenue: listRevenues[i],
                    )),
          ),
        ],
      );
    });
  }
}

class RevenueItem extends GetView<RevenueController> {
  final Revenue revenue;
  const RevenueItem({
    Key? key,
    required this.revenue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = Utils.dateExtension.dateToMonth(revenue.startDate);
    final bill = revenue.bill.totalRevenue ?? 0.0;
    final phieuChi = revenue.phieuChi.totalRevenue ?? 0.0;
    final phieuThu = revenue.phieuThu.totalRevenue ?? 0.0;
    if (bill == 0.0 && phieuChi == 0.0 && phieuThu == 0.0) return Container();

    final phieuChiText =
        phieuChi == 0.0 ? '' : '| Chi: -${Utils.formatDouble(phieuChi)}đ';
    final phieuThuText =
        phieuThu == 0.0 ? '' : '| Thu: +${Utils.formatDouble(phieuThu)}đ';

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: ListTile(
          title: Text('$date'),
          subtitle: Text(
              'Bill: +${Utils.formatDouble(bill)}đ $phieuThuText $phieuChiText'),
          trailing: Text('Tổng cộng: ${Utils.formatDouble(revenue.total())}đ'),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Xem Bill',
          color: Colors.red,
          icon: Icons.receipt,
          onTap: () => {},
        ),
        IconSlideAction(
          caption: 'Xem Phiếu',
          color: Colors.black,
          icon: Icons.receipt_long,
          onTap: () => {},
        ),
      ],
    );
  }
}
