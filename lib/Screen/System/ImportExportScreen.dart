import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/System/ImportExportController.dart';
import 'package:hai_noob/Controller/Table/AddTableController.dart';

import '../Component.dart';

class ImportExportScreen extends GetView<ImportExportController> {
  const ImportExportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class ImportTab extends StatelessWidget {
  const ImportTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.add),
          label: Text('Chọn File ZIP '),
        ),
      ),
    );
  }
}

class ExportTab extends StatelessWidget {
  const ExportTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.add),
          label: Text('Export File ZIP '),
        ),
      ),
    );
  }
}
