import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/picture_puzzle.dart';
import 'package:puzzle/ui/common/common_app_bar.dart';
import 'package:puzzle/ui/common/common_back_button.dart';
import 'package:puzzle/ui/common/common_clear_button.dart';
import 'package:puzzle/ui/common/common_info_text_view.dart';
import 'package:puzzle/ui/common/dialog_listener.dart';
import 'package:puzzle/ui/model/gradient_model.dart';
import 'package:puzzle/ui/picture_puzzle/picture_puzzle_button.dart';
import 'package:puzzle/ui/picture_puzzle/picture_puzzle_provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_number_button.dart';

class PicturePuzzleView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  PicturePuzzleView({
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

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<PicturePuzzleProvider>(
            create: (context) => PicturePuzzleProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<PicturePuzzleProvider>(
        colorTuple: colorTuple,
        appBar: CommonAppBar<PicturePuzzleProvider>(
            hint: false,
            infoView: CommonInfoTextView<PicturePuzzleProvider>(
                gameCategoryType: GameCategoryType.picturePuzzle,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.picturePuzzle,
            colorTuple: colorTuple,
            context: context),
        gameCategoryType: GameCategoryType.picturePuzzle,
        level: colorTuple.item2,
        child: CommonMainWidget<PicturePuzzleProvider>(
          gameCategoryType: GameCategoryType.picturePuzzle,
          color: colorTuple.item1.bgColor!,
          primaryColor: colorTuple.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 40)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: getPercentSize(remainHeight, 4),
                ),
                Expanded(
                  flex: 1,
                  child: Selector<PicturePuzzleProvider, PicturePuzzle>(
                      selector: (p0, p1) => p1.currentState,
                      builder: (context, provider, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: provider.list.mapIndexed((index, list) {
                            return Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: (margin * 2)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: list.shapeList.map((subList) {
                                    return PicturePuzzleButton(
                                      picturePuzzleShape: subList,
                                      shapeColor:
                                          colorTuple.item1.primaryColor!,
                                      colorTuple: Tuple2(
                                          colorTuple.item1.cellColor!,
                                          colorTuple.item1.primaryColor!),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
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
                          if (e == "Clear") {
                            return CommonClearButton(
                                text: "Clear".tr(),
                                btnRadius: radius,
                                height: height,
                                onTab: () {
                                  context
                                      .read<PicturePuzzleProvider>()
                                      .clearResult();
                                });
                          } else if (e == "Back") {
                            return CommonBackButton(
                              onTab: () {
                                context
                                    .read<PicturePuzzleProvider>()
                                    .backPress();
                              },
                              height: height,
                              btnRadius: radius,
                            );
                          } else {
                            return CommonNumberButton(
                              text: e,
                              totalHeight: remainHeight,
                              height: height,
                              btnRadius: radius,
                              onTab: () {
                                context
                                    .read<PicturePuzzleProvider>()
                                    .checkGameResult(e);
                              },
                              colorTuple: colorTuple,
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
