import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/Controller/System/ImportExportController.dart';
import 'package:hai_noob/DAO/ImportExportDAO.dart';

import '../Component.dart';

class ImportExportScreen extends GetView<ImportExportController> {
  const ImportExportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ad = controller;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: NavigateMenu(),
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Import', icon: Icon(Icons.file_download)),
                Tab(text: 'Export', icon: Icon(Icons.file_upload)),
              ],
            ),
            title: const Text('Import/Export'),
          ),
          body: TabBarView(
            children: [
              ImportTab(),
              ExportTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class ImportTab extends GetView<ImportExportController> {
  const ImportTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Obx(() {
          final Widget? cStateWidget =
              Utils.cStateInLoadingOrError(controller.cStateMain.value);
          if (cStateWidget != null) return cStateWidget;

          final ExportInfo? exportInfo = controller.exportInfo.value;
          if (exportInfo == null) return Text('Không có thông tin export');

          return Column(
            children: [
              CurrentDataWidget(exportInfo: exportInfo),
              Text('* Lưu ý: Import sẽ xoá hoàn toàn dữ liệu hiện tại'),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text('Chọn ZIP File Import'),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class ExportTab extends GetView<ImportExportController> {
  const ExportTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Obx(() {
          final Widget? cStateWidget =
              Utils.cStateInLoadingOrError(controller.cStateMain.value);
          if (cStateWidget != null) return cStateWidget;

          final ExportInfo? exportInfo = controller.exportInfo.value;
          if (exportInfo == null) return Text('Không có thông tin export');

          final CBaseState cStateExport = controller.cStateExport.value;
          final String? exportText = cStateExport.message;

          print(exportText);

          return Column(
            children: [
              CurrentDataWidget(exportInfo: exportInfo),
              Text('* Export tất cả dữ liệu hiện tại thành file ZIP'),
              if (exportText != null && exportText.length > 0) Text(exportText),
              ElevatedButton.icon(
                onPressed: controller.onExport,
                icon: Icon(Icons.upload),
                label: Text('Export Thành ZIP File'),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class CurrentDataWidget extends StatelessWidget {
  const CurrentDataWidget({
    Key? key,
    required this.exportInfo,
  }) : super(key: key);

  final ExportInfo exportInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Dữ liệu hiện tại:',
            style: TextStyle(fontSize: 20.0),
          ),
          Text('- Danh mục: ${exportInfo.tableCount.categies} bảng ghi'),
          Text('- Items: ${exportInfo.tableCount.items} bảng ghi'),
          Text('- Bàn: ${exportInfo.tableCount.TableOrders} bảng ghi'),
          Text('- Hoá đơn: ${exportInfo.tableCount.Bills} bảng ghi'),
          Text('- Phiếu: ${exportInfo.tableCount.Phieus} bảng ghi'),
          Text(
            '- Dung lượng data (không bao gồm hình ảnh): ${exportInfo.dbFolder.sizeToString()}',
          ),
          Text(
            '- Hình ảnh: ${exportInfo.imgFolder.totalFiles} hình ảnh (Dung lượng: ${exportInfo.imgFolder.sizeToString()})',
          ),
        ],
      ),
    );
  }
}
