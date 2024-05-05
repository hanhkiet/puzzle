import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/ui/app/app.dart';
import 'package:puzzle/ui/app/coin_provider.dart';
import 'package:puzzle/ui/app/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/dashboard/dashboard_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await initializeService();
  if (kDebugMode) {}
  final sharedPreferences = await SharedPreferences.getInstance();

  // print("va===${getFormattedString(19.2)}");

  setupServiceLocator(sharedPreferences);
  runApp(
    MultiProvider(
      providers: [
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
      child: const MyApp(),
    ),
  );
}

setupServiceLocator(SharedPreferences sharedPreferences) {
  GetIt.I.registerSingleton<DashboardProvider>(
      DashboardProvider(preferences: sharedPreferences));
}
