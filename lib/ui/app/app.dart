import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/core/app_routes.dart';
import 'package:puzzle/ui/app/language_provider.dart';
import 'package:puzzle/ui/app/theme_provider.dart';

import '../../core/app_theme.dart';

class MyApp extends StatelessWidget {
  final String fontFamily = "Montserrat";

  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Consumer2<ThemeProvider, LanguageProvider>(builder: (context,
        ThemeProvider themeProvider, LanguageProvider languageProvider, child) {
      return MaterialApp(
        title: 'Math Puzzle',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        initialRoute: KeyUtil.splash,
        routes: appRoutes,
        navigatorObservers: const [],
      );
    });
  }
}
