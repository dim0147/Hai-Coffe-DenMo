import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'DB/Database.dart';

import 'Screen/LoginScreen.dart';
import 'Screen/StartupScreen.dart';

import 'Blinding/SpashBlinding.dart';

import 'Controller/User.dart';
import 'Controller/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'QuickSand',
        primaryColor: Color.fromRGBO(218, 172, 88, 1.0),
      ),
      title: 'Hải Bên Lề',
      initialRoute: '/login',
      initialBinding: SpashBinding(),
      getPages: [
        GetPage(
          name: '/startup',
          page: () => StartupScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => LoginController());
          }),
        ),
      ],
    );
  }
}
