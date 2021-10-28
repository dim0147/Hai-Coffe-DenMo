import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';

import '../../App/Config.dart';

import '../Component.dart';

import '../../Controller/Category/CreateCategoryController.dart';

class CreateCategoryScreen extends GetView<CreateCategoryController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Tạo danh mục')),
        drawer: NavigateMenu(),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Title(),

                // Create Button
                CreateBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Title extends GetView<CreateCategoryController> {
  const Title({
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

class CreateBtn extends GetView<CreateCategoryController> {
  const CreateBtn({Key? key}) : super(key: key);

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
              onPressed: controller.onCreate,
              icon: Icon(Icons.add),
              label: Text('Tạo'),
            )
          ],
        );
      },
    );
  }
}
