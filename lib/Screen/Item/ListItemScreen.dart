import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Category/ListCategoryController.dart';
import 'package:hai_noob/Controller/Item/ListItemController.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';

import '../Component.dart';

class ListItemScreen extends GetView<ListItemController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Tất cả Item')),
        drawer: NavigateMenu(),
        body: Container(
          child: controller.obx(
            (itemDatas) {
              if (itemDatas == null)
                return Center(child: Text('Không có data'));

              // Filter item
              final searchString = controller.searchString.value;
              print('searchString: $searchString');
              final listItemData = itemDatas
                  .where((e) => searchString == ''
                      ? true
                      : e.item.name
                          .toLowerCase()
                          .contains(searchString.toLowerCase()))
                  .toList();

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Nhập từ khoá tìm kiếm',
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                      onChanged: controller.onChangeSearchBar,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listItemData.length,
                      itemBuilder: (c, i) =>
                          ListItem(itemData: listItemData[i]),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ListItem extends GetView<ListItemController> {
  final ItemDataClass itemData;

  const ListItem({
    Key? key,
    required this.itemData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: ListTile(
          leading: FadeInImage(
            width: 70,
            height: 100,
            placeholder: AssetImage(AppConfig.DEFAULT_IMG_ITEM),
            image: Utils.getImg(itemData.item.image),
          ),
          title: Text(itemData.item.name),
          trailing: Text(itemData.item.price.toString() + 'đ'),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Chỉnh sửa',
          color: Colors.black87,
          icon: Icons.edit,
          onTap: () => controller.onEditListItem(itemData.item.id),
        ),
        IconSlideAction(
          caption: 'Xoá',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => controller.onRemoveListItem(itemData.item.id),
        ),
      ],
    );
  }
}
