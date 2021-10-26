import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../DAO/UserDAO.dart';
import '../DB/Database.dart';

class LoginController extends GetxController with StateMixin<void> {
  Color? mainColor = Colors.amber[300];

  TextEditingController textUsernameC = TextEditingController();
  TextEditingController textPasswordC = TextEditingController();
  Rx<bool> saveAccount = false.obs;

  AppDatabase? db;
  UserDAO? userDAO;

  @override
  void onInit() async {
    // Init services
    db = Get.find<AppDatabase>();
    userDAO = UserDAO(db!);

    // Is Success
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void onLoginClick() async {
    change(null, status: RxStatus.loading());

    // Get input data
    String password = textPasswordC.text;

    // Query User
    User? user = await userDAO!.findUserByUsername(textUsernameC.text);

    // Check if valid
    if (user == null) {
      return change(null, status: RxStatus.error('Username không chính xác'));
    }

    if (user.password != password) {
      return change(null, status: RxStatus.error('Password không chính xác'));
    }

    // Success
    change(null, status: RxStatus.success());
  }

  void onSaveAccountCheckbox(bool? value) async {
    saveAccount.value = value!;
  }
}
