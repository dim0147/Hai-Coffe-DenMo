import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Menu/MenuController.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Screen/Component.dart';

class MenuScreen extends GetView<MenuController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuScreenArgs menuScreenArgument = controller.args;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        // If don't have table ID argument we draw menu
        drawer: menuScreenArgument.tableID == null ? NavigateMenu() : null,
        bottomNavigationBar: Footer(),
        body: Container(
          child: MainMenu(),
        ),
      ),
    );
  }
}

class MainMenu extends GetView<MenuController> {
  const MainMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final Widget? cStateWidget =
            Utils.cStateInLoadingOrError(controller.cState.value);
        if (cStateWidget != null) return cStateWidget;

        return SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeftPanel(),
              RightPanel(),
            ],
          ),
        );
      },
    );
  }
}

class LeftPanel extends GetView<MenuController> {
  const LeftPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [CategoryList(), AllCategoryBtn()],
        ),
      ),
    );
  }

  Column CategoryList() {
    return Column(
      children: controller.categories
          .map((e) => OutlinedButton(
                onPressed: () => controller.changeCategory(e.id),
                child: Text(e.name),
                style: controller.choosenCategoryId.value == e.id
                    ? OutlinedButton.styleFrom(
                        backgroundColor: AppConfig.MAIN_COLOR,
                      )
                    : null,
              ))
          .toList(),
    );
  }

  OutlinedButton AllCategoryBtn() {
    return OutlinedButton(
      onPressed: () => controller.changeCategory(null),
      child: Text('Tất cả'),
      style: controller.choosenCategoryId.value == null
          ? OutlinedButton.styleFrom(
              backgroundColor: AppConfig.MAIN_COLOR,
              // backgroundColor: AppConfig.MAIN_COLOR.withOpacity(0.5),
            )
          : null,
    );
  }
}

class RightPanel extends GetView<MenuController> {
  RightPanel({
    Key? key,
  }) : super(key: key);

  bool itemDataDisplayListFilter(ItemDataDisplay e) {
    // Search string condition
    final int? categoryFilterId = controller.choosenCategoryId.value;
    final String searchString = controller.searchString.value;

    final bool isIncludeSearchString = searchString == ''
        ? true
        : e.item.name.toLowerCase().contains(searchString.toLowerCase());
    bool isIncludeCategory = true;

    // All categories (equal null)
    if (categoryFilterId == null)
      return isIncludeSearchString && isIncludeCategory;

    // categoryFilterId not null but this item dont have category
    final List<Category>? listCategory = e.categories;
    if (listCategory == null) return false;

    // Check categoryList if include categoryFilterId
    isIncludeCategory = listCategory.any(
      (category) => category.id == categoryFilterId,
    );
    return isIncludeSearchString && isIncludeCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
            children: [
              SeachInput(),
              ItemDataDisplayList(),
            ],
          ),
        ),
      ),
    );
  }

  Padding SeachInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Nhập từ khoá tìm kiếm',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: controller.onChangeSearchString,
      ),
    );
  }

  Container ItemDataDisplayList() {
    final List<ItemDataDisplay> itemDataDisplayList =
        controller.itemsDataDisplay.value;
    return Container(
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: itemDataDisplayList
            .where(itemDataDisplayListFilter)
            .map((e) => ItemDataDisplayWidget(itemDataDisplay: e))
            .toList(),
      ),
    );
  }
}

class ItemDataDisplayWidget extends GetView<MenuController> {
  ItemDataDisplayWidget({Key? key, required this.itemDataDisplay})
      : super(key: key);
  final ItemDataDisplay itemDataDisplay;

