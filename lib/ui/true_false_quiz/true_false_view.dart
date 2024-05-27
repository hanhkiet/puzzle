import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/ui/common/common_app_bar.dart';
import 'package:puzzle/ui/common/common_info_text_view.dart';
import 'package:puzzle/ui/common/dialog_listener.dart';
import 'package:puzzle/ui/model/gradient_model.dart';
import 'package:puzzle/ui/true_false_quiz/true_false_provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../data/models/true_false_model.dart';
import '../../data/random_option_data.dart';
import '../../utility/Constants.dart';
import '../common/common_button.dart';
import '../common/common_main_widget.dart';

class TrueFalseView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const TrueFalseView({
    super.key,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<TrueFalseProvider>(
            create: (context) => TrueFalseProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<TrueFalseProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.trueFalse,
        level: colorTuple.item2,
        appBar: CommonAppBar<TrueFalseProvider>(
            infoView: CommonInfoTextView<TrueFalseProvider>(
                gameCategoryType: GameCategoryType.trueFalse,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.trueFalse,
            colorTuple: colorTuple,
            context: context),
        child: CommonMainWidget<TrueFalseProvider>(
          gameCategoryType: GameCategoryType.trueFalse,
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
                      child: Center(
                        child: Selector<TrueFalseProvider, TrueFalseModel>(
                            selector: (p0, p1) => p1.currentState,
                            builder: (context, calculatorProvider, child) {
                              return getTextWidget(
                                  Theme.of(context).textTheme.titleSmall!,
                                  calculatorProvider.question!,
                                  TextAlign.center,
                                  getPercentSize(remainHeight, 4));
                            }),
                      ),
                    ),
                    Container(
                      height: height1,
                      decoration: getCommonDecoration(context),
                      alignment: Alignment.bottomCenter,
                      child: Builder(builder: (context) {
                        return Selector<TrueFalseProvider, TrueFalseModel>(
                            selector: (p0, p1) => p1.currentState,
                            builder: (context, currentState, child) {
                              print("valueG===true");

                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: getPercentSize(height1, 10)),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: List.generate(2, (index) {
                                          String e = strFalse;

                                          Color color = Colors.red;

                                          if (index == 0) {
                                            color = Colors.green;
                                            e = strTrue;
                                          }
                                          return CommonButton(
                                            text: e,
                                            color: color,
                                            onTab: () {
                                              context
                                                  .read<TrueFalseProvider>()
                                                  .checkResult(e);
                                            },
                                          );
                                        }),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                  ],
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
