import 'package:get/get.dart';
import 'package:hai_noob/DAO/PhieuDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ListPhieuController extends GetxController {
  final AppDatabase appDb = Get.find<AppDatabase>();
  late final PhieuDAO phieuDAO;

  final Rx<bool> showDateRangePicker = false.obs;
  final DateRangePickerController dateRangePickerC =
      DateRangePickerController();

  final RxList<Phieu> listPhieu = <Phieu>[].obs;
  final Rxn<PhieuType> filterType = Rxn<PhieuType>();

  @override
  void onInit() {
    super.onInit();
    phieuDAO = PhieuDAO(appDb);
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

    final phieus = await phieuDAO.getPhieuBetweenDays(startDate, endDate);
    listPhieu.assignAll(phieus);

    setShowDateRangePicker(false);
  }

  void onCancelDateRange() {
    dateRangePickerC.selectedRange = null;
    setShowDateRangePicker(false);
  }

  void setFilterPhieuType(PhieuType? value) {
    filterType.value = value;
  }

  void onRemoveListItem(int phieuId) async {}
}