  @override
  Widget build(BuildContext context) {
    final int itemQuantity =
        controller.showItemQuantity(itemDataDisplay.item.id);
    final bool itemHaveQuantity = itemQuantity > 0;

    return InkWell(
      onTap: () => controller.increaseItem(itemDataDisplay),
      child: Stack(
        children: [
          Container(
            width: Get.width * (context.isPhone ? 0.3 : 0.2),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppConfig.ITEM_IN_MENU_CONTAINER_BACKGROUND,
              // Quantity border
              border: itemHaveQuantity
                  ? Border.all(color: AppConfig.MAIN_COLOR, width: 2.0)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ItemImg(),
                ItemName(),
                ItemPrice(),
                ItemDecreaseQuantityBtn(itemHaveQuantity),
              ],
            ),
          ),
          ItemQuantityBadget(itemHaveQuantity, itemQuantity),
        ],
      ),
    );
  }

  ClipRRect ItemImg() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: FadeInImage(
        placeholder: AssetImage(AppConfig.DEFAULT_IMG_ITEM),
        image: Utils.getImgProvider(itemDataDisplay.item.image),
        height: Get.height * 0.1,
      ),
    );
  }

  Padding ItemName() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(itemDataDisplay.item.name),
    );
  }

  Padding ItemPrice() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        Utils.formatDouble(itemDataDisplay.item.price) + 'đ',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget ItemDecreaseQuantityBtn(bool itemHaveQuantity) {
    if (!itemHaveQuantity) return SizedBox();
    return Column(
      children: [
        // Decrease quality
        ElevatedButton.icon(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(5))),
          onPressed: () => controller.decreaseItem(itemDataDisplay),
          label: Text('Giảm'),
          icon: Icon(
            Icons.remove,
          ),
        )
      ],
    );
  }

  Widget ItemQuantityBadget(bool itemHaveQuantity, int itemQuantity) {
    if (!itemHaveQuantity) return SizedBox();
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: AppConfig.MAIN_COLOR),
      child: Text(
        itemQuantity.toString(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Footer extends GetView<MenuController> {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(10),
        height: 90,
        decoration: BoxDecoration(
          color: AppConfig.FOOTER_MENU_CONTAINER_COLOR,
        ),
        child: Column(
          children: [
            Header(),
            Row(
              children: [
                // Cart quality badge
                CartBadge(),

                // Select table
                if (controller.tableIDLocal.value == null) SelectTableBtn(),
                SizedBox(width: 5),
                // Payment
                PaymentBtn()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding Header() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          if (controller.tableIDLocal.value != null)
            Text('Bàn: ${controller.tableName}'),
          Spacer(),
          if (controller.cart.value.showTotalQuantity() > 0) SubTotal(),
        ],
      ),
    );
  }

  Row SubTotal() {
    return Row(
      children: [
        Text(
          'Tổng cộng: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          Utils.formatDouble(controller.cart.value.showTotalPrice()) + 'đ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Stack CartBadge() {
    return Stack(
      children: [
        IconButton(
          onPressed: controller.onClickShowCart,
          icon: Icon(
            Icons.shopping_cart,
            color: AppConfig.FOOTER_CART_MENU_COLOR,
          ),
        ),
        if (controller.cart.value.showTotalQuantity() > 0)
          Positioned(
            child: new Container(
              padding: EdgeInsets.all(2),
              decoration: new BoxDecoration(
                color: AppConfig.FOOTER_CART_BACKGROUND_TEXT_MENU_COLOR,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                controller.cart.value.showTotalQuantity().toString(),
                style: TextStyle(
                  color: AppConfig.FOOTER_CART_TEXT_MENU_COLOR,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
      ],
    );
  }

  Expanded SelectTableBtn() {
    return Expanded(
      flex: 3,
      child: OutlinedButton.icon(
        onPressed: controller.onClickSelectTable,
        icon: Icon(Icons.table_chart),
        label: Text('Chọn Bàn'),
      ),
    );
  }

  Expanded PaymentBtn() {
    return Expanded(
      flex: 3,
      child: ElevatedButton.icon(
        onPressed: controller.cart.value.showTotalQuantity() > 0
            ? controller.onClickPayment
            : null,
        icon: Icon(Icons.payment),
        label: Text('Thanh Toán'),
      ),
    );
  }
}
