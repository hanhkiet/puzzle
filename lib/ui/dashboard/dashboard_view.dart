import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_constants.dart';
import '../../data/models/dashboard.dart';
import '../../utility/constants.dart';
import '../app/theme_provider.dart';
import '../resizer/fetch_pixels.dart';
import 'dashboard_button_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetLeftEnter;
  late Animation<Offset> _offsetRightEnter;
  late bool isHomePageOpen;

  @override
  void initState() {
    super.initState();
    isHomePageOpen = false;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _offsetLeftEnter = Tween<Offset>(
      begin: const Offset(2, 0),
      end: Offset.zero,
    ).animate(_controller);

    _offsetRightEnter = Tween<Offset>(
      begin: const Offset(-2.0, 0.0),
      end: Offset.zero,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void exitApp() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    double margin = getHorizontalSpace(context);
    double verticalSpace = getScreenPercentSize(context, 3);

    ThemeProvider themeProvider = Provider.of(context);

    setStatusBarColor(Theme.of(context).scaffoldBackgroundColor);

    return PopScope(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Theme.of(context).brightness,
        ),
        child: Scaffold(
          appBar: getNoneAppBar(context),
          body: SafeArea(
            bottom: true,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: getVerticalSpace(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: getScoreWidget(
                              context,
                            ),
                            flex: 1,
                          ),
                          getSettingWidget(context),
                        ],
                      ),
                      SizedBox(height: getVerticalSpace(context)),
                      // SizedBox(height: getScreenPercentSize(context, 3),),

                      getHeaderWidget(context, 'Math Puzzle',
                          'Train Your Brain, Improve Your Math Skill'.tr()),

                      // SizedBox(height: getScreenPercentSize(context, 5),),
                      SizedBox(height: FetchPixels.getPixelHeight(120)),

                      Expanded(
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification:
                              (OverscrollIndicatorNotification overscroll) {
                            overscroll.disallowIndicator();
                            return true;
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                DashboardButtonView(
                                  dashboard: KeyUtil.dashboardItems[0],
                                  position: _offsetLeftEnter,
                                  margin: margin,
                                  onTab: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      KeyUtil.home,
                                      ModalRoute.withName(KeyUtil.dashboard),
                                      arguments: Tuple2(
                                          getItem(0, themeProvider),
                                          MediaQuery.of(context).padding.top),
                                    );
                                  },
                                ),
                                SizedBox(height: verticalSpace),
                                DashboardButtonView(
                                  dashboard: KeyUtil.dashboardItems[1],
                                  position: _offsetRightEnter,
                                  margin: margin,
                                  onTab: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      KeyUtil.home,
                                      ModalRoute.withName(KeyUtil.dashboard),
                                      arguments: Tuple2(
                                          getItem(1, themeProvider),
                                          MediaQuery.of(context).padding.top),
                                    );
                                  },
                                ),
                                SizedBox(height: verticalSpace),
                                DashboardButtonView(
                                  dashboard: KeyUtil.dashboardItems[2],
                                  position: _offsetLeftEnter,
                                  margin: margin,
                                  onTab: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      KeyUtil.home,
                                      ModalRoute.withName(KeyUtil.dashboard),
                                      arguments: Tuple2(
                                          getItem(2, themeProvider),
                                          MediaQuery.of(context).padding.top),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onPopInvoked: (didPop) {
        if (didPop) {
          exitApp();
        }
      },
    );
  }

  Dashboard getItem(int i, ThemeProvider themeProvider) {
    var model = KeyUtil.dashboardItems[i];

    if (themeMode == ThemeMode.dark) {
      model.bgColor = "#383838".toColor();
    } else {
      model.bgColor = KeyUtil.bgColorList[i];
    }

    return model;
  }
}
