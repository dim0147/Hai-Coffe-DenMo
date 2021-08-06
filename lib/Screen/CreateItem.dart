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
                        fontSize: 40,
                      ),
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
                                fontSize: 25, color: Get.theme.primaryColor),
                            children: [
                              WidgetSpan(
                                  child: Icon(Icons.category,
                                      color: Get.theme.primaryColor)),
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
                          return Center(
                            child: Text('Không có danh mục nào'),
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
                              fontSize: 25, color: Get.theme.primaryColor),
                          children: [
                            WidgetSpan(
                                child: Icon(Icons.inventory_2,
                                    color: Get.theme.primaryColor)),
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
                              labelText: 'Thêm đường',
                              prefixIcon: Icon(Icons.library_add),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Giá',
                              prefixIcon: Icon(
                                Icons.local_offer,
                              ),
                            ),
                            controller: MoneyMaskedTextController(
                              decimalSeparator: '.',
                              precision: 3,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Chips
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 8.0,
                        children: [
                          Chip(
                            label: Text('Thêm đường | 15.000'),
                            deleteIcon: Icon(Icons.delete),
                            onDeleted: () => {},
                          ),
                        ],
                      ),
                    ),

                    // Button
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: TextButton.icon(
                          onPressed: () {},
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
                      'Tình trạng',
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: DropdownButton<Status>(
                        dropdownColor: AppConfig.MAIN_COLOR,
                        items: [
                          DropdownMenuItem<Status>(
                            value: Status.InStock,
                            child: new Text('Còn Hàng'),
                          ),
                          DropdownMenuItem<Status>(
                            value: Status.OutStock,
                            child: new Text('Hết Hàng'),
                          ),
                        ],
                        onChanged: (val) {},
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
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: DropdownButton<bool>(
                        dropdownColor: AppConfig.MAIN_COLOR,
                        items: [
                          DropdownMenuItem<bool>(
                            value: true,
                            child: new Text('Có'),
                          ),
                          DropdownMenuItem<bool>(
                            value: false,
                            child: new Text('Không'),
                          ),
                        ],
                        onChanged: (val) {},
                      ),
                    ),
                  ],
                ),

                // Image
                Column(
                  children: [
                    Center(
                      child: TextButton.icon(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          // Pick an image
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                        },
                        icon: Icon(Icons.collections),
                        label: Text("Thêm Hình ảnh"),
                      ),
                    ),
                    Center(
                      child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/1200px-A_small_cup_of_coffee.JPG',
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                  ],
                ),

                // Create button
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
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
