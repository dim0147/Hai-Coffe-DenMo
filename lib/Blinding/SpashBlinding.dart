import 'package:get/get.dart';
import 'package:hai_noob/Controller/User.dart';

class SpashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}
