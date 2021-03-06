import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/Controller/Bill/ListBillController.dart';
import 'package:hai_noob/Controller/Phieu/ListPhieuController.dart';
import 'package:hai_noob/DAO/RevenueDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Revenue.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum RevenueScreenViewType {
  MONTH,
  DAY,
}

class RevenueController extends GetxController {
  late final RevenueDAO revenueDAO;

  final DateRangePickerController dateRangePickerC =
      DateRangePickerController();

  final Rx<CBaseState> cState = CBaseState(CState.LOADING).obs;
  final Rx<RevenueScreenViewType> viewType = RevenueScreenViewType.DAY.obs;
  final RxList<Revenue> listRevenues = <Revenue>[].obs;

  @override
  void onInit() async {
    try {
      super.onInit();

      final AppDatabase appDb = Get.find<AppDatabase>();
      revenueDAO = RevenueDAO(appDb);
      dateRangePickerC.view = DateRangePickerView.month;

      // Setup cState
      final cState = this.cState.value;
      cState.setGetC(this.cState);

      // Default query start day of current month to now
      DateTime now = Utils.dateExtension.getCurrentDay();
      final DateTime startDate = Utils.dateExtension.getFirstDateOfMonth(now);
      // Now is same day with start date, we change now to tomorrow
      if (now.isAtSameMomentAs(startDate))
        now = Utils.dateExtension.getNextDay(startDate);

      await queryOnDayViewType(startDate, now);

      final PickerDateRange pickerDateRange = PickerDateRange(startDate, now);
      dateRangePickerC.selectedRange = pickerDateRange;

      cState.changeState(CState.DONE);
    } catch (err, stackTrace) {
      cState.value.changeState(CState.ERROR, err.toString());
      Utils.showSnackBar('Lỗi', err.toString());
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }

  void onChangeViewType(RevenueScreenViewType? type) {
    if (type == null) return;
    viewType.value = type;
    dateRangePickerC.view = type == RevenueScreenViewType.MONTH
        ? DateRangePickerView.year
        : DateRangePickerView.month;
  }

  void onSubmitDateRange(Object? value) async {
    final cState = this.cState.value;
    try {
      if (value == null || !(value is PickerDateRange)) return;
      cState.changeState(CState.LOADING);

      final DateTime? startDate = value.startDate;
      DateTime? endDate = value.endDate;

      if (viewType.value == RevenueScreenViewType.MONTH)
        await queryOnMonthViewType(startDate, endDate);
      if (viewType.value == RevenueScreenViewType.DAY)
        await queryOnDayViewType(startDate, endDate);

      cState.changeState(CState.DONE);
    } catch (err, stackTrace) {
      cState.changeState(CState.ERROR, err.toString());
      Utils.showSnackBar(
        'Lỗi',
        err.toString(),
      );
      Sentry.captureException(
        err,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> queryOnMonthViewType(
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    if (startDate == null) return;

    // Assign end date is last day of startDate's month
    if (endDate == null)
      endDate = Utils.dateExtension.getLastDateOfMonth(startDate);

    final listOfMonthRanges =
        Utils.dateExtension.getListMonthRanges(startDate, endDate);

    return queryByListDayRanges(listOfMonthRanges);
  }

  Future<void> queryOnDayViewType(
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    if (startDate == null) return;

    // Assign end date is next day of startDate
    if (endDate == null) endDate = Utils.dateExtension.getNextDay(startDate);

    final listOfDayRanges =
        Utils.dateExtension.getListDayRange(startDate, endDate);

    return queryByListDayRanges(listOfDayRanges);
  }

  Future<void> queryByListDayRanges(List<DayRange> dayRanges) async {
    final taskGetRevenues =
        dayRanges.map((e) => revenueDAO.getRevenue(e.startDate, e.endDate));

    final revenue = await Future.wait(taskGetRevenues);
    listRevenues.assignAll(revenue);
  }

  void onSeeBill(Revenue revenue) {
    final ListBillsScreenArgs args =
        ListBillsScreenArgs(revenue.startDate, revenue.endDate);
    Get.toNamed('/bill/list', arguments: args);
  }

  void onSeePhieu(Revenue revenue) {
    final ListPhieuScreenArgs args =
        ListPhieuScreenArgs(revenue.startDate, revenue.endDate);
    Get.toNamed('/phieu/list', arguments: args);
  }
}
