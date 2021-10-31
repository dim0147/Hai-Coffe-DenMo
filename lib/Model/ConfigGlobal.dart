import 'dart:io';

import 'package:hai_noob/App/Config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ConfigGlobal {
  late final String? imgPath;
  late final String? dbPath;
  late final String? backupPath;

  Future<void> init() async {
    imgPath = await createFolderInExternalStorage(AppConfig.IMG_FOLDER_NAME);
    dbPath = await createFolderInExternalStorage(AppConfig.DB_FOLDER_NAME);
    backupPath =
        await createFolderInExternalStorage(AppConfig.BACKUP_FOLDER_NAME);
  }

  Future<String?> createFolderInExternalStorage(String folderName) async {
    try {
      // Get storage dir
      final Directory? externalStorage = await getExternalStorageDirectory();
      if (externalStorage == null) return null;

      // Get new folder dir
      final String folderPathName = p.join(externalStorage.path, folderName);
      final Directory folderPath = Directory(folderPathName);

      // Check is exist
      final bool isExist = await folderPath.exists();
      if (isExist) return folderPath.path;

      await folderPath.create();
      return folderPath.path;
    } catch (err) {
      return null;
    }
  }
}
