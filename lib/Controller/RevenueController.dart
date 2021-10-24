import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/RevenueDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Revenue.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum RevenueScreenViewType {
  MONTH,
  DAY,
}

class RevenueController extends GetxController {
  late final RevenueDAO revenueDAO;

  final Rx<RevenueScreenViewType> viewType = RevenueScreenViewType.MONTH.obs;
  final RxList<Revenue> listRevenues = <Revenue>[].obs;

  @override
  void onInit() {
    super.onInit();
    final AppDatabase appDb = Get.find<AppDatabase>();
    revenueDAO = RevenueDAO(appDb);
  }

  void onChangeViewType(RevenueScreenViewType? type) {
    if (type == null) return;
    viewType.value = type;
  }

  void onSubmitDateRange(Object? value) async {
    if (value == null || !(value is PickerDateRange)) return;

    final DateTime? startDate = value.startDate;
    DateTime? endDate = value.endDate;
    if (startDate == null) return;
    if (endDate == null)
      endDate = Utils.dateExtension.getLastDateOfMonth(startDate);

    final listOfMonthRanges =
        Utils.dateExtension.getListMonthRangesFromDateRange(startDate, endDate);
    if (listOfMonthRanges == null)
      return Utils.showSnackBar(
        'Lỗi',
        'Không thể get listOfMonthRanges',
      );

    final taskGetRevenues = listOfMonthRanges
        .map((e) => revenueDAO.getRevenue(e.startDate, e.endDate));

    final revenue = await Future.wait(taskGetRevenues);
    listRevenues.assignAll(revenue);

    var ad;
  }
}
