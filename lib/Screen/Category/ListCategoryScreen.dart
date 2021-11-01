import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
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
        body: CategoryListViewWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.onFloatingBtn,
          child: const Icon(Icons.add),
          backgroundColor: AppConfig.MAIN_COLOR,
        ),
      ),
    );
  }
}

class CategoryListViewWidget extends GetView<ListCategoryController> {
  const CategoryListViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Obx(() {
      final Widget? cStateWidget =
          Utils.cStateInLoadingOrError(controller.cState.value);
      if (cStateWidget != null) return cStateWidget;

      final categories = controller.categories.value;
      if (categories.length == 0) return Center(child: Text('Không có data'));

      return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (c, i) => ListItem(category: categories[i]),
      );
    }));
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
          onTap: () => controller.onEditListItem(category.id),
        ),
      ),
      secondaryActions: <Widget>[
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
