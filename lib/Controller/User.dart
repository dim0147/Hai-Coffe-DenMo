import 'package:get/get.dart';
import 'package:hai_noob/Model/User.dart';

class UserController extends GetxController {
  Rx<Users?> _user = null.obs;

  Users? get user => _user.value;

  void setUser(Users user) {
    _user.value = user;
  }
}
