import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/PhieuDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ListPhieuScreenArgs {
  final DateTime startDate;
  final DateTime endDate;

  ListPhieuScreenArgs(this.startDate, this.endDate);
}

class ListPhieuController extends GetxController {
  final ListPhieuScreenArgs? args = Get.arguments;
  final AppDatabase appDb = Get.find<AppDatabase>();
  late final PhieuDAO phieuDAO;

  final Rx<bool> showDateRangePicker = false.obs;
  final DateRangePickerController dateRangePickerC =
      DateRangePickerController();

  final RxList<Phieu> listPhieu = <Phieu>[].obs;
  final Rxn<PhieuType> filterType = Rxn<PhieuType>();

  Future queryListBetweenDay(DateTime startDate, DateTime endDate) async {
    final phieus = await phieuDAO.getPhieuBetweenDays(startDate, endDate);
    listPhieu.assignAll(phieus);
  }

  @override
  void onInit() {
    super.onInit();
    phieuDAO = PhieuDAO(appDb);

    DateTime startDate = Utils.dateExtension.getCurrentDay();
    DateTime endDate = Utils.dateExtension.getNextDay();
    // Query today
    if (args != null) {}

    final PickerDateRange pickerDateRange = PickerDateRange(startDate, endDate);
    dateRangePickerC.selectedRange = pickerDateRange;
    queryListBetweenDay(startDate, endDate);
    return;
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

    await queryListBetweenDay(startDate, endDate);

    setShowDateRangePicker(false);
  }

  void onCancelDateRange() {
    dateRangePickerC.selectedRange = null;
    setShowDateRangePicker(false);
  }

  void setFilterPhieuType(PhieuType? value) {
    filterType.value = value;
  }

  void onRemoveListItem(int phieuId) async {
    try {
      await phieuDAO.removePhieuById(phieuId);
      listPhieu.removeWhere((e) => e.id == phieuId);
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }
}
