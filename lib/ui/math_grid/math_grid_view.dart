import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../core/app_constants.dart';
import '../../utility/constants.dart';
import '../common/common_app_bar.dart';
import '../common/common_info_text_view.dart';
import '../common/common_main_widget.dart';
import '../common/dialog_listener.dart';
import '../model/gradient_model.dart';
import 'math_grid_button.dart';
import 'math_grid_provider.dart';

class MathGridView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const MathGridView({
    super.key,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);

    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = screenWidth / 9;

    if (kDebugMode) {
      print("screenSize ====$screenWidth-----$screenHeight");
    }
    if (screenHeight < screenWidth) {
      width = getScreenPercentSize(context, 3);
      if (kDebugMode) {
        print("width ====$width");
      }
    }

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<MathGridProvider>(
            create: (context) => MathGridProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<MathGridProvider>(
        colorTuple: colorTuple,
        appBar: CommonAppBar<MathGridProvider>(
            infoView: CommonInfoTextView<MathGridProvider>(
                gameCategoryType: GameCategoryType.mathGrid,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            hint: false,
            gameCategoryType: GameCategoryType.mathGrid,
            colorTuple: colorTuple,
            context: context),
        gameCategoryType: GameCategoryType.mathGrid,
        level: colorTuple.item2,
        child: CommonMainWidget<MathGridProvider>(
          gameCategoryType: GameCategoryType.mathGrid,
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
                        margin: EdgeInsets.only(
                            bottom: getPercentSize(mainHeight, 9)),
                        child: Center(
                          child: Selector<MathGridProvider, int>(
                              selector: (p0, p1) =>
                                  p1.currentState.currentAnswer,
                              builder: (context, currentAnswer, child) {
                                return getTextWidget(
                                    Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    currentAnswer.toString(),
                                    TextAlign.center,
                                    getPercentSize(remainHeight, 4));
                              }),
                        ),
                      ),
                    ),
                    Container(
                      height: height1,
                      decoration: getCommonDecoration(context),
                      alignment: Alignment.bottomCenter,
                      child: Consumer<MathGridProvider>(
                          builder: (context, listForSquare, child) {
                        return Container(
                          decoration: getDefaultDecoration(
                              bgColor: colorTuple.item1.gridColor,
                              borderColor:
                                  Theme.of(context).textTheme.titleSmall!.color,
                              radius: getCommonRadius(context)),
                          margin: EdgeInsets.all(getHorizontalSpace(context)),
                          child: GridView.builder(
                              padding: EdgeInsets.all(
                                  getScreenPercentSize(context, 0.7)),
                              gridDelegate: (screenHeight < screenWidth)
                                  ? SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 9,
                                      childAspectRatio:
                                          getScreenPercentSize(context, 0.3),
                                    )
                                  : const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 9,
                                    ),
                              itemCount: listForSquare
                                  .currentState.listForSquare.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return MathGridButton(
                                  gridModel: listForSquare
                                      .currentState.listForSquare[index],
                                  index: index,
                                  colorTuple: Tuple2(
                                      colorTuple.item1.primaryColor!,
                                      colorTuple.item1.backgroundColor!),
                                );
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
