import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import 'package:puzzle/ads/ads_file.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';

import '../../data/models/dashboard.dart';
import '../../data/models/game_category.dart';
import '../../utility/constants.dart';
import '../app/theme_provider.dart';
import '../dashboard/dashboard_provider.dart';
import '../model/gradient_model.dart';
import 'home_button_view.dart';

class HomeView extends StatefulWidget {
  final Tuple2<Dashboard, double> tuple2;

  const HomeView({
    super.key,
    required this.tuple2,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> leftHomeItemSlidePositionTween;
  late Animation<Offset> rightHomeItemSlidePositionTween;
  late bool isGamePageOpen;
  Tuple2<Dashboard, double>? tuple2;
  AdsFile? adsFile;

  @override
  void initState() {
    /*Future.delayed(Duration.zero, () {
      adsFile = AdsFile(context);
      adsFile!.createAnchoredBanner(context, setState);
    });*/
    tuple2 = widget.tuple2;
    isGamePageOpen = false;
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    leftHomeItemSlidePositionTween =
        Tween<Offset>(begin: const Offset(-2, 0), end: Offset.zero)
            .animate(animationController);
    rightHomeItemSlidePositionTween =
        Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeBannerAd(adsFile);
  }

  @override
  Widget build(BuildContext context) {
    double margin = getHorizontalSpace(context);

    setStatusBarColor(Theme.of(context).scaffoldBackgroundColor);
    ThemeProvider themeProvider = Provider.of(context);
    DashboardProvider dashboardProvider = Provider.of(context);

    int crossAxisCount = 2;
    double height = getScreenPercentSize(context, 30);

    double crossAxisSpacing = getPercentSize(height, 10);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    double aspectRatio = widthItem / height;

    return Scaffold(
      appBar: getNoneAppBar(context),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getScreenPercentSize(context, 2),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      getDefaultIconWidget(context,
                          icon: AppAssets.backIcon,
                          folder: tuple2!.item1.folder, function: () {
                        if (kIsWeb) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pop();
                          });
                        } else {
                          Navigator.of(context).pop();
                        }
                      }),
                      Expanded(
                        child: getScoreWidget(context, isCenter: true),
                        flex: 1,
                      ),
                      getSettingWidget(context, function: () {
                        if (kDebugMode) {
                          print("model====$themeMode");
                        }
                        setState(() {
                          if (themeMode == ThemeMode.dark) {
                            tuple2!.item1.bgColor = "#383838".toColor();
                          } else {
                            tuple2!.item1.bgColor =
                                KeyUtil.bgColorList[tuple2!.item1.position];
                          }

                          if (kDebugMode) {
                            print("color====${tuple2!.item1.position}");
                          }
                        });
                      })
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: ListView(
                        padding: EdgeInsets.only(
                            bottom: getHorizontalSpace(context)),
                        children: [
                          getHeaderWidget(context, tuple2!.item1.title,
                              tuple2!.item1.subtitle),
                          SizedBox(
                            height: getVerticalSpace(context),
                          ),
                          GridView.count(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: aspectRatio,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisSpacing: crossAxisSpacing,
                              mainAxisSpacing: crossAxisSpacing,
                              primary: false,
                              padding: EdgeInsets.only(
                                  top: getScreenPercentSize(context, 4)),
                              children: Provider.of<DashboardProvider>(context)
                                  .getGameByPuzzleType(tuple2!.item1.puzzleType)
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => SlideTransition(
                                      position: e.key % 2 == 0
                                          ? leftHomeItemSlidePositionTween
                                          : rightHomeItemSlidePositionTween,
                                      child: HomeButtonView(
                                          title: e.value.name,
                                          icon: e.value.icon,
                                          tuple2: tuple2!,
                                          score:
                                              e.value.scoreboard.highestScore,
                                          colorTuple: tuple2!.item1.colorTuple,
                                          opacity: tuple2!.item1.opacity,
                                          gameCategoryType:
                                              e.value.gameCategoryType,
                                          onTab: () {
                                            if (e.value.gameCategoryType ==
                                                GameCategoryType.dualGame) {
                                              showDuelDialog(
                                                  themeProvider, context);
                                            } else {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                KeyUtil.level,
                                                ModalRoute.withName(
                                                    KeyUtil.home),
                                                arguments: Tuple2<GameCategory,
                                                        Dashboard>(
                                                    e.value, tuple2!.item1),
                                              ).then((value) {
                                                dashboardProvider.getCoin();
                                              });
                                            }
                                          }),
                                    ),
                                  )
                                  .toList()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          getBanner(context, adsFile)
        ],
      ),
    );
  }

  showDuelDialog(ThemeProvider themeProvider, BuildContext context) {
    double margin = getScreenPercentSize(context, 1.5);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Wrap(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: margin,
                      ),
                      getTextWidget(
                          Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                          "Select Difficulty".tr(),
                          TextAlign.center,
                          getScreenPercentSize(context, 2)),
                      Container(
                        height: 1,
                        color: Theme.of(context).textTheme.titleMedium!.color,
                        margin: EdgeInsets.symmetric(
                            vertical: margin, horizontal: 5),
                      ),
                      getCell('Easy'.tr(), true, easyQuiz, themeProvider),
                      getCell('Medium'.tr(), false, mediumQuiz, themeProvider),
                      getCell('Hard'.tr(), false, hardQuiz, themeProvider),
                      SizedBox(
                        height: margin,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  getCell(String s, bool isSelect, int type, ThemeProvider themeProvider) {
    double cellHeight = getScreenPercentSize(context, 10);
    return InkWell(
      child: Container(
        width: getWidthPercentSize(context, 60),
        height: cellHeight,
        margin: const EdgeInsets.all(5),
        child: Stack(
          children: [
            SizedBox(
              height: cellHeight,
              width: double.infinity,
              child: SvgPicture.asset(
                '${getFolderName(context, tuple2!.item1.folder)}${AppAssets.subCellBg}',
                height: cellHeight,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getWidthPercentSize(context, 5)),
                child: getTextWidget(
                    Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                    s,
                    TextAlign.center,
                    getPercentSize(cellHeight, 25)),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        GradientModel model = GradientModel();
        model.primaryColor = tuple2!.item1.primaryColor;
        model.gridColor = tuple2!.item1.gridColor;

        model.cellColor = getBgColor(themeProvider, tuple2!.item1.bgColor);
        model.folderName = tuple2!.item1.folder;

        model.bgColor = tuple2!.item1.bgColor;
        model.backgroundColor = tuple2!.item1.backgroundColor;
        Navigator.pushNamed(
          context,
          KeyUtil.dualGame,
          arguments: Tuple2(model, type),
        ).then((value) {
          isGamePageOpen = false;
        });
      },
    );
  }
}
