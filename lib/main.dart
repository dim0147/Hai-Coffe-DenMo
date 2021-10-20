import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/StartupController.dart';

import 'Screen/LoginScreen.dart';
import 'Screen/StartupScreen.dart';

import 'Blinding/SpashBlinding.dart';

import 'Controller/LoginController.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('vi'), // English, no country code
      ],
      locale: const Locale('vi'),
      theme: ThemeData(
        fontFamily: 'QuickSand',
      ).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: AppConfig.MAIN_COLOR,
            ),

        // Layout
        scaffoldBackgroundColor: AppConfig.BACKGROUND_COLOR,
        appBarTheme: AppBarTheme(color: AppConfig.MAIN_COLOR),

        // Button
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: AppConfig.TEXT_BTN_COLOR,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: AppConfig.MAIN_COLOR,
            onPrimary: AppConfig.ELEVATED_TEXT_BTN_COLOR,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppConfig.MAIN_COLOR),
            primary: AppConfig.OUTLINE_TEXT_BTN_COLOR,
          ),
        ),

        // Component
        chipTheme: ThemeData().chipTheme.copyWith(
              backgroundColor: AppConfig.MAIN_COLOR,
              deleteIconColor: AppConfig.CHIP_DELETE_ICON_COLOR,
            ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(AppConfig.MAIN_COLOR),
          overlayColor: MaterialStateProperty.all(AppConfig.MAIN_COLOR),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(AppConfig.MAIN_COLOR),
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
          bodyText2: TextStyle(color: AppConfig.FONT_COLOR),
        ),

        iconTheme: IconThemeData(color: AppConfig.MAIN_COLOR),

        // Divider
        dividerColor: AppConfig.MAIN_COLOR,
      ),
      title: 'Hải Bên Lề',
      initialRoute: '/startup',
      initialBinding: SpashBinding(),
      getPages: AppConfig.GetPages,
    );
  }
}
