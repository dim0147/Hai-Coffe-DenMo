import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/Menu/SelectTableDialogController.dart';

class SelectTableDialogScreen extends GetView<SelectTableDialogController> {
  const SelectTableDialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dialog so not using route name
    final SelectTableDialogController controller = Get.put(
      SelectTableDialogController(),
    );

    return Obx(
      () => Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Những bàn đang trống:'),
            // Dropdown
            DropdownButton<int>(
              dropdownColor: AppConfig.MAIN_COLOR,
              items: controller.listTable
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text('${e.name}'),
                      ))
                  .toList(),
              value: controller.tableIDSelected.value,
              onChanged: controller.onSelectTableID,
            ),

            // Select
            OutlinedButton(
              onPressed: controller.onBtnConfirm,
              child: Text('Chọn'),
              style: OutlinedButton.styleFrom(
                backgroundColor: AppConfig.MAIN_COLOR,
              ),
            )
          ],
        ),
      ),
    );
  }
}
