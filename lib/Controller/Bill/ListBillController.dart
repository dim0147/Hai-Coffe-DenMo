import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Bill/BillDetailController.dart';
import 'package:hai_noob/Controller/Constant.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ListBillsScreenArgs {
  final DateTime startDate;
  final DateTime endDate;

  ListBillsScreenArgs(this.startDate, this.endDate);
}

class ListBillController extends GetxController {
  final ListBillsScreenArgs? args = Get.arguments;
  final AppDatabase appDb = Get.find<AppDatabase>();
  late final BillDAO billDAO;

  final Rx<bool> showDateRangePicker = false.obs;
  final DateRangePickerController dateRangePickerC =
      DateRangePickerController();

  final Rx<CBaseState> cState = CBaseState(CState.LOADING).obs;
  final RxList<BillEntity> listBill = <BillEntity>[].obs;

  Future queryListBetweenDay(DateTime startDate, DateTime endDate) async {
    final bills = await billDAO.getBillBetweenDay(startDate, endDate);
    listBill.assignAll(bills);
  }

  @override
  void onInit() async {
    super.onInit();
    billDAO = BillDAO(appDb);
    final cState = this.cState.value;
    cState.setGetC(this.cState);
    try {
      // Default query today
      DateTime startDate = Utils.dateExtension.getCurrentDay();
      DateTime endDate = Utils.dateExtension.getNextDay();

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
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
    }
  }

  void setVisibleDateRangePicker(bool value) {
    showDateRangePicker.value = value;
  }

  void onSubmitDateRange(Object? value) async {
    final cState = this.cState.value;
    try {
      if (value == null || !(value is PickerDateRange)) return;

      final DateTime? startDate = value.startDate;
      DateTime? endDate = value.endDate;

      if (startDate == null) return;
      if (endDate == null || endDate == startDate)
        endDate = Utils.dateExtension.getNextDay(startDate);

      cState.changeState(CState.LOADING);
      await Future.delayed(Duration(seconds: 5));
      await queryListBetweenDay(startDate, endDate);
      cState.changeState(CState.DONE);
      setVisibleDateRangePicker(false);
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
    }
  }

  void onCancelDateRange() {
    dateRangePickerC.selectedRange = null;
    setVisibleDateRangePicker(false);
  }

  void onSearchKeyword(String? keyword) async {
    final cState = this.cState.value;
    try {
      if (keyword == null) return;

      // If empty we fetch again the selectedRange
      if (keyword.length == 0) {
        final pickerDateRange = dateRangePickerC.selectedRange;
        if (pickerDateRange == null) return;
        onSubmitDateRange(pickerDateRange);
        return;
      }

      int? billId = int.tryParse(keyword);
      if (billId == null) return;

      cState.changeState(CState.LOADING);
      final bill = await billDAO.getById(billId);
      cState.changeState(CState.DONE);
      if (bill == null) return listBill.clear();

      listBill.assignAll([bill]);
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
      cState.changeState(CState.ERROR, err.toString());
    }
  }

  void onClickItem(BillEntity billEntity) {
    final BillDetailScreenArgs args = BillDetailScreenArgs(billEntity);
    Get.toNamed('/bill/detail', arguments: args);
  }

  void onRemoveListItem(int billId) async {
    try {
      await billDAO.removeById(billId);
      listBill.removeWhere((e) => e.bill.id == billId);
    } catch (err) {
      Utils.showSnackBar('Lỗi', err.toString());
    }
  }
}
