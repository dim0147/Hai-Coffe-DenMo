import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Category/ListCategoryController.dart';
import 'package:hai_noob/Controller/Item/ListItemController.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Item.dart';

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

              // Filter item by string and visibility
              final searchString = controller.searchString.value;
              final visibility = controller.visibilityFilter.value;
              final listItemData = itemDatas.where((e) {
                final isIncludeSearchString = searchString == ''
                    ? true
                    : e.item.name
                        .toLowerCase()
                        .contains(searchString.toLowerCase());
                final isInVisibilityFilter =
                    visibility == null ? true : e.item.visibility == visibility;
                return isIncludeSearchString && isInVisibilityFilter;
              }).toList();

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
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            style: controller.visibilityFilter.value == null
                                ? OutlinedButton.styleFrom(
                                    backgroundColor: AppConfig.MAIN_COLOR,
                                  )
                                : null,
                            onPressed: () => controller
                                .onChangeFilterStatus(null), // null mean all
                            child: Text('Tất cả'),
                          ),
                          SizedBox(width: 10.0),
                          OutlinedButton(
                            style: controller.visibilityFilter.value == true
                                ? OutlinedButton.styleFrom(
                                    backgroundColor: AppConfig.MAIN_COLOR,
                                  )
                                : null,
                            onPressed: () =>
                                controller.onChangeFilterStatus(true),
                            child: Text('Hiển thị'),
                          ),
                          SizedBox(width: 10.0),
                          OutlinedButton(
                            style: controller.visibilityFilter.value == false
                                ? OutlinedButton.styleFrom(
                                    backgroundColor: AppConfig.MAIN_COLOR,
                                  )
                                : null,
                            onPressed: () =>
                                controller.onChangeFilterStatus(false),
                            child: Text('Không hiển thị'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listItemData.length,
                      itemBuilder: (c, i) => Column(
                        children: [
                          ListItem(itemData: listItemData[i]),
                          Divider(),
                        ],
                      ),
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
          subtitle: Text(
            itemData.item.visibility ? '' : 'Không hiển thị',
            style: TextStyle(
              color: itemData.item.visibility ? null : Colors.red,
            ),
          ),
          trailing: Text(Utils.formatDouble(itemData.item.price) + 'đ'),
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
