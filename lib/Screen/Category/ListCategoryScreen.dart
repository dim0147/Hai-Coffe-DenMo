import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Category/ListCategoryController.dart';
import 'package:hai_noob/DB/Database.dart';

import '../Component.dart';

class ListCategoryScreen extends GetView<ListCategoryController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Tất cả danh mục')),
        drawer: NavigateMenu(),
        body: Container(
          child: controller.obx(
            (categories) {
              if (categories == null)
                return Center(child: Text('Không có data'));

              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (c, i) => ListItem(category: categories[i]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ListItem extends GetView<ListCategoryController> {
  final Category category;

  const ListItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(category.id.toString()),
          ),
          title: Text(category.name),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Chỉnh sửa',
          color: Colors.black87,
          icon: Icons.edit,
          onTap: () => controller.onEditListItem(category.id),
        ),
        IconSlideAction(
          caption: 'Xoá',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => controller.onRemoveListItem(category.id),
        ),
      ],
    );
  }
}
