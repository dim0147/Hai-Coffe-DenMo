import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/AddTableController.dart';

import 'Component.dart';

class AddTableScreen extends GetWidget<AddTableController> {
  const AddTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tạo Bàn'),
        ),
        drawer: NavigateMenu(),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.nameC,
                  decoration: InputDecoration(
                    labelText: 'Tên',
                    prefixIcon: Icon(Icons.title),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: Get.width * 0.5,
                  child: TextField(
                    controller: controller.orderC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Thứ tự',
                      prefixIcon: Icon(Icons.filter_9),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: controller.onAdd,
                  icon: Icon(Icons.add),
                  label: Text('Thêm'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
