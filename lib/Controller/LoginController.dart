import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../DB/Database.dart';
import '../Model/Cart.dart' as Cart;

import '../DAO/UserDAO.dart';

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
    String username = textUsernameC.text;
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
