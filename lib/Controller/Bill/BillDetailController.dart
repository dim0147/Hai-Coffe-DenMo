import 'package:get/get.dart';
import 'package:hai_noob/DAO/BillDAO.dart';

class BillDetailScreenArgs {
  final BillEntity billEntity;

  BillDetailScreenArgs(this.billEntity);
}

class BillDetailController extends GetxController {
  final BillDetailScreenArgs args = Get.arguments;
}
