import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/ui/app/app.dart';
import 'package:puzzle/ui/app/coin_provider.dart';
import 'package:puzzle/ui/app/language_provider.dart';
import 'package:puzzle/ui/app/theme_provider.dart';
import 'package:puzzle/ui/dashboard/dashboard_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/random_find_missing_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await EasyLocalization.ensureInitialized();
  if (kDebugMode) {}
  final sharedPreferences = await SharedPreferences.getInstance();

  if (kDebugMode) {
    print("va===${getFormattedString(19.2)}");
  }

  setupServiceLocator(sharedPreferences);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              LanguageProvider(sharedPreferences: sharedPreferences),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ThemeProvider(sharedPreferences: sharedPreferences),
        ),
        ChangeNotifierProvider<DashboardProvider>(
          create: (context) => GetIt.I.get<DashboardProvider>(),
        ),
        ChangeNotifierProvider<CoinProvider>(
          create: (context) => GetIt.I.get<CoinProvider>(),
        ),
      ],
      child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('vi')],
          path:
              'assets/translations', // <-- change the path of the translation files
          fallbackLocale: const Locale('en'),
          startLocale: appLocale,
          child: const MyApp()),
    ),
  );
}

setupServiceLocator(SharedPreferences sharedPreferences) {
  GetIt.I.registerSingleton<DashboardProvider>(
      DashboardProvider(preferences: sharedPreferences));
}
