import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/DAO/PhieuDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ListOrderController extends GetxController {
  final AppDatabase appDb = Get.find<AppDatabase>();
  late final BillDAO billDAO;

  final Rx<bool> showDateRangePicker = false.obs;
  final DateRangePickerController dateRangePickerC =
      DateRangePickerController();

  final RxList<Bill> listBill = <Bill>[].obs;

  @override
  void onInit() {
    super.onInit();
    billDAO = BillDAO(appDb);
  }

  void setShowDateRangePicker(bool value) {
    showDateRangePicker.value = value;
  }

  void onSubmitDateRange(Object? value) async {
    if (value == null || !(value is PickerDateRange)) return;

    final DateTime? startDate = value.startDate;
    DateTime? endDate = value.endDate;

    if (startDate == null) return;
    // If end day not set or equal start date we set the endDate equal the start of next day of start day (start date is 17th 00:00:00=> end date will be 18th 00:00:00)
    if (endDate == null || endDate == startDate)
      endDate = startDate.add(Duration(hours: Duration.hoursPerDay));

    // final phieus = await billDAO.getPhieuBetweenDays(startDate, endDate);
    // listBill.assignAll(phieus);

    setShowDateRangePicker(false);
  }

  void onCancelDateRange() {
    dateRangePickerC.selectedRange = null;
    setShowDateRangePicker(false);
  }

  void onRemoveListItem(int phieuId) async {
    try {
      // await billDAO.removePhieuById(phieuId);
      // listPhieu.removeWhere((e) => e.id == phieuId);
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }
}
