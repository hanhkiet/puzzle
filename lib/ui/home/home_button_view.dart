import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../core/app_constants.dart';
import '../../data/models/dashboard.dart';
import '../../utility/Constants.dart';
import '../app/theme_provider.dart';
import '../common/common_tab_animation_view.dart';
import '../dashboard/dashboard_provider.dart';

class HomeButtonView extends StatelessWidget {
  final Function onTab;
  final String title;
  final String icon;
  final int score;
  final GameCategoryType? gameCategoryType;
  final Tuple2<Color, Color> colorTuple;
  final double opacity;
  final Tuple2<Dashboard, double> tuple2;



  const HomeButtonView({
    super.key,
    required this.title,
    required this.tuple2,
    required this.icon,
    required this.score,
    required this.colorTuple,
    required this.onTab,
    required this.opacity,
    this.gameCategoryType,
  });

  @override
  Widget build(BuildContext context) {
    double height = getScreenPercentSize(context, 30);
    double iconHeight = getPercentSize(height, 24);
    double remainHeight = height - (getPercentSize(height, 17) * 2);

    return CommonTabAnimationView(
      onTab: onTab,
      isDelayed: true,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return Stack(

            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: getDefaultDecoration(
                    bgColor: tuple2.item1.bgColor,
                    radius: getPercentSize(height, 8)),
                margin: EdgeInsets.only(top: getPercentSize(height, 12)),
                padding: EdgeInsets.only(
                    top: getPercentSize(height, 20),
                    bottom: getPercentSize(height, 6)),
                child: Column(
                  children: [
                    getTextWidget(
                        Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                        title,
                        TextAlign.center,
                        getPercentSize(remainHeight, 11)),
                    Opacity(
                      opacity: (gameCategoryType == GameCategoryType.dualGame)
                          ? 0
                          : 1,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                getPercentSize(remainHeight, 95))),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3))
                            ]),
                        margin: EdgeInsets.symmetric(
                            vertical: getPercentSize(remainHeight, 12),
                            horizontal: getWidthPercentSize(context, 13)),
                        padding: EdgeInsets.symmetric(
                            vertical: getPercentSize(remainHeight, 4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                AppAssets.icTrophy,
                                width: getPercentSize(height, 8),
                                height: getPercentSize(height, 8),
                              ),
                            ),
                            SizedBox(
                              width: getWidthPercentSize(context, 1.5),
                            ),
                            Consumer<DashboardProvider>(
                                builder: (context, model, child) =>
                                    AutoSizeText(
                                      score.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: getPercentSize(
                                                  remainHeight, 10),
                                              fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                    )
                                ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      decoration: getDefaultDecoration(
                          bgColor: tuple2.item1.primaryColor,
                          radius: getPercentSize(height, 4)),
                      margin: EdgeInsets.symmetric(
                        horizontal: getWidthPercentSize(context, 5),
                      ),
                      child: Center(
                        child: getTextWidget(
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            'Play',
                            TextAlign.center,
                            getPercentSize(remainHeight, 9)),
                      ),
                    ))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  icon,
                  height: iconHeight,
                ),
              ),
            ],
          );

        },
      ),
    );
  }
}
