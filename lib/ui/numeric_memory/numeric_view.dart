import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/numeric_memory_pair.dart';
import 'package:puzzle/ui/common/common_app_bar.dart';
import 'package:puzzle/ui/common/common_info_text_view.dart';
import 'package:puzzle/ui/common/dialog_listener.dart';
import 'package:puzzle/ui/model/gradient_model.dart';
import 'package:puzzle/ui/numeric_memory/numeric_button.dart';
import 'package:puzzle/utility/math_util.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/constants.dart';
import '../common/common_main_widget.dart';
import 'numeric_provider.dart';

class NumericMemoryView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const NumericMemoryView({
    super.key,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = true;
    //prevent user click --> isContinue = false;
    bool isContinue = false;
    double remainHeight = getRemainHeight(context: context);
    int crossAxisCount = 3;
    double height1 = getScreenPercentSize(context, 57);
    double height = getPercentSize(remainHeight, 70) / 5;

    double crossAxisSpacing = getPercentSize(height, 14);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    double aspectRatio = widthItem / height;

    double mainHeight = getMainHeight(context);

    return StatefulBuilder(builder: (context, snapshot) {
      if (isFirstTime) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            snapshot(() {
              isContinue = true;
              isFirstTime = false;
            });
          },
        );
      }
      return MultiProvider(
        providers: [
          const VsyncProvider(),
          ChangeNotifierProvider<NumericMemoryProvider>(
              create: (context) => NumericMemoryProvider(
                  vsync: VsyncProvider.of(context),
                  level: colorTuple.item2,
                  nextQuiz: () {
                    snapshot(() {
                      isContinue = false;
                    });
                    if (kDebugMode) {
                      print("isContinue====$isContinue");
                    }
                    Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        snapshot(() {
                          isContinue = true;
                        });
                      },
                    );
                  },
                  context: context))
        ],
        child: DialogListener<NumericMemoryProvider>(
          colorTuple: colorTuple,
          gameCategoryType: GameCategoryType.numericMemory,
          level: colorTuple.item2,
          nextQuiz: () {
            if (kDebugMode) {
              print("isNewData===true");
            }
            // Open answers
            snapshot(() {
              isContinue = false;
            });
            //await 2 seconds and close answers
            Future.delayed(
              const Duration(seconds: 2),
              () {
                snapshot(() {
                  isContinue = true;
                });
              },
            );
          },
          appBar: CommonAppBar<NumericMemoryProvider>(
            hint: false,
            infoView: CommonInfoTextView<NumericMemoryProvider>(
                gameCategoryType: GameCategoryType.numericMemory,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.numericMemory,
            colorTuple: colorTuple,
            context: context,
          ),
          child: CommonMainWidget<NumericMemoryProvider>(
            gameCategoryType: GameCategoryType.numericMemory,
            color: colorTuple.item1.bgColor!,
            primaryColor: colorTuple.item1.primaryColor!,
            subChild: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              // color: Colors.red,
                              margin: EdgeInsets.only(
                                  bottom: getPercentSize(mainHeight, 10)),

                              child: Selector<NumericMemoryProvider,
                                      NumericMemoryPair>(
                                  selector: (p0, p1) => p1.currentState,
                                  builder: (context, currentState, child) {
                                    return Center(
                                      child: getTextWidget(
                                          Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                          currentState.question.toString(),
                                          TextAlign.center,
                                          getPercentSize(remainHeight, 5)),
                                    );
                                  }),
                            ),
                          ),
                          Container(
                            height: height1,
                            decoration: getCommonDecoration(context),
                            alignment: Alignment.bottomCenter,
                            child: Consumer<NumericMemoryProvider>(
                                builder: (context, provider, child) {
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
                                children: List.generate(
                                    provider.currentState.list.length, (index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            getHorizontalSpace(context) / 1.5,
                                        vertical:
                                            getHorizontalSpace(context) / 1.5),
                                    child: NumericMemoryButton(
                                      height: height,
                                      mathPairs: provider.currentState,
                                      index: index,
                                      function: () {
                                        if (MathUtil.evaluateExpression(
                                            provider
                                                .currentState.list[index].key,
                                            provider.currentState.question)) {
                                          provider.currentState.list[index]
                                              .isCheck = true;
                                        } else {
                                          provider.currentState.list[index]
                                              .isCheck = false;
                                        }
                                        setState(() {
                                          isContinue = false;
                                        });
                                        context
                                            .read<NumericMemoryProvider>()
                                            .checkResult(
                                                provider.currentState
                                                    .list[index].key!,
                                                index);
                                      },
                                      isContinue: isContinue,
                                      colorTuple: Tuple2(
                                          colorTuple.item1.primaryColor!,
                                          colorTuple.item1.backgroundColor!),
                                    ),
                                  );
                                }),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            context: context,
            isTopMargin: false,
          ),
        ),
      );
    });
  }
}
