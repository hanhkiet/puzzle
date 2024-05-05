import 'package:flutter/material.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/dashboard.dart';
import 'package:puzzle/ui/dashboard/dashboard_view.dart';
import 'package:puzzle/ui/home/home_view.dart';
import 'package:puzzle/ui/splash/splash_view.dart';
import 'package:tuple/tuple.dart';

var appRoutes = {
  KeyUtil.splash: (context) => const SplashView(),
  KeyUtil.dashboard: (context) => const DashboardView(),
  KeyUtil.home: (context) => HomeView(
      tuple2: ModalRoute.of(context)?.settings.arguments
          as Tuple2<Dashboard, double>),
};
