import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/ui/common/common_app_bar.dart';
import 'package:puzzle/ui/common/common_back_button.dart';
import 'package:puzzle/ui/common/common_clear_button.dart';
import 'package:puzzle/ui/common/common_info_text_view.dart';
import 'package:puzzle/ui/common/dialog_listener.dart';
import 'package:puzzle/ui/model/gradient_model.dart';
import 'package:puzzle/ui/number_pyramid/number_pyramid_provider.dart';
import 'package:puzzle/utility/constants.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../common/common_main_widget.dart';
import '../common/common_number_button.dart';
import 'number_pyramid_button.dart';

class NumberPyramidView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple1;

  NumberPyramidView({
    super.key,
    required this.colorTuple1,
  });

  final List<String> list = [
    "7",
    "8",
    "9",
    "4",
    "5",
    "6",
    "1",
    "2",
    "3",
    "Done",
    "0",
    "Back"
  ];

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    int crossAxisCount = 3;

    double height1 = getScreenPercentSize(context, 42);
    double height = height1 / 4.5;
    double radius = getPercentSize(height, 35);

    double crossAxisSpacing = getPercentSize(height, 20);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    double aspectRatio = widthItem / height;
    var margin = getHorizontalSpace(context);

    double mainHeight = getMainHeight(context);

    Tuple2<Color, Color> colorTuple = Tuple2(
        colorTuple1.item1.primaryColor!, colorTuple1.item1.primaryColor!);

    double space = 0.8;
    double verticalSpace = 0.6;

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<NumberPyramidProvider>(
            create: (context) => NumberPyramidProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple1.item2,
                context: context))
      ],
      child: DialogListener<NumberPyramidProvider>(
        colorTuple: colorTuple1,
        gameCategoryType: GameCategoryType.numberPyramid,
        level: colorTuple1.item2,
        appBar: CommonAppBar<NumberPyramidProvider>(
            hint: false,
            infoView: CommonInfoTextView<NumberPyramidProvider>(
                gameCategoryType: GameCategoryType.numberPyramid,
                folder: colorTuple1.item1.folderName!,
                color: colorTuple1.item1.cellColor!),
            gameCategoryType: GameCategoryType.numberPyramid,
            colorTuple: colorTuple1,
            context: context),
        child: CommonMainWidget<NumberPyramidProvider>(
          gameCategoryType: GameCategoryType.numberPyramid,
          color: colorTuple1.item1.bgColor!,
          primaryColor: colorTuple1.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 40)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: getPercentSize(remainHeight, 6),
                ),
                Expanded(
                  flex: 1,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Center(
                      child: Consumer<NumberPyramidProvider>(
                          builder: (context, numberPyramidProvider, child) {
                        if (kDebugMode) {
                          print(
                              "value---${numberPyramidProvider.currentState.list[10]}");
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: PyramidNumberButton(
                                numPyramidCellModel:
                                    numberPyramidProvider.currentState.list[27],
                                isLeftRadius: true,
                                isRightRadius: true,
                                height: constraints.maxWidth,
                                buttonHeight: remainHeight,
                                colorTuple: colorTuple,
                              ),
                            ),
                            SizedBox(
                              height: verticalSpace,
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[26],
                                    isLeftRadius: true,
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[25],
                                    buttonHeight: remainHeight,
                                    isRightRadius: true,
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: verticalSpace,
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[24],
                                    isLeftRadius: true,
                                    buttonHeight: remainHeight,
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[23],
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                    buttonHeight: remainHeight,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[22],
                                    isRightRadius: true,
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: verticalSpace,
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[21],
                                    isLeftRadius: true,
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[20],
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[19],
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[18],
                                    isRightRadius: true,
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: verticalSpace,
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[17],
                                    isLeftRadius: true,
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[16],
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[15],
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[14],
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[13],
                                    buttonHeight: remainHeight,
                                    isRightRadius: true,
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: verticalSpace,
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[12],
                                    isLeftRadius: true,
                                    buttonHeight: remainHeight,
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[11],
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[10],
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[9],
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[8],
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[7],
                                    buttonHeight: remainHeight,
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                    isRightRadius: true,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: verticalSpace,
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[6],
                                    isLeftRadius: true,
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[5],
                                    buttonHeight: remainHeight,
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[4],
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                    buttonHeight: remainHeight,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[3],
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                    buttonHeight: remainHeight,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[2],
                                    buttonHeight: remainHeight,
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[1],
                                    height: constraints.maxWidth,
                                    buttonHeight: remainHeight,
                                    colorTuple: colorTuple,
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[0],
                                    isRightRadius: true,
                                    buttonHeight: remainHeight,
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    );
                  }),
                ),
                SizedBox(
                  height: getPercentSize(remainHeight, 2),
                ),
                Container(
                  height: height1,
                  decoration: getCommonDecoration(context),
                  alignment: Alignment.bottomCenter,
                  child: Builder(builder: (context) {
                    return Center(
                      child: GridView.count(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: aspectRatio,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          right: (margin * 2),
                          left: (margin * 2),
                        ),
                        crossAxisSpacing: crossAxisSpacing,
                        mainAxisSpacing: crossAxisSpacing,
                        primary: false,
                        // padding: EdgeInsets.only(top: getScreenPercentSize(context, 4)),
                        children: List.generate(list.length, (index) {
                          String e = list[index];
                          if (e == "Done") {
                            return CommonClearButton(
                                text: "Done".tr(),
                                height: height,
                                btnRadius: radius,
                                onTab: () {
                                  context
                                      .read<NumberPyramidProvider>()
                                      .pyramidBoxInputValue(e);
                                });
                          } else if (e == "Back") {
                            return CommonBackButton(
                              btnRadius: radius,
                              onTab: () {
                                context
                                    .read<NumberPyramidProvider>()
                                    .pyramidBoxInputValue(e);
                              },
                              height: height,
                            );
                          } else {
                            return CommonNumberButton(
                              text: e,
                              totalHeight: remainHeight,
                              height: height,
                              btnRadius: radius,
                              onTab: () {
                                context
                                    .read<NumberPyramidProvider>()
                                    .pyramidBoxInputValue(e);
                              },
                              colorTuple: colorTuple1,
                            );
                          }
                        }),
                      ),
                    );
                  }),
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
