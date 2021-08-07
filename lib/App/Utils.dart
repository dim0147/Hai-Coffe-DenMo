import 'dart:math';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class Utils {
  static double? convertStringToDouble(String str) {
    return double.tryParse(str.replaceAll('.', '').replaceAll(',', '.'));
  }

  static String generateRandomId({int len = 5}) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  static Future<File?> saveImg(File image) async {
    // Get storage directory
    var pathStorage = await getExternalStorageDirectory();
    if (pathStorage == null) {
      Get.snackbar('Lỗi', 'Không thể lấy thư mục storage');
      return null;
    }

    // Get file extension
    String fileExtension = p.extension(image.path);
    if (fileExtension == '') {
      Get.snackbar('Lỗi', 'Không thể lấy type ảnh');
      return null;
    }

    // Generate filename
    String filename = Utils.generateRandomId() + fileExtension;

    // Copy image to storage
    String newPathToSave = p.join(pathStorage.path, filename);
    try {
      return image.copy(newPathToSave);
    } catch (err) {
      Get.snackbar('Lỗi', 'Không thể lưu ảnh: \n ${err.toString()}');
      return null;
    }
  }
}
