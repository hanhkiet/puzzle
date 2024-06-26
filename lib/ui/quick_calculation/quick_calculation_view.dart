import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:puzzle/data/models/quick_calculation.dart';
import 'package:puzzle/ui/common/common_back_button.dart';
import 'package:puzzle/ui/common/common_clear_button.dart';
import 'package:puzzle/ui/common/common_neumorphic_view.dart';
import 'package:puzzle/ui/common/common_number_button.dart';
import 'package:puzzle/ui/common/common_app_bar.dart';
import 'package:puzzle/ui/common/common_info_text_view.dart';
import 'package:puzzle/ui/common/common_wrong_answer_animation_view.dart';
import 'package:puzzle/ui/common/dialog_listener.dart';
import 'package:puzzle/ui/quick_calculation/quick_calculation_question_view.dart';
import 'package:puzzle/ui/quick_calculation/quick_calculation_provider.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/constants.dart';
import '../common/common_main_widget.dart';
import '../model/gradient_model.dart';

class QuickCalculationView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  QuickCalculationView({
    super.key,
    required this.colorTuple,
  });

  final List list = [
    "7",
    "8",
    "9",
    "4",
    "5",
    "6",
    "1",
    "2",
    "3",
    "Clear",
    "0",
    "Back"
  ];

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    int crossAxisCount = 3;
    double height1 = getScreenPercentSize(context, 57);
    double height = getScreenPercentSize(context, 57) / 5.3;

    double crossAxisSpacing = getPercentSize(height, 30);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    double aspectRatio = widthItem / height;
    var margin = getHorizontalSpace(context);
    double mainHeight = getMainHeight(context);
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<QuickCalculationProvider>(
            create: (context) => QuickCalculationProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<QuickCalculationProvider>(
        colorTuple: colorTuple,
        appBar: CommonAppBar<QuickCalculationProvider>(
            infoView: CommonInfoTextView<QuickCalculationProvider>(
                gameCategoryType: GameCategoryType.quickCalculation,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.quickCalculation,
            colorTuple: colorTuple,
            context: context),
        gameCategoryType: GameCategoryType.quickCalculation,
        level: colorTuple.item2,
        child: CommonMainWidget<QuickCalculationProvider>(
          gameCategoryType: GameCategoryType.quickCalculation,
          color: colorTuple.item1.bgColor!,
          primaryColor: colorTuple.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: (getHorizontalSpace(context) * 2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: 0,
                              child: getTextWidget(
                                  Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.grey),
                                  "NEXT".tr(),
                                  TextAlign.center,
                                  getPercentSize(remainHeight, 1.8)),
                            ),
                            Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Selector<
                                        QuickCalculationProvider,
                                        Tuple3<
                                            QuickCalculation,
                                            QuickCalculation,
                                            QuickCalculation?>>(
                                      selector: (p0, p1) => Tuple3(
                                          p1.currentState,
                                          p1.nextCurrentState,
                                          p1.previousCurrentState),
                                      builder: (context, tuple3, child) {
                                        return QuickCalculationQuestionView(
                                          currentState: tuple3.item1,
                                          nextCurrentState: tuple3.item2,
                                          previousCurrentState: tuple3.item3,
                                        );
                                      },
                                    ),
                                    getTextWidget(
                                        Theme.of(context).textTheme.titleSmall!,
                                        " = ",
                                        TextAlign.center,
                                        getPercentSize(remainHeight, 4)),
                                    SizedBox(
                                      width: getWidthPercentSize(context, 3),
                                    ),
                                    Selector<QuickCalculationProvider,
                                        Tuple2<double, double>>(
                                      selector: (p0, p1) =>
                                          Tuple2(p1.currentScore, p1.oldScore),
                                      builder: (context, tuple2, child) {
                                        return CommonWrongAnswerAnimationView(
                                          currentScore: tuple2.item1.toInt(),
                                          oldScore: tuple2.item2.toInt(),
                                          child: child!,
                                        );
                                      },
                                      child: CommonNeumorphicView(
                                        isMargin: true,
                                        color: getBackGroundColor(context),
                                        // width: getWidthPercentSize(context, 13),
                                        // height: getWidthPercentSize(context, 13),
                                        height: getPercentSize(mainHeight, 22),
                                        width: getPercentSize(mainHeight, 22),
                                        child: Selector<
                                                QuickCalculationProvider,
                                                String>(
                                            selector: (p0, p1) => p1.result,
                                            builder: (context, result, child) {
                                              return getTextWidget(
                                                  Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!,
                                                  result.isNotEmpty
                                                      ? result
                                                      : "?",
                                                  TextAlign.center,
                                                  getPercentSize(
                                                      remainHeight, 4));
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: height1,
                      decoration: getCommonDecoration(context),
                      alignment: Alignment.bottomCenter,
                      child: Builder(builder: (context) {
                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: aspectRatio,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            right: (margin * 2),
                            left: (margin * 2),
                            bottom: getHorizontalSpace(context),
                          ),
                          crossAxisSpacing: crossAxisSpacing,
                          mainAxisSpacing: crossAxisSpacing,
                          primary: false,
                          // padding: EdgeInsets.only(top: getScreenPercentSize(context, 4)),
                          children: List.generate(list.length, (index) {
                            String e = list[index];
                            if (e == "Clear") {
                              return CommonClearButton(
                                  text: "Clear".tr(),
                                  height: height,
                                  onTab: () {
                                    context
                                        .read<QuickCalculationProvider>()
                                        .clearResult();
                                  });
                            } else if (e == "Back") {
                              return CommonBackButton(
                                onTab: () {
                                  context
                                      .read<QuickCalculationProvider>()
                                      .backPress();
                                },
                                height: height,
                              );
                            } else {
                              return CommonNumberButton(
                                text: e,
                                totalHeight: remainHeight,
                                height: height,
                                onTab: () {
                                  context
                                      .read<QuickCalculationProvider>()
                                      .checkResult(e);
                                },
                                colorTuple: colorTuple,
                              );
                            }
                          }),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          context: context,
          isTopMargin: false,
        ),
      ),
    );
  }
}
