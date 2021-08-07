import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hai_noob/Controller/CreateItemController.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Model/Item.dart';
import 'package:hai_noob/Screen/Component.dart';

class CreateItemScreen extends GetWidget<CreateItemController> {
  const CreateItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Tạo Item',
                      style: TextStyle(
                          fontSize: 73.0, color: AppConfig.HEADER_COLOR),
                    ),
                  ),
                ),

                // Item name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
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
                                      '${property.name} | ${property.amount}đ'),
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

                // Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tình Trạng:',
                      style: TextStyle(color: AppConfig.HEADER_COLOR),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Obx(
                        () => DropdownButton<Status>(
                          dropdownColor: AppConfig.MAIN_COLOR,
                          items: [
                            DropdownMenuItem<Status>(
                              value: Status.InStock,
                              child: Text('Còn Hàng'),
                            ),
                            DropdownMenuItem<Status>(
                              value: Status.OutStock,
                              child: Text('Hết Hàng'),
                            ),
                          ],
                          value: controller.status.value,
                          onChanged: controller.onChangeStatus,
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
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {},
                      label: Text(
                        'Tạo',
                        style: TextStyle(fontSize: 20),
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
