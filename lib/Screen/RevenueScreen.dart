import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/RevenueController.dart';
import 'package:hai_noob/Model/Phieu.dart';
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
            text: 'Theo ngày',
            textStyle: TextStyle(color: textColor),
          ),
          majorGridLines: const MajorGridLines(width: 0),
          labelStyle: TextStyle(color: textColor),
          axisLine: AxisLine(color: gridColor),
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(
            text: 'Doanh thu (đ)',
            textStyle: TextStyle(color: textColor),
          ),
          majorGridLines: MajorGridLines(color: gridColor),
          labelStyle: TextStyle(color: textColor),
          numberFormat: NumberFormat.compactSimpleCurrency(locale: 'vi'),
          axisLine: AxisLine(color: gridColor),
        ),
        // Init data
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            name: '',
            // Bind data source
            dataSource: <SalesData>[
              SalesData('14/1', 70000),
              SalesData('15/1', 28000),
              SalesData('16/1', 34000),
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            markerSettings: MarkerSettings(isVisible: true),
            color: AppConfig.MAIN_COLOR,
          )
        ],
      ),
    );
  }
}

class ListRevenue extends GetView<RevenueController> {
  const ListRevenue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 3.0,
        ),
        Text(
          'Chi Tiết (Theo ngày)',
          style: TextStyle(fontSize: 20.0),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          height: 500,
          child: ListView.builder(itemBuilder: (c, i) => RevenueItem()),
        ),
      ],
    );
  }
}

class RevenueItem extends GetView<RevenueController> {
  const RevenueItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            child: Text('leading'),
          ),
          title: Text('title'),
          subtitle: Text('sub title'),
          trailing: Text('trailing'),
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
