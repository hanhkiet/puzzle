import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData get theme {
    ThemeData base = ThemeData.light();

    return base.copyWith(
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        textTheme: base.textTheme.copyWith(
          bodySmall: base.textTheme.bodySmall!.copyWith(
            color: const Color(0xff757575),
          ),
        ),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        colorScheme: const ColorScheme.light(
            background: Colors.white, brightness: Brightness.light));
  }

  static ThemeData get darkTheme {
    ThemeData base = ThemeData.dark();

    return base.copyWith(
      scaffoldBackgroundColor: Colors.black,
      cardColor: Colors.black,
      textTheme: base.textTheme.copyWith(
        bodySmall: base.textTheme.bodySmall!.copyWith(
          color: const Color(0xff616161),
        ),
      ),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      colorScheme: const ColorScheme.dark(
        background: Colors.black,
        brightness: Brightness.dark,
      ),
    );
  }
}
