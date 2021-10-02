import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:path/path.dart' as p;

import 'package:hai_noob/App/Config.dart';

import 'package:hai_noob/Controller/Menu/MenuController.dart';
import 'package:hai_noob/Screen/Component.dart';

class MenuScreen extends GetView<MenuController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        drawer: controller.tableId != null ? null : NavigateMenu(),
        bottomNavigationBar: Footer(),
        body: Container(
          child: Obx(() => controller.isLoading.value
              ? SizedBox.expand(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 10.0),
                      Text('Đang tải dữ liệu')
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LeftPanel(),
                      RightPanel(),
                    ],
                  ),
                )),
        ),
      ),
    );
  }
}

class RightPanel extends GetView<MenuController> {
  RightPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: controller.itemsDataDisplay
                .where((e) {
                  // Mean all categories
                  if (controller.choosenCategoryId.value == null) return true;

                  if (e.categories == null) return false;

                  return e.categories?.any(
                          (e) => e.id == controller.choosenCategoryId.value)
                      as bool;
                })
                .map((e) => MenuItem(itemDataDisplay: e))
                .toList(),
          ),
        ),
      ),
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
          children: [
            ...controller.categories
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
            // All category
            OutlinedButton(
              onPressed: () => controller.changeCategory(null),
              child: Text('Tất cả'),
              style: controller.choosenCategoryId.value == null
                  ? OutlinedButton.styleFrom(
                      backgroundColor: AppConfig.MAIN_COLOR.withOpacity(0.5),
                    )
                  : null,
            )
          ],
        ),
      ),
    );
  }
}

class MenuItem extends GetView<MenuController> {
  MenuItem({Key? key, required this.itemDataDisplay}) : super(key: key);
  final ItemDataDisplay itemDataDisplay;

  @override
  Widget build(BuildContext context) {
    int itemQuantity = controller.showItemQuantity(itemDataDisplay.item.id);

    return InkWell(
      onTap: () => controller.increaseItem(itemDataDisplay),
      child: Stack(
        children: [
          Container(
            width: Get.width * (context.isPhone ? 0.3 : 0.2),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
              // Quantity badge
              border: itemQuantity > 0
                  ? Border.all(color: AppConfig.MAIN_COLOR, width: 2.0)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Img
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                    placeholder: AssetImage(AppConfig.DEFAULT_IMG_ITEM),
                    image: Utils.getImg(itemDataDisplay.item.image),
                    height: Get.height * 0.1,
                  ),
                ),

                // Name
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(itemDataDisplay.item.name),
                ),

                // Price
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(itemDataDisplay.item.price.toString() + 'đ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),

                if (itemQuantity > 0)
                  Column(
                    children: [
                      // Decrease quality
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(5))),
                        onPressed: () =>
                            controller.decreaseItem(itemDataDisplay),
                        label: Text('Giảm'),
                        icon: Icon(
                          Icons.remove,
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
          if (itemQuantity > 0)
            // Quantiy
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: AppConfig.BACKGROUND_COLOR.withOpacity(0.8)),
              child: Text(
                itemQuantity.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
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
    return Obx(() => Container(
          padding: EdgeInsets.all(10),
          height: controller.cart.value.showTotalQuantity() > 0 ? 90 : 70,
          decoration: BoxDecoration(
            color: Colors.orangeAccent[200],
          ),
          child: Column(
            children: [
              if (controller.cart.value.showTotalQuantity() > 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Tổng cộng: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[100],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            controller.cart.value.showTotalPrice().toString() +
                                'đ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[100],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              Row(
                children: [
                  // Cart quality badge
                  Stack(
                    children: [
                      IconButton(
                        onPressed: controller.onClickShowCart,
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      if (controller.cart.value.showTotalQuantity() > 0)
                        Positioned(
                          child: new Container(
                            padding: EdgeInsets.all(2),
                            decoration: new BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 18,
                              minHeight: 18,
                            ),
                            child: Text(
                              controller.cart.value
                                  .showTotalQuantity()
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                    ],
                  ),

                  if (controller.tableId == null)
                    // Select table
                    Expanded(
                      flex: 3,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.table_chart),
                        label: Text('Chọn Bàn'),
                      ),
                    ),

                  SizedBox(width: 5),

                  // Payment
                  Expanded(
                    flex: 3,
                    child: ElevatedButton.icon(
                      onPressed: controller.onClickPayment,
                      icon: Icon(Icons.payment),
                      label: Text('Thanh Toán'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
