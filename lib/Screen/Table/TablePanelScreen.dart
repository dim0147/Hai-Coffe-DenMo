import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/Table/TablePanelController.dart';
import 'package:hai_noob/Model/TableLocal.dart';

import '../Component.dart';

class TablePanelScreen extends GetWidget<TablePanelController> {
  const TablePanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bàn'),
        ),
        drawer: NavigateMenu(),
        body: Container(
          child: Column(
            children: [
              TableFilterStatus(),
              Divider(
                thickness: 2.0,
              ),
              ListTable()
            ],
          ),
        ),
      ),
    );
  }
}

class ListTable extends GetView<TablePanelController> {
  const ListTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          children:
              controller.tableLocals.map((e) => TableItem(table: e)).toList(),
        ),
      ),
    );
  }
}

class TableItem extends GetView<TablePanelController> {
  final TableLocal table;

  const TableItem({
    Key? key,
    required this.table,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color:
              table.status == TableStatus.Empty ? null : AppConfig.MAIN_COLOR,
          decoration: table.status == TableStatus.Empty
              ? BoxDecoration(
                  border: Border.all(
                    color: AppConfig.MAIN_COLOR,
                  ),
                )
              : null,
          width: Get.width * 0.2,
          height: 70,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => controller.onTapTable(table.id),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(table.name),
                ),
              ),
            ),
          ),
        ),
        PopupMenuButton(
          color: AppConfig.BACKGROUND_COLOR,
          icon: Icon(
            Icons.expand_more,
            color: AppConfig.MAIN_COLOR,
          ),
          onSelected: (TableAction? value) =>
              controller.onTableAction(3, value),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<TableAction>>[
            if (table.cart != null)
              PopupMenuItem<TableAction>(
                value: TableAction.GO_PAYMENT,
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.payment,
                          size: 20.0,
                          color: AppConfig.FONT_COLOR,
                        ),
                      ),
                      TextSpan(text: '  Thanh toán'),
                    ],
                  ),
                ),
              ),
            if (table.status == TableStatus.Holding)
              PopupMenuItem<TableAction>(
                value: TableAction.MARK_EMPTY,
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.phonelink_off,
                          size: 20.0,
                          color: AppConfig.FONT_COLOR,
                        ),
                      ),
                      TextSpan(text: '  Đánh dấu bàn trống'),
                    ],
                  ),
                ),
              ),
            if (table.status == TableStatus.Empty)
              PopupMenuItem<TableAction>(
                value: TableAction.MARK_HOLDING,
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.phonelink,
                          size: 20.0,
                          color: AppConfig.FONT_COLOR,
                        ),
                      ),
                      TextSpan(text: '  Đánh dấu đang ngồi'),
                    ],
                  ),
                ),
              ),
            if (table.cart != null)
              PopupMenuItem<TableAction>(
                value: TableAction.CLEAR_CART,
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.remove_shopping_cart,
                          size: 20.0,
                          color: AppConfig.FONT_COLOR,
                        ),
                      ),
                      TextSpan(text: '  Xoá giỏ hàng'),
                    ],
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }
}

class TableFilterStatus extends GetView<TablePanelController> {
  const TableFilterStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppConfig.MAIN_COLOR,
                ),
                onPressed: () {},
                child: Text('Tất cả'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: OutlinedButton(
                onPressed: () {},
                child: Text('Đang Trống'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: OutlinedButton(
                onPressed: () {},
                child: Text('Đang Ngồi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
