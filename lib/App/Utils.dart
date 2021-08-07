class Utils {
  static double? convertStringToDouble(String str) {
    return double.tryParse(str.replaceAll('.', '').replaceAll(',', '.'));
  }
}
