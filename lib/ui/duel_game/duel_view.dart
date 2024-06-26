import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/ui/common/common_timer_progress.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../core/app_constants.dart';
import '../../data/models/quiz_model.dart';
import '../../utility/constants.dart';
import '../common/common_app_bar.dart';
import '../common/common_dual_button.dart';
import '../common/common_info_text_view.dart';
import '../common/dialog_listener.dart';
import '../model/gradient_model.dart';
import 'duel_game_provider.dart';

class DuelView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const DuelView({
    super.key,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    int crossAxisCount = 2;
    double height = getPercentSize(remainHeight, 45) / 3;

    double crossAxisSpacing = getPercentSize(height, 20);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    double aspectRatio = widthItem / height;

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<DuelGameProvider>(
            create: (context) => DuelGameProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<DuelGameProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.dualGame,
        level: colorTuple.item2,
        appBar: CommonAppBar<DuelGameProvider>(
            hint: false,
            infoView: CommonInfoTextView<DuelGameProvider>(
                gameCategoryType: GameCategoryType.dualGame,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.dualGame,
            colorTuple: colorTuple,
            context: context),
        child: getCommonWidget(
            context: context,
            bgColor: colorTuple.item1.bgColor,
            isTopMargin: false,
            child: Column(
              children: [
                // Player 1
                Expanded(
                  flex: 1,
                  child: Transform.rotate(
                    angle: math.pi,
                    child: Column(
                      children: <Widget>[
                        //Question title
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Selector<DuelGameProvider, QuizModel>(
                                    selector: (p0, p1) => p1.currentState,
                                    builder:
                                        (context, calculatorProvider, child) {
                                      return getTextWidget(
                                          Theme.of(context)
                                              .textTheme
                                              .titleSmall!,
                                          calculatorProvider.question!,
                                          TextAlign.center,
                                          getPercentSize(remainHeight, 4));
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Selector<DuelGameProvider, QuizModel>(
                            selector: (p0, p1) => p1.currentState,
                            builder: (context, currentState, child) {
                              final list = currentState.optionList;
                              return GridView.count(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: aspectRatio,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: getHorizontalSpace(context),
                                    vertical: getHorizontalSpace(context)),
                                crossAxisSpacing: crossAxisSpacing,
                                mainAxisSpacing: crossAxisSpacing,
                                primary: false,
                                children: List.generate(list.length, (index) {
                                  String e = list[index];
                                  return CommonDualButton(
                                    is4Matrix: true,
                                    text: e,
                                    totalHeight: remainHeight,
                                    height: height,
                                    onTab: () {
                                      context
                                          .read<DuelGameProvider>()
                                          .checkResult1(e);
                                      if (kDebugMode) {
                                        print(
                                            ("score1====${context.read<DuelGameProvider>().score1}"));
                                      }
                                    },
                                    colorTuple: colorTuple,
                                  );
                                }),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
                //just a divider with clock...
                CommonTimerProgress<DuelGameProvider>(
                  color: colorTuple.item1.primaryColor,
                ),
                // Player 2
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      // Question title
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Selector<DuelGameProvider, QuizModel>(
                                  selector: (p0, p1) => p1.currentState,
                                  builder:
                                      (context, calculatorProvider, child) {
                                    return getTextWidget(
                                        Theme.of(context).textTheme.titleSmall!,
                                        calculatorProvider.question!,
                                        TextAlign.center,
                                        getPercentSize(remainHeight, 4));
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Selector<DuelGameProvider, QuizModel>(
                          selector: (p0, p1) => p1.currentState,
                          builder: (context, currentState, child) {
                            final list = currentState.optionList;
                            return GridView.count(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: aspectRatio,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                  horizontal: getHorizontalSpace(context),
                                  vertical: getHorizontalSpace(context)),
                              crossAxisSpacing: crossAxisSpacing,
                              mainAxisSpacing: crossAxisSpacing,
                              primary: false,
                              children: List.generate(list.length, (index) {
                                String e = list[index];
                                return CommonDualButton(
                                  is4Matrix: true,
                                  text: e,
                                  totalHeight: remainHeight,
                                  height: height,
                                  onTab: () {
                                    context
                                        .read<DuelGameProvider>()
                                        .checkResult2(e);

                                    if (kDebugMode) {
                                      print(
                                          ("score2====${context.read<DuelGameProvider>().score2}"));
                                    }
                                  },
                                  colorTuple: colorTuple,
                                );
                              }),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
            subChild: Container()),
      ),
    );
  }
}
