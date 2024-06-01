import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Locale viLocale = const Locale('vi');
Locale enLocale = const Locale('en');
Locale appLocale = const Locale('en');

class LanguageProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  LanguageProvider({required this.sharedPreferences}) {
    appLocale = sharedPreferences.getBool(KeyUtil.isVietnamese) ?? false
        ? viLocale
        : enLocale;
  }

  void changeLocale(BuildContext context) async {
    if (appLocale == viLocale) {
      appLocale = enLocale;
    } else {
      appLocale = viLocale;
    }
    context.setLocale(appLocale);
    notifyListeners();
    await sharedPreferences.setBool(
        KeyUtil.isVietnamese, appLocale == viLocale);
  }
}
