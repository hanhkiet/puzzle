import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/core/color_scheme.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';

import '../../core/app_constants.dart';
import '../../utility/constants.dart';
import '../app/theme_provider.dart';
import '../model/gradient_model.dart';
import '../resizer/fetch_pixels.dart';

class CommonScoreWidget extends StatelessWidget {
  final BuildContext? context;
  final GameCategoryType? gameCategoryType;
  final int totalLevel;
  final int currentLevel;
  final int score;
  final int right;
  final int wrong;
  final int totalQuestion;
  final Function function;
  final Function homeClick;
  final Function closeClick;
  final Function shareClick;
  final Function restartClick;
  final Function nextClick;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonScoreWidget({
    super.key,
    required this.context,
    required this.shareClick,
    required this.restartClick,
    required this.closeClick,
    required this.nextClick,
    required this.homeClick,
    required this.currentLevel,
    required this.totalLevel,
    required this.colorTuple,
    required this.totalQuestion,
    required this.score,
    required this.wrong,
    required this.right,
    required this.gameCategoryType,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    //AdsFile? adsFile = AdsFile(context);
    //adsFile.createInterstitialAd();

    double appBarHeight = getScreenPercentSize(context, 25);
    double mainHeight = getScreenPercentSize(context, 30);
    // double mainHeight = getMainHeight(context);
    var radius = getScreenPercentSize(context, 2.5);
    var circle = getScreenPercentSize(context, 12);
    var circle1 = getScreenPercentSize(context, 9.4);
    var stepSize = getScreenPercentSize(context, 1.3);

    double scoreHeight = getPercentSize(mainHeight, 55);
    ThemeProvider themeProvider = Provider.of(context);

    double starSize = getWidthPercentSize(context, 10);

    double percentage = (score * 100) / 20;
    int star = 0;

    if (percentage < 35 && percentage > 10) {
      star = 1;
    } else if (percentage >= 35 && percentage < 75) {
      star = 2;
    } else if (percentage >= 75) {
      star = 3;
    }

    if (kDebugMode) {
      print("percentage===$percentage");
    }
    if (score <= 0) {
      star = 0;
      percentage = 0;
    }

    // bool isDetailView = isDetailWidget(gameCategoryType!);

    return Container(
      width: double.infinity,
      color: Colors.transparent,

      // color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          children: [
            Container(
              color: Colors.transparent,
              height: mainHeight,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                primary: false,
                appBar: AppBar(
                  bottomOpacity: 0.0,
                  title: const Text(''),
                  toolbarHeight: 0,
                  elevation: 0,
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: SizedBox(
                  width: (circle),
                  height: (circle),
                  child: Stack(
                    children: [
                      CircularStepProgressIndicator(
                        totalSteps: totalLevel,
                        currentStep: currentLevel,
                        stepSize: stepSize,
                        selectedColor: colorTuple.item1.primaryColor,
                        unselectedColor: Theme.of(context)
                            .colorScheme
                            .unSelectedProgressColor,
                        padding: 0,
                        width: circle,
                        height: circle,
                        selectedStepSize: stepSize,
                        roundedCap: (_, __) => true,
                      ),
                      Center(
                        child: Container(
                          width: circle1,
                          height: circle1,
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              shape: BoxShape.circle),
                          child: Center(
                            child: getTextWidget(
                                Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                                '$currentLevel/$totalLevel\n${"level".tr()}',
                                TextAlign.center,
                                getPercentSize(circle, 15)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                  child: SizedBox(
                    height: (appBarHeight),
                    child: BottomAppBar(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      elevation: 0,
                      shape: const CircularNotchedRectangle(),
                      notchMargin: (10),
                      child: Container(
                        padding: EdgeInsets.all(
                            FetchPixels.getDefaultHorSpace(context)),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: getDefaultIconWidget(context,
                              icon: AppAssets.closeIcon,
                              folder: colorTuple.item1.folderName,
                              function: () {
                            closeClick();
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              // height: FetchPixels.getPixelHeight(600),
              //   // height: scoreHeight,
              //   padding:
              //   EdgeInsets.only(top: getPercentSize(mainHeight, 52)),
              margin: EdgeInsets.only(top: getPercentSize(mainHeight, 60)),
              // padding: EdgeInsets.all(
              //     getPercentSize(scoreHeight, 10)),
              decoration: getDecorationWithSide(
                  radius: radius,
                  bgColor: Theme.of(context).scaffoldBackgroundColor,
                  isBottomLeft: true,
                  isBottomRight: true),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(height: getScreenPercentSize(context, 2)),

                  Center(
                    child: getTextWidget(
                        Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                        "Game Over!!!".tr(),
                        TextAlign.center,
                        getScreenPercentSize(context, 3.5)),
                  ),
                  SizedBox(height: getScreenPercentSize(context, 5)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getTextWidget(
                          Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                          score.toString(),
                          TextAlign.center,
                          getPercentSize(scoreHeight, 30)),
                      SizedBox(
                        width: getWidthPercentSize(context, 1.2),
                      ),
                      SvgPicture.asset(
                        AppAssets.icTrophy,
                        height: getPercentSize(scoreHeight, 23),
                        width: getPercentSize(scoreHeight, 18),
                      ),
                    ],
                  ),
                  // SizedBox(height: getPercentSize(scoreHeight, 8)),
                  getTextWidget(
                      Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.grey),
                      'Your Score'.tr(),
                      TextAlign.center,
                      getPercentSize(scoreHeight, 12)),

                  SizedBox(height: getScreenPercentSize(context, 5)),
                  // Visibility(child: SizedBox(height: getScreenPercentSize(context, 4),),visible: !isDetailView),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getStarWidget(star, starSize, 0),
                      SizedBox(width: getWidthPercentSize(context, 5)),
                      getStarWidget(star, starSize, 1),
                      SizedBox(width: getWidthPercentSize(context, 5)),
                      getStarWidget(star, starSize, 2),
                    ],
                  ),
                  // new Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getHomeButton(themeProvider, context,
                          '${getFolderName(context, colorTuple.item1.folderName!)}${AppAssets.restartIcon}',
                          () {
                        restartClick();
                      }, isFolder: true),
                      getHomeButton(
                          themeProvider, context, AppAssets.scoreShareIcon, () {
                        shareClick();
                      }),
                      getHomeButton(themeProvider, context,
                          '${getFolderName(context, colorTuple.item1.folderName!)}${AppAssets.scoreHomeIcon}',
                          () {
                        homeClick();
                      }, isFolder: true),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getHomeButton(ThemeProvider themeProvider, BuildContext context, String icon,
      Function function,
      {bool? isFolder}) {
    double size = getScreenPercentSize(context, 6.8);
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        height: size,
        width: size,
        margin: EdgeInsets.symmetric(
            vertical: getScreenPercentSize(context, 4),
            horizontal: getWidthPercentSize(context, 2.5)),
        decoration: BoxDecoration(
            color: themeMode == ThemeMode.dark
                ? colorTuple.item1.bgColor!
                : getBgColor(themeProvider, colorTuple.item1.bgColor!),
            shape: BoxShape.circle),
        child: Center(
          child: isFolder == null
              ? SvgPicture.asset(
                  icon,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.titleSmall!.color!,
                      BlendMode.srcIn),
                  height: getPercentSize(size, 52),
                )
              : SvgPicture.asset(
                  icon,
                  height: getPercentSize(size, 52),
                ),
        ),
      ),
    );
  }

  getStarWidget(int star, double starSize, int count) {
    return Image.asset(
      (star > count) ? AppAssets.fillStartIcon : AppAssets.startIcon,
      width: starSize,
      height: starSize,
    );
  }

  getDetail(BuildContext context, String s, String icon, double btnHeight) {
    return getCommonDetailWidget(
        context: context,
        data: s,
        icon: icon,
        isCenter: true,
        iconSize: getPercentSize(btnHeight, 47),
        fontSize: getPercentSize(btnHeight, 35),
        horizontalSpace: getWidthPercentSize(context, 3),
        mainHeight: btnHeight);
  }
}
