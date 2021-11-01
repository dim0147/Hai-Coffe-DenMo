import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/DAO/PhieuDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Phieu.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
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

  final Rx<CBaseState> cState = CBaseState(CState.LOADING).obs;
  final RxList<Phieu> listPhieu = <Phieu>[].obs;
  final Rxn<PhieuType> filterType = Rxn<PhieuType>();

  @override
  void onInit() async {
    super.onInit();
    phieuDAO = PhieuDAO(appDb);

    final CBaseState cState = this.cState.value;
    cState.setGetC(this.cState);

    try {
      // Query today
      DateTime startDate = Utils.dateExtension.getCurrentDay();
      DateTime endDate = Utils.dateExtension.getNextDay();

      // If have argument
      final args = this.args;
      if (args != null) {
        startDate = args.startDate;
        endDate = args.endDate;
      }

      final PickerDateRange pickerDateRange =
          PickerDateRange(startDate, endDate);
      dateRangePickerC.selectedRange = pickerDateRange;
      await queryListBetweenDay(startDate, endDate);
      cState.changeState(CState.DONE);
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }

  void setShowDateRangePicker(bool value) {
    showDateRangePicker.value = value;
  }

  void onSubmitDateRange(Object? value) async {
    if (value == null || !(value is PickerDateRange)) return;

    final CBaseState cState = this.cState.value;

    try {
      final DateTime? startDate = value.startDate;
      DateTime? endDate = value.endDate;

      if (startDate == null) return;
      // If end day not set or equal start date we set the endDate equal the next day of start day (start date is 17th 00:00:00=> end date will be 18th 00:00:00)
      if (endDate == null || endDate == startDate)
        endDate = startDate.add(Duration(hours: Duration.hoursPerDay));

      setShowDateRangePicker(false);

      cState.changeState(CState.LOADING);
      await queryListBetweenDay(startDate, endDate);
      cState.changeState(CState.DONE);
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
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
    } catch (err, stackTrace) {
      Utils.showSnackBar('Lỗi', err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }

  void onFloatingBtn() {
    Get.offNamed('/phieu/add');
  }

  Future<void> queryListBetweenDay(DateTime startDate, DateTime endDate) async {
    final phieus = await phieuDAO.getPhieuBetweenDays(startDate, endDate);
    listPhieu.assignAll(phieus);
  }
}
