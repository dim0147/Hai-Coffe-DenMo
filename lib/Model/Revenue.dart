import 'package:hai_noob/Model/Phieu.dart';

class EntityRevenue {
  final int amount;
  final double? totalRevenue;
  final DateTime startDate;
  final DateTime endDate;

  EntityRevenue(this.amount, this.totalRevenue, this.startDate, this.endDate);
}

class BillRevenue extends EntityRevenue {
  BillRevenue(
    int amount,
    double? totalRevenue,
    DateTime startDate,
    DateTime endDate,
  ) : super(
          amount,
          totalRevenue,
          startDate,
          endDate,
        );
}

class PhieuRevenue extends EntityRevenue {
  final PhieuType phieuType;

  PhieuRevenue(
    int amount,
    double? totalRevenue,
    DateTime startDate,
    DateTime endDate,
    this.phieuType,
  ) : super(
          amount,
          totalRevenue,
          startDate,
          endDate,
        );
}

class Revenue {
  final BillRevenue bill;
  final PhieuRevenue phieuChi;
  final PhieuRevenue phieuThu;

  Revenue(this.bill, this.phieuChi, this.phieuThu);
}
