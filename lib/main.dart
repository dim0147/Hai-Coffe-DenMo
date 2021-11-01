import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await dotenv.load();
  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['SENTRY_DSN'];
    },
    appRunner: () => runApp(MyApp()),
  );
  // runApp(MyApp());
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
            borderSide: BorderSide(color: AppConfig.MAIN_COLOR, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppConfig.MAIN_COLOR, width: 2.0),
          ),
        ),

        // Text Theme
        textTheme: TextTheme().copyWith(
          bodyText2: TextStyle(color: AppConfig.FONT_COLOR),
        ),

        iconTheme: IconThemeData(color: AppConfig.MAIN_COLOR),

        // Divider
        dividerColor: AppConfig.DIVIDER_COLOR,
      ),
      title: 'Hải Bên Lề',
      initialRoute: '/startup',
      getPages: AppConfig.GetPages,
    );
  }
}
