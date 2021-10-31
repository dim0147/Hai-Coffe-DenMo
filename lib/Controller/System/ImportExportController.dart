import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/DAO/ImportExportDAO.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/ConfigGlobal.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ImportExportController extends GetxController {
  final AppDatabase appDB = Get.find<AppDatabase>();
  final ConfigGlobal configGlobal = Get.find<ConfigGlobal>();
  final TableLocalDAO tableLocalDAO = Get.find<TableLocalDAO>();
  late final ImportExportDAO ieDAO;

  final Rx<CBaseState> cStateMain = CBaseState(CState.LOADING).obs;
  final Rx<CBaseState> cStateImport = CBaseState(CState.DONE).obs;
  final Rx<CBaseState> cStateExport = CBaseState(CState.DONE).obs;
  final Rxn<ExportInfo> exportInfo = Rxn<ExportInfo>();

  @override
  void onInit() async {
    super.onInit();
    ieDAO = ImportExportDAO(appDB);

    final CBaseState cStateMain = this.cStateMain.value;
    final CBaseState cStateImport = this.cStateImport.value;
    final CBaseState cStateExport = this.cStateExport.value;
    cStateMain.setGetC(this.cStateMain);
    cStateImport.setGetC(this.cStateImport);
    cStateExport.setGetC(this.cStateExport);

    try {
      exportInfo.value = await ieDAO.getExportInfo();
      cStateMain.changeState(CState.DONE);
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
      cStateMain.changeState(CState.ERROR, err.toString());
    }
  }

  void onExport() async {
    final String? backupDirString = configGlobal.backupPath;
    if (backupDirString == null)
      return Utils.showSnackBar('Lỗi', 'Không tìm thấy backup folder');

    // Directory use for Zipping
    final Directory? dirToBackUp = await getExternalStorageDirectory();
    if (dirToBackUp == null)
      return Utils.showSnackBar('Lỗi', 'Folder dùng để zipping  = null');

    // Backup Zip file
    final String zipFileName =
        '${Utils.dateExtension.dateToDateWithTime(DateTime.now())}.zip';
    final File zipFile = File(p.join(backupDirString, zipFileName));

    try {
      await ZipFile.createFromDirectory(
        sourceDir: dirToBackUp,
        zipFile: zipFile,
        onZipping: onZipping,
      );
      cStateExport.value.changeState(
          CState.DONE, 'Tạo backup thành công, nơi lưu: \'${zipFile.path}\'');
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }

  ZipFileOperation onZipping(
    String filePath,
    bool isDirectory,
    double progress,
  ) {
    cStateExport.value.changeState(
        CState.LOADING, 'Tiến tình: ${filePath} (${progress.toInt()}%)');

    // Skip DB
    if (isDirectory && filePath.contains(AppConfig.BACKUP_FOLDER_NAME))
      return ZipFileOperation.skipItem;

    return ZipFileOperation.includeItem;
  }

  void onImport() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip'],
      );
      if (result == null || result.files.length == 0) return;

      final PlatformFile file = result.files[0];
      final String? zipPath = file.path;
      if (zipPath == null)
        return Utils.showSnackBar('Lỗi', 'Không thể lấy zip path import file');

      await clearDataBeforeImport();

      await extractZipFile(zipPath);
      cStateImport.value.changeState(CState.DONE,
          '- Import thành công, app sẽ tự tắt trong vòng 5 giây, vui lòng mở lại app!');
      closeAppAfter(Duration(seconds: 5));
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
      cStateImport.value.changeState(CState.ERROR, err.toString());
    }
  }

  Future<void> clearDataBeforeImport() async {
    await tableLocalDAO.removeAll();
    await appDB.close();
  }

  Future<void> extractZipFile(String zipPath) async {
    final Directory? externalStorage = await getExternalStorageDirectory();
    if (externalStorage == null)
      return Future.error('External storate is null');

    final File zipFile = File(zipPath);

    return ZipFile.extractToDirectory(
      zipFile: zipFile,
      destinationDir: externalStorage,
      onExtracting: onExtracting,
    );
  }

  ZipFileOperation onExtracting(ZipEntry zipEntry, double progress) {
    final bool isDirectory = zipEntry.isDirectory;
    final String name = zipEntry.name;

    // Skip backup folder
    if (isDirectory && name.contains(AppConfig.BACKUP_FOLDER_NAME))
      return ZipFileOperation.skipItem;

    cStateImport.value.changeState(
      CState.LOADING,
      'Tiến trình: $name (${progress.toInt()}%)',
    );
    return ZipFileOperation.includeItem;
  }

  Future<void> closeAppAfter(Duration duration) async {
    await Future.delayed(duration);
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
