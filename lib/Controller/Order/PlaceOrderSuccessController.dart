import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Menu/MenuController.dart';
import 'package:hai_noob/Model/Cart.dart';

class PlaceOrderSuccessScreenArgs {
  final int? tableID;
  final Cart cart;
  final int billID;

  PlaceOrderSuccessScreenArgs({
    required this.cart,
    required this.billID,
    this.tableID,
  });
}

class PlaceOrderSuccessController extends GetxController {
  final args = Utils.tryCast<PlaceOrderSuccessScreenArgs>(Get.arguments);

  void onGoMenu() {
    final menuScreenArgs = MenuScreenArgs();
    Get.offAllNamed('/menu', arguments: menuScreenArgs);
  }

  void onGoTablePanel() {
    Get.offAllNamed('/table');
  }
}
