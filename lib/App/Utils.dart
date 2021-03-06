import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/Model/ConfigGlobal.dart';
import 'package:hai_noob/Model/Revenue.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sentry_flutter/sentry_flutter.dart';

class Utils {
  static DateExtension dateExtension = DateExtension();
  static RandomExtension randomExtension = RandomExtension();
  static FileExtension fileExtension = FileExtension();

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
    // Get image directory
    final ConfigGlobal config = Get.find<ConfigGlobal>();
    final String? imgPath = config.imgPath;
    if (imgPath == null) return null;

    // Get file extension
    String fileExtension = p.extension(image.path);
    if (fileExtension == '') {
      Utils.showSnackBar('Lỗi', 'Không thể lấy type ảnh');
      return null;
    }

    // Generate filename
    String filename = Utils.generateRandomId() + fileExtension;

    // Copy image to storage
    String newPathToSave = p.join(imgPath, filename);
    try {
      return image.copy(newPathToSave);
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', 'Không thể lưu ảnh: \n ${err.toString()}');
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Get img provider for widget
  static ImageProvider<Object> getImgProvider(String imgName) {
    try {
      final ConfigGlobal config = Get.find<ConfigGlobal>();
      final String? imgPath = config.imgPath;
      // Check img path or img name don't have value
      if (imgPath == null || imgName == '')
        return AssetImage(AppConfig.DEFAULT_IMG_ITEM);

      // Check image is exist
      final String imgFullPath = p.join(imgPath, imgName);
      if (!fileIsExist(imgFullPath))
        return AssetImage(AppConfig.DEFAULT_IMG_ITEM);

      return FileImage(File(imgFullPath));
    } catch (err, stackTrace) {
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
      return AssetImage(AppConfig.DEFAULT_IMG_ITEM);
    }
  }

  /// Get img file
  static File? getImgFile(String fileName) {
    try {
      final ConfigGlobal config = Get.find<ConfigGlobal>();
      final String? imgPath = config.imgPath;
      // Check img path or img name don't have value
      if (imgPath == null || fileName == '') return null;

      // Check image is exist
      final String imgFullPath = p.join(imgPath, fileName);
      if (!fileIsExist(imgFullPath)) return null;

      return File(imgFullPath);
    } catch (err, stackTrace) {
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  static bool fileIsExist(String filePath) {
    final File file = File(filePath);
    return file.existsSync();
  }

  static showSnackBar(String title, String text, [Duration? duration]) {
    Get.snackbar(
      title,
      '',
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      margin: const EdgeInsets.all(8.0),
      snackStyle: SnackStyle.FLOATING,
      messageText: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      duration: duration,
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
    );
  }

  static Future<T?> showDialog<T>(
    String title,
    String text, {
    void Function()? onConfirm,
    void Function()? onCancel,
  }) {
    return Get.defaultDialog<T>(
      backgroundColor: AppConfig.BACKGROUND_COLOR,
      title: title,
      middleText: text,
      onConfirm: onConfirm,
      onCancel: onCancel,
      textConfirm: onConfirm != null ? 'Xác nhận' : null,
      textCancel: onCancel != null ? 'Huỷ bỏ' : null,
      buttonColor: AppConfig.TEXT_BTN_COLOR,
      confirmTextColor: AppConfig.OUTLINE_TEXT_BTN_COLOR,
      cancelTextColor: AppConfig.OUTLINE_TEXT_BTN_COLOR,
    );
  }

  static T? tryCast<T>(dynamic value) {
    try {
      return (value as T);
    } on TypeError catch (_) {
      return null;
    }
  }

  static String formatDouble(double numb) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('vi');
    return numberFormat.format(numb);
  }

  /// Return either loading widget if cState is loading or text widget show error if cState is error, otherwise null
  static Widget? cStateInLoadingOrError(CBaseState cState) {
    if (cState.state == CState.LOADING)
      return Center(child: CircularProgressIndicator());

    if (cState.state == CState.ERROR) {
      final String errText =
          cState.message != null ? 'Lỗi: ${cState.message}' : '';
      return Center(
        child: Text(errText),
      );
    }

    return null;
  }
}

class RandomExtension {
  int randomNumber(int min, int max) {
    final rn = new Random();
    final numb = min + rn.nextInt(max - min);
    return numb;
  }

  String randomWords() {
    List<String> words = [
      'Coffe',
      'Gà',
      'String',
      'Pepsi',
      'Hủ tiếu',
      'Mì Quảng',
      'Canh',
      'Bò kho',
      'Bánh',
      'Bún bò Hút',
      'Kẹo',
      'Sữa',
    ];
    int index = randomNumber(0, words.length);
    return words[index];
  }
}

class DateExtension {
  String dateToDateWithTime(DateTime date) {
    final f = new DateFormat('dd-MM-yyyy hh:mm a');
    return f.format(date);
  }

  String dateToDateOnly(DateTime date) {
    final f = new DateFormat('dd-MM-yyyy');
    return f.format(date);
  }

  String dateToMonthYear(DateTime date) {
    return '${date.month}/${date.year}';
  }

  String dateToDayMonth(DateTime date) {
    return '${date.day}/${date.month}';
  }

  DateTime getCurrentDay() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    return today;
  }

  DateTime getNextDay([DateTime? specificDate]) {
    DateTime today = specificDate == null ? getCurrentDay() : specificDate;
    return today.add(Duration(hours: Duration.hoursPerDay));
  }

  DateTime getFirstDateOfMonth(DateTime date) {
    return DateTime(date.year, date.month);
  }

  DateTime getLastDateOfMonth(DateTime date) {
    int lastday = DateTime(date.year, date.month + 1, 0).day;
    return DateTime(date.year, date.month, lastday);
  }

  DayRange getMonthRangeFromDate(DateTime date) {
    final DateTime startDate = getFirstDateOfMonth(date);
    final DateTime endDate = getLastDateOfMonth(date);
    return DayRange(startDate, endDate);
  }

  DateTime getFirstDateOfNextMonth(DateTime date) {
    return DateTime(
      date.year,
      date.month + 1,
    );
  }

  List<DayRange> getListMonthRanges(
    DateTime startDate,
    DateTime endDate,
  ) {
    // If same month
    if (startDate.month == endDate.month && startDate.year == endDate.year) {
      final newMonthRange = DayRange(startDate, getLastDateOfMonth(startDate));
      return [newMonthRange];
    }

    final List<DayRange> monthRanges = [];

    // Add current month of startDate
    monthRanges.add(DayRange(startDate, getLastDateOfMonth(startDate)));
    DateTime cur = startDate;

    while (cur.month != endDate.month || cur.year != endDate.year) {
      // Get next month of startDate
      cur = getFirstDateOfNextMonth(cur);
      DateTime endDate = getLastDateOfMonth(cur);

      DayRange newMonthRange = DayRange(cur, endDate);
      monthRanges.add(newMonthRange);
    }

    return monthRanges;
  }

  List<DayRange> getListDayRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    final List<DayRange> listDayRanges = [];

    DateTime curr = startDate;

    while (!curr.isAfter(endDate)) {
      final DateTime nextDay = getNextDay(curr);
      final DayRange newDayRange = DayRange(curr, nextDay);
      listDayRanges.add(newDayRange);
      curr = nextDay;
    }

    return listDayRanges;
  }
}

class FolderStatExtension {
  final int totalFiles;
  final int size;

  FolderStatExtension(this.totalFiles, this.size);

  String sizeToString() {
    return Utils.fileExtension.getFileSizeString(bytes: size);
  }
}

class FileExtension {
  String getFileSizeString({required int bytes, int decimals = 0}) {
    try {
      const List<String> suffixes = ["b", "KB", "MB", "GB", "TB"];
      final int i = (log(bytes) / log(1024)).floor();
      final result =
          ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
      return result;
    } catch (err) {
      return bytes.toString();
    }
  }

  FolderStatExtension dirStatSync(String dirPath) {
    int fileNum = 0;
    int totalSize = 0;
    final Directory dir = Directory(dirPath);
    try {
      if (dir.existsSync()) {
        dir
            .listSync(recursive: true, followLinks: false)
            .forEach((FileSystemEntity entity) {
          if (entity is File) {
            fileNum++;
            totalSize += entity.lengthSync();
          }
        });
      }
    } catch (e) {}

    return FolderStatExtension(fileNum, totalSize);
  }

  Future deleteFolder(String folderPath) async {
    final Directory dir = Directory(folderPath);
    return dir.delete(recursive: true);
  }
}
