import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/PhieuDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CreatePhieuController extends GetxController {
  final AppDatabase appDb = Get.find<AppDatabase>();
  late final PhieuDAO phieuDAO;
  final TextEditingController textC = TextEditingController();
  final MoneyMaskedTextController amountC = MoneyMaskedTextController(
    decimalSeparator: '',
    precision: 0,
  );
  final Rx<PhieuType> phieuType = PhieuType.PHIEU_CHI.obs;

  @override
  void onInit() {
    super.onInit();
    phieuDAO = PhieuDAO(appDb);
  }

  void onChangePhieuType(PhieuType? type) {
    if (type == null) return;
    phieuType.value = type;
  }

  void onAdd() async {
    try {
      final String text = textC.text;
      final double amount = amountC.numberValue;

      if (text == '' && amount == 0)
        return Utils.showSnackBar('Lỗi', 'Nhập giá hoặc nội dung');

      final PhieusCompanion newPhieu = PhieusCompanion.insert(
        amount: amount,
        reason: text,
        type: phieuType.value,
      );
      await phieuDAO.addNewPhieu(newPhieu);

      final String phieuName =
          phieuType.value == PhieuType.PHIEU_CHI ? 'phiếu chi' : 'phiếu thu';
      Utils.showSnackBar('Thành công', 'Tạo  $phieuName thành công');
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }
}
