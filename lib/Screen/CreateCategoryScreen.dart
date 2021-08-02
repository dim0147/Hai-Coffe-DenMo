import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../App/Config.dart';

import 'Component.dart';

import '../Controller/CreateCategoryController.dart';

class CreateCategoryScreen extends GetWidget<CreateCategoryController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Tạo Danh Mục',
                    style: TextStyle(
                      color: AppConfig.MAIN_COLOR,
                      fontSize: 40,
                    ),
                  ),
                ),
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
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          state ?? '',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: controller.onCreate,
                        icon: Icon(Icons.add),
                        label: Text('Tạo'),
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
                      TextButton.icon(
                        onPressed: controller.onCreate,
                        icon: Icon(Icons.add),
                        label: Text('Tạo'),
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
