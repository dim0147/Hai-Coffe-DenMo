import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Menu/MenuController.dart';
import 'package:hai_noob/Model/Cart.dart';

class PlaceBillSuccessScreenArgs {
  final int? tableID;
  final Cart cart;
  final int billID;

  PlaceBillSuccessScreenArgs({
    required this.cart,
    required this.billID,
    this.tableID,
  });
}

class PlaceBillSuccessController extends GetxController {
  final args = Utils.tryCast<PlaceBillSuccessScreenArgs>(Get.arguments);

  void onGoMenu() {
    final menuScreenArgs = MenuScreenArgs();
    Get.offAllNamed('/menu', arguments: menuScreenArgs);
  }

  void onGoTablePanel() {
    Get.offAllNamed('/table');
  }
}
