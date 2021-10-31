import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Category/EditCategoryController.dart';

import '../../App/Config.dart';

class EditCategoryScreen extends GetView<EditCategoryController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Chỉnh sửa danh mục')),
        body: Container(
          child: Center(
            child: Column(
              children: [
                NameInput(),
                SaveBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NameInput extends GetView<EditCategoryController> {
  const NameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class SaveBtn extends GetView<EditCategoryController> {
  const SaveBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final Widget? cStateWidget =
            Utils.cStateInLoadingOrError(controller.cState.value);
        if (cStateWidget != null) return cStateWidget;

        return Column(
          children: [
            ElevatedButton.icon(
              onPressed: controller.onSave,
              icon: Icon(Icons.save),
              label: Text('Lưu'),
            )
          ],
        );
      },
    );
  }
}
