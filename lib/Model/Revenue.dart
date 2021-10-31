import 'package:hai_noob/Model/Phieu.dart';

class EntityRevenue {
  final int amount;
  final double? totalRevenue;

  EntityRevenue(
    this.amount,
    this.totalRevenue,
  );
}

class BillRevenue extends EntityRevenue {
  BillRevenue(
    int amount,
    double? totalRevenue,
  ) : super(
          amount,
          totalRevenue,
        );
}

class PhieuRevenue extends EntityRevenue {
  final PhieuType phieuType;

  PhieuRevenue(
    int amount,
    double? totalRevenue,
    this.phieuType,
  ) : super(
          amount,
          totalRevenue,
        );
}

class Revenue {
  final BillRevenue bill;
  final PhieuRevenue phieuChi;
  final PhieuRevenue phieuThu;
  final DateTime startDate;
  final DateTime endDate;

  Revenue(
      this.bill, this.phieuChi, this.phieuThu, this.startDate, this.endDate);

  double total() {
    final billRevenue = bill.totalRevenue ?? 0.0;
    final phieuChiRevenue = phieuChi.totalRevenue ?? 0.0;
    final phieuThuRevenue = phieuThu.totalRevenue ?? 0.0;

    return (billRevenue + phieuChiRevenue) - phieuThuRevenue;
  }
}

class DayRange {
  final DateTime startDate;
  final DateTime endDate;

  DayRange(this.startDate, this.endDate);
}
