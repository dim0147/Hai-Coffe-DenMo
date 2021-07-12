import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/User.dart';

class LoginController extends GetxController {
  TextEditingController textUsernameC = TextEditingController();
  TextEditingController textPasswordC = TextEditingController();
  UserController userController = Get.find<UserController>();
}
