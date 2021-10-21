import 'package:get/get.dart';
import 'package:hai_noob/DAO/BillDAO.dart';

class OrderDetailScreenArgs {
  final BillEntity billEntity;

  OrderDetailScreenArgs(this.billEntity);
}

class OrderDetailController extends GetxController {
  final OrderDetailScreenArgs args = Get.arguments;
}
