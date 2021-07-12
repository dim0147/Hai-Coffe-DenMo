import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screen/LoginScreen.dart';

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
      title: 'Hải Bên Lề',
      initialRoute: '/login',
      initialBinding: SpashBinding(),
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => LoginController());
          }),
        )
      ],
    );
  }
}
