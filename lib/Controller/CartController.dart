import 'package:get/get.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    var cart = Get.arguments;
    var d;
  }

  void onCancelClick() {
    Get.back();
  }
}
