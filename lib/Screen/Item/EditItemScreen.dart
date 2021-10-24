import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Item/CreateItemController.dart';
import 'package:hai_noob/Controller/Item/EditItemController.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Model/Item.dart';
import 'package:hai_noob/Screen/Component.dart';

class EditItemScreen extends GetView<EditItemController> {
  const EditItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chỉnh sửa Item'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller.titleC,
                    decoration: InputDecoration(
                      labelText: 'Tên',
                      prefixIcon: Icon(
                        Icons.title,
                      ),
                    ),
                  ),
                ),

                // Item price
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: Get.width * 0.5,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Giá tiền',
                          prefixIcon: Icon(
                            Icons.local_offer,
                          ),
                        ),
                        controller: controller.priceC,
                      ),
                    ),
                  ),
                ),

                // Category
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Title
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 30, color: AppConfig.HEADER_COLOR),
                            children: [
                              WidgetSpan(
                                  child: Icon(Icons.category,
                                      color: AppConfig.HEADER_COLOR)),
                              TextSpan(text: ' Danh Mục'),
                            ],
                          ),
                        ),
                      ),

                      // Category Checkboxes
                      Obx(() {
                        // Loading
                        if (controller.isLoadingCategory.value)
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          );

                        // DON'T HAVE ANY category
                        if (controller.categories.length == 0)
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Không có danh mục nào'),
                            ),
                          );

                        return Wrap(
                          children: controller.categories
                              .map(
                                (category) => CheckboxPrimary(
                                  title: category.name,
                                  value: category.checked,
                                  onChanged: (checked) => {
                                    controller.onChangeCategoryCheckbox(
                                        checked, category.id)
                                  },
                                ),
                              )
                              .toList(),
                        );
                      })
                    ],
                  ),
                ),

                // Property
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 25, color: AppConfig.HEADER_COLOR),
                          children: [
                            WidgetSpan(
                                child: Icon(Icons.inventory_2,
                                    color: AppConfig.HEADER_COLOR)),
                            TextSpan(text: ' Thuộc tính'),
                          ],
                        ),
                      ),
                    ),
                    // Field input
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Thêm đường',
                              labelText: 'Tên',
                              prefixIcon: Icon(Icons.library_add),
                            ),
                            controller: controller.propertyNameC,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Giá',
                              prefixIcon: Icon(
                                Icons.local_offer,
                              ),
                            ),
                            controller: controller.propertyAmountC,
                          ),
                        ),
                      ],
                    ),

                    // Chips
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 8.0,
                          children: controller.properties
                              .map(
                                (property) => Chip(
                                  label: Text(
                                      '${property.name} | ${Utils.formatDouble(property.amount)}đ'),
                                  deleteIcon: Icon(Icons.close),
                                  onDeleted: () =>
                                      controller.removeProperty(property),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),

                    // Button
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton.icon(
                          onPressed: controller.addProperty,
                          label: Text('Thêm thuộc tính'),
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),

                // Visibility
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hiển Thị',
                      style: TextStyle(color: AppConfig.HEADER_COLOR),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Obx(
                        () => DropdownButton<bool>(
                          dropdownColor: AppConfig.MAIN_COLOR,
                          items: [
                            DropdownMenuItem<bool>(
                              value: true,
                              child: Text('Có'),
                            ),
                            DropdownMenuItem<bool>(
                              value: false,
                              child: Text('Không'),
                            ),
                          ],
                          value: controller.visibility.value,
                          onChanged: controller.onChangeVisibility,
                        ),
                      ),
                    ),
                  ],
                ),

                // Image
                Column(
                  children: [
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: controller.onAddImg,
                        icon: Icon(Icons.collections),
                        label: Text("Thêm Hình ảnh"),
                      ),
                    ),
                    Obx(
                      () => controller.img.value != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Image.file(
                                      controller.img.value as File,
                                      width: 100.0,
                                      height: 100.0,
                                    ),
                                    TextButton.icon(
                                        onPressed: controller.onRemoveImg,
                                        icon: Icon(Icons.close),
                                        label: Text('Huỷ ảnh'))
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Không có ảnh nào'),
                              ),
                            ),
                    ),
                  ],
                ),

                // Create button
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(11.0, 0.0, 11.0, 11.0),
                    child: Obx(
                      () => controller.isSaveItem.value
                          ? ElevatedButton(
                              onPressed: null,
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton.icon(
                              icon: Icon(Icons.save),
                              onPressed: controller.onSaveItem,
                              label: Text(
                                'Lưu',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
