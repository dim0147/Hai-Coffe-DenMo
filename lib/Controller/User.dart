import 'package:get/get.dart';
import 'package:hai_noob/Model/User.dart';

class UserController extends GetxController {
  Rx<UserModel?> _user = null.obs;

  UserModel? get user => _user.value;

  void setUser(UserModel user) {
    _user.value = user;
  }
}
