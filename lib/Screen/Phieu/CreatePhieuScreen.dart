import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/Phieu/CreatePhieuController.dart';
import 'package:hai_noob/Model/Phieu.dart';

import '../../App/Config.dart';

import '../Component.dart';

class CreatePhieuScreen extends GetView<CreatePhieuController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Tạo phiếu')),
        drawer: NavigateMenu(),
        body: Container(
          child: Center(
            child: Column(
              children: [
                PriceInput(),
                TextInput(),
                PhieuTypeDropdown(),
                AddBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox PriceInput() {
    return SizedBox(
      width: 150,
      child: TextField(
        controller: controller.amountC,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Giá',
          prefixIcon: Icon(
            Icons.title,
          ),
        ),
      ),
    );
  }

  SizedBox TextInput() {
    return SizedBox(
      width: 350,
      child: TextField(
        controller: controller.textC,
        decoration: InputDecoration(
          labelText: 'Nội dung',
          prefixIcon: Icon(
            Icons.title,
          ),
        ),
      ),
    );
  }

  Row PhieuTypeDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Loại',
          style: TextStyle(color: AppConfig.HEADER_COLOR),
        ),
        Obx(
          () => Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<PhieuType>(
              dropdownColor: AppConfig.MAIN_COLOR,
              items: [
                DropdownMenuItem<PhieuType>(
                  value: PhieuType.PHIEU_CHI,
                  child: Text('Phiếu chi'),
                ),
                DropdownMenuItem<PhieuType>(
                  value: PhieuType.PHIEU_THU,
                  child: Text('Phiếu thu'),
                ),
              ],
              value: controller.phieuType.value,
              onChanged: controller.onChangePhieuType,
            ),
          ),
        ),
      ],
    );
  }

  Center AddBtn() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: controller.onAdd,
        icon: Icon(Icons.add),
        label: Text('Thêm'),
      ),
    );
  }
}
