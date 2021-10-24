import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Revenue.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum RevenueScreenViewType {
  MONTH,
  DAY,
}

class RevenueController extends GetxController {
  final AppDatabase appDb = Get.find<AppDatabase>();

  final Rx<RevenueScreenViewType> viewType = RevenueScreenViewType.MONTH.obs;
  final RxList<Revenue> listRevenues = <Revenue>[].obs;

  void onChangeViewType(RevenueScreenViewType? type) {
    if (type == null) return;
    viewType.value = type;
  }

  void onSubmitDateRange(Object? value) async {
    if (value == null || !(value is PickerDateRange)) return;

    final DateTime? startDate = value.startDate;
    DateTime? endDate = value.endDate;

    if (startDate == null || endDate == null) return;

    final lastDay = Utils.dateExtension.getLastDayOfMonth(startDate);
    var ad;
  }
}
