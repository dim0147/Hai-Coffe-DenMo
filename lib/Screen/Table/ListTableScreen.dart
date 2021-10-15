import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Table/ListTableController.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/TableLocal.dart';

import '../Component.dart';

class ListTableScreen extends GetView<ListTableController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Tất cả bàn')),
        drawer: NavigateMenu(),
        body: Container(
          child: controller.obx(
            (listTables) {
              if (listTables == null)
                return Center(child: Text('Không có data'));

              return ListView.builder(
                itemCount: listTables.length,
                itemBuilder: (c, i) => ListItem(table: listTables[i]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ListItem extends GetView<ListTableController> {
  final TableLocal table;

  const ListItem({
    Key? key,
    required this.table,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(table.id.toString()),
          ),
          title: Text(table.name),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Chỉnh sửa',
          color: Colors.black87,
          icon: Icons.edit,
          onTap: () => controller.onEditListItem(table.id),
        ),
        IconSlideAction(
          caption: 'Xoá',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => controller.onRemoveListItem(table.id),
        ),
      ],
    );
  }
}
