import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/Table/EditTableController.dart';

class EditTableScreen extends GetView<EditTableController> {
  const EditTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chỉnh sửa bàn'),
        ),
        body: Container(
          child: Column(
            children: [NameInput(), OrderInput(), SaveBtn()],
          ),
        ),
      ),
    );
  }

  Padding NameInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller.nameC,
        decoration: InputDecoration(
          labelText: 'Tên',
          prefixIcon: Icon(Icons.title),
        ),
      ),
    );
  }

  Center OrderInput() {
    return Center(
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
    );
  }

  Padding SaveBtn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: controller.onSave,
        icon: Icon(Icons.add),
        label: Text('Lưu'),
      ),
    );
  }
}
