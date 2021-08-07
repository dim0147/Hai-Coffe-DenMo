import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/StartupController.dart';

import 'Screen/LoginScreen.dart';
import 'Screen/StartupScreen.dart';

import 'Blinding/SpashBlinding.dart';

import 'Controller/LoginController.dart';

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
      ).copyWith(
        // Color Scheme
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: AppConfig.MAIN_COLOR,
            ),

        // Color
        scaffoldBackgroundColor: AppConfig.BACKGROUND_COLOR,
        primaryColor: AppConfig.MAIN_COLOR,

        // Chip
        chipTheme: ThemeData().chipTheme.copyWith(
              backgroundColor: AppConfig.MAIN_COLOR,
              deleteIconColor: AppConfig.CHIP_DELETE_ICON_COLOR,
            ),

        // Checkbox
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(AppConfig.MAIN_COLOR),
          overlayColor: MaterialStateProperty.all(AppConfig.MAIN_COLOR),
        ),

        // Text Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            foregroundColor:
                MaterialStateProperty.all<Color>(AppConfig.TEXT_BTN_COLOR),
          ),
        ),

        // Text Field
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: AppConfig.MAIN_COLOR,
          ),
          labelStyle: TextStyle(
            color: AppConfig.MAIN_COLOR,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2.0),
          ),
        ),

        // Text Theme
        textTheme: TextTheme().copyWith(
          bodyText2: TextStyle(fontSize: 14.0, color: AppConfig.MAIN_COLOR),
        ),
      ),
      title: 'Hải Bên Lề',
      initialRoute: '/startup',
      initialBinding: SpashBinding(),
      getPages: AppConfig.GetPages,
    );
  }
}
