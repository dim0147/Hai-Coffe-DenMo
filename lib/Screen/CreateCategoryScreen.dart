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
        backgroundColor: Get.theme.primaryColor,
        body: Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Tạo Danh Mục',
                    style: TextStyle(
                      color: Colors.amber[300],
                      fontSize: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: PrimaryInput(
                    title: 'Tên danh mục',
                    iconData: Icons.category,
                    textEditingController: controller.nameC,
                    mainColor: AppConfig.MAIN_COLOR,
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
                      PrimaryBtnIcon(
                        onClick: controller.onCreate,
                        title: 'Tạo',
                        iconData: Icons.add,
                      ),
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
                      PrimaryBtnIcon(
                        onClick: controller.onCreate,
                        title: 'Tạo',
                        iconData: Icons.add,
                      ),
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
