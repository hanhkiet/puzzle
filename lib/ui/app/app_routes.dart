import 'package:flutter/material.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/dashboard.dart';
import 'package:puzzle/ui/home/home_view.dart';
import 'package:tuple/tuple.dart';

var appRoutes = {
  KeyUtil.home: (context) => HomeView(
      tuple2: ModalRoute.of(context)?.settings.arguments
          as Tuple2<Dashboard, double>),
};
