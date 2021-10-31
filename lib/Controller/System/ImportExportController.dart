import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/DAO/ImportExportDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/ConfigGlobal.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ImportExportController extends GetxController {
  final AppDatabase appDB = Get.find<AppDatabase>();
  final ConfigGlobal configGlobal = Get.find<ConfigGlobal>();
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
}
