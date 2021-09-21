import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/Table/TablePanelController.dart';

import '../Component.dart';

class TablePanelScreen extends GetWidget<TablePanelController> {
  const TablePanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bàn'),
        ),
        drawer: NavigateMenu(),
        body: Container(
          child: Obx(
            () => Column(
              children: [
                ...controller.tableLocals
                    .map((e) => Text(
                        'ID: ${e.id} | NAME: ${e.name} | STATUS: ${e.status}'))
                    .toList(),
                TextButton(onPressed: controller.onClick, child: Text('Click')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
