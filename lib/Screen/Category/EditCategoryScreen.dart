import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/Category/EditCategoryController.dart';

import '../../App/Config.dart';

class EditCategoryScreen extends GetView<EditCategoryController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Chỉnh sủa danh mục')),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Tên danh mục',
                      prefixIcon: Icon(
                        Icons.category,
                      ),
                    ),
                    controller: controller.nameC,
                  ),
                ),

                // Create Button
                controller.obx(
                  (state) => Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: controller.onSave,
                        icon: Icon(Icons.save),
                        label: Text('Lưu'),
                      )
                    ],
                  ),
                  onLoading: CircularProgressIndicator(
                    color: AppConfig.MAIN_COLOR,
                  ),
                  onError: (err) => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          err ?? 'Có lỗi xảy ra',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: controller.onSave,
                        icon: Icon(Icons.save),
                        label: Text('Lưu'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
