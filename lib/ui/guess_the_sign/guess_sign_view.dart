import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../core/app_constants.dart';
import '../../data/models/sign.dart';
import '../../data/random_find_missing_data.dart';
import '../../utility/constants.dart';
import '../common/common_app_bar.dart';
import '../common/common_info_text_view.dart';
import '../common/common_main_widget.dart';
import '../common/common_neumorphic_view.dart';
import '../common/common_vertical_button.dart';
import '../common/common_wrong_answer_animation_view.dart';
import '../common/dialog_listener.dart';
import '../model/gradient_model.dart';
import 'guess_sign_provider.dart';

class GuessSignView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  GuessSignView({
    super.key,
    required this.colorTuple,
  });

  final List<String> list = [
    "/",
    "*",
    "+",
    "-",
  ];

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);

    shuffle(list);

    if (kDebugMode) {
      print("value===1");
    }
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<GuessSignProvider>(
            create: (context) => GuessSignProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<GuessSignProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.guessSign,
        level: colorTuple.item2,
        appBar: CommonAppBar<GuessSignProvider>(
            infoView: CommonInfoTextView<GuessSignProvider>(
                gameCategoryType: GameCategoryType.guessSign,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.guessSign,
            colorTuple: colorTuple,
            context: context),
        child: CommonMainWidget<GuessSignProvider>(
          gameCategoryType: GameCategoryType.guessSign,
          color: colorTuple.item1.bgColor!,
          primaryColor: colorTuple.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 50)),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Selector<GuessSignProvider, Sign>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, provider, child) {
                                return getTextWidget(
                                    Theme.of(context).textTheme.titleSmall!,
                                    provider.firstDigit,
                                    TextAlign.center,
                                    getPercentSize(remainHeight, 4));
                              }),
                          SizedBox(width: getWidthPercentSize(context, 2)),
                          Selector<GuessSignProvider, Tuple2<double, double>>(
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
                              color: getBackGroundColor(context),
                              isMargin: true,
                              width: getWidthPercentSize(context, 15),
                              height: getWidthPercentSize(context, 15),
                              child: Selector<GuessSignProvider, String>(
                                selector: (p0, p1) => p1.result,
                                builder: (context, result, child) {
                                  return getTextWidget(
                                      Theme.of(context).textTheme.titleSmall!,
                                      (result.isNotEmpty) ? result : "?",
                                      TextAlign.center,
                                      getPercentSize(remainHeight, 4));
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: getWidthPercentSize(context, 2)),
                          Selector<GuessSignProvider, Sign>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, provider, child) {
                                return getTextWidget(
                                    Theme.of(context).textTheme.titleSmall!,
                                    provider.secondDigit,
                                    TextAlign.center,
                                    getPercentSize(remainHeight, 4));
                              }),
                          SizedBox(width: getWidthPercentSize(context, 2)),
                          getTextWidget(
                              Theme.of(context).textTheme.titleSmall!,
                              '=',
                              TextAlign.center,
                              getPercentSize(remainHeight, 4)),
                          SizedBox(width: getWidthPercentSize(context, 2)),
                          Selector<GuessSignProvider, Sign>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, provider, child) {
                                if (kDebugMode) {
                                  print("valueG===true");
                                }

                                return getTextWidget(
                                    Theme.of(context).textTheme.titleSmall!,
                                    provider.answer,
                                    TextAlign.center,
                                    getPercentSize(remainHeight, 4));
                              }),
                        ],
                      ),
                    ),
                    Container(
                      height: height1,
                      decoration: getCommonDecoration(context),
                      alignment: Alignment.bottomCenter,
                      child: Builder(builder: (context) {
                        return Selector<GuessSignProvider, Sign>(
                            selector: (p0, p1) => p1.currentState,
                            builder: (context, provider, child) {
                              if (kDebugMode) {
                                print("valueG===true");
                              }

                              shuffle(list);

                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: getPercentSize(height1, 10)),
                                child: Column(
                                  children: List.generate(list.length, (index) {
                                    String e = list[index];
                                    return CommonVerticalButton(
                                        text: e,
                                        onTab: () {
                                          context
                                              .read<GuessSignProvider>()
                                              .checkResult(e);
                                        },
                                        colorTuple: colorTuple);
                                  }),
                                ),
                              );
                            });
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
