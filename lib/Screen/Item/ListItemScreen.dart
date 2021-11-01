import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Item/ListItemController.dart';
import 'package:hai_noob/DAO/ItemDAO.dart';

import '../Component.dart';

class ListItemScreen extends GetView<ListItemController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Tất cả Item')),
        drawer: NavigateMenu(),
        body: Container(
          child: Column(
            children: [
              SearchInput(),
              VisibleFilterSection(),
              ItemListSection(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.onFloatingBtn,
          child: const Icon(Icons.add),
          backgroundColor: AppConfig.MAIN_COLOR,
        ),
      ),
    );
  }
}

class SearchInput extends GetView<ListItemController> {
  const SearchInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class VisibleFilterSection extends GetView<ListItemController> {
  const VisibleFilterSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonVisibleFilter(
            displayString: 'Tất cả',
            valueToFilter: null,
          ),
          SizedBox(width: 10.0),
          ButtonVisibleFilter(
            displayString: 'Hiển thị',
            valueToFilter: true,
          ),
          SizedBox(width: 10.0),
          ButtonVisibleFilter(
            displayString: 'Không hiển thị',
            valueToFilter: false,
          ),
        ],
      ),
    );
  }
}

class ButtonVisibleFilter extends GetView<ListItemController> {
  const ButtonVisibleFilter({
    Key? key,
    required this.displayString,
    this.valueToFilter,
  }) : super(key: key);

  final String displayString;
  final bool? valueToFilter;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => OutlinedButton(
        style: controller.visibilityFilter.value == valueToFilter
            ? OutlinedButton.styleFrom(
                backgroundColor: AppConfig.MAIN_COLOR,
              )
            : null,
        onPressed: () => controller.onChangeFilterStatus(valueToFilter),
        child: Text(displayString),
      ),
    );
  }
}

class ItemListSection extends GetView<ListItemController> {
  const ItemListSection({
    Key? key,
  }) : super(key: key);

  bool filterItem(ItemDataClass e, String searchString, bool? visibility) {
    final String itemName = e.item.name;
    final bool itemVisibility = e.item.visibility;

    bool isIncludeSearchString = true;
    if (searchString != '')
      isIncludeSearchString =
          itemName.toLowerCase().contains(searchString.toLowerCase());

    bool isInVisibilityFilter = true;
    if (visibility != null) isInVisibilityFilter = itemVisibility == visibility;

    return isIncludeSearchString && isInVisibilityFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final itemDatas = controller.itemDatas;

      // Filter item by string and visibility
      final searchString = controller.searchString.value;
      final visibility = controller.visibilityFilter.value;

      final listItemData = itemDatas
          .where((e) => filterItem(e, searchString, visibility))
          .toList();

      return Expanded(
        child: ListView.builder(
          itemCount: listItemData.length,
          itemBuilder: (c, i) => Column(
            children: [
              ItemWidget(itemData: listItemData[i]),
              Divider(),
            ],
          ),
        ),
      );
    });
  }
}

class ItemWidget extends GetView<ListItemController> {
  final ItemDataClass itemData;

  const ItemWidget({
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
            image: Utils.getImgProvider(itemData.item.image),
          ),
          title: Text(itemData.item.name),
          subtitle: Text(
            itemData.item.visibility ? '' : 'Không hiển thị',
            style: TextStyle(
              color: itemData.item.visibility ? null : Colors.red,
            ),
          ),
          trailing: Text(Utils.formatDouble(itemData.item.price) + 'đ'),
          onTap: () => controller.onEditListItem(itemData.item.id),
        ),
      ),
      secondaryActions: <Widget>[
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
