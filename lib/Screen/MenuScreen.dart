import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

import 'package:hai_noob/App/Config.dart';

import 'package:hai_noob/Controller/MenuController.dart';
import 'package:hai_noob/Screen/Component.dart';

class MenuScreen extends GetWidget<MenuController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        drawer: NavigateMenu(),
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
                      CategoryBtns(),
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

class CategoryBtns extends GetView<MenuController> {
  const CategoryBtns({
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
                              backgroundColor:
                                  Get.theme.primaryColor.withOpacity(0.5),
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
                      backgroundColor: Get.theme.primaryColor.withOpacity(0.5),
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

  ImageProvider<Object> getImg() {
    if (controller.imgPath.value == null || itemDataDisplay.item.image == '')
      return AssetImage('assets/img/background.png');

    return FileImage(File(
        '${p.join(controller.imgPath.value as String, itemDataDisplay.item.image)}'));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.increaseItem(itemDataDisplay),
      child: Container(
        width: Get.width * (context.isPhone ? 0.3 : 0.2),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
          border: itemDataDisplay.quality > 0
              ? Border.all(color: Get.theme.primaryColor, width: 2.0)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/background.png'),
                    image: getImg(),
                    height: Get.height * 0.1,
                  ),
                ),
                if (itemDataDisplay.quality > 0)
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: AppConfig.BACKGROUND_COLOR.withOpacity(0.8)),
                    child: Text(
                      itemDataDisplay.quality.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                // Quality if have
              ],
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

            if (itemDataDisplay.quality > 0)
              Column(
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
              ),
          ],
        ),
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
    return Container(
      padding: EdgeInsets.all(10),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.orangeAccent[200],
      ),
      child: Obx(() => Row(
            children: [
              // Cart quality badge
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  if (controller.cart.value.totalQuantities > 0)
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
                          controller.cart.value.totalQuantities.toString(),
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

              // Select table
              Expanded(
                flex: 3,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.table_chart),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        width: 2.0,
                        color: Get.theme.primaryColor.withOpacity(0.5)),
                  ),
                  label: Text('Chọn Bàn'),
                ),
              ),

              SizedBox(width: 5),

              // Payment
              Expanded(
                flex: 3,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.payment),
                  label: Text('Payment'),
                ),
              )
            ],
          )),
    );
  }
}
