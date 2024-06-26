import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/ui/magic_triangle/triangle_3x3.dart';
import 'package:puzzle/ui/magic_triangle/triangle_4x4.dart';
import 'package:puzzle/ui/magic_triangle/triangle_input_3x3.dart';
import 'package:puzzle/ui/magic_triangle/triangle_input_4x4.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../core/app_constants.dart';
import '../../utility/constants.dart';
import '../common/common_app_bar.dart';
import '../common/common_info_text_view.dart';
import '../common/common_main_widget.dart';
import '../common/dialog_listener.dart';
import '../model/gradient_model.dart';
import 'magic_triangle_provider.dart';

class MagicTriangleView extends StatelessWidget {
  final double padding = 0;
  final double radius = 30;
  final Tuple2<GradientModel, int> colorTuple1;

  const MagicTriangleView({
    super.key,
    required this.colorTuple1,
  });

  @override
  Widget build(BuildContext context) {
    Tuple2<Color, Color> colorTuple =
        Tuple2(colorTuple1.item1.primaryColor!, colorTuple1.item1.cellColor!);
    double height1 = getScreenPercentSize(context, 58);
    double mainHeight = getMainHeight(context);

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<MagicTriangleProvider>(
            create: (context) => MagicTriangleProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple1.item2,
                context: context))
      ],
      child: DialogListener<MagicTriangleProvider>(
        colorTuple: colorTuple1,
        gameCategoryType: GameCategoryType.magicTriangle,
        level: colorTuple1.item2,
        appBar: CommonAppBar<MagicTriangleProvider>(
            hint: false,
            infoView: CommonInfoTextView<MagicTriangleProvider>(
                gameCategoryType: GameCategoryType.magicTriangle,
                folder: colorTuple1.item1.folderName!,
                color: colorTuple1.item1.cellColor!),
            gameCategoryType: GameCategoryType.magicTriangle,
            colorTuple: colorTuple1,
            context: context),
        child: CommonMainWidget<MagicTriangleProvider>(
          gameCategoryType: GameCategoryType.magicTriangle,
          color: colorTuple1.item1.bgColor!,
          primaryColor: colorTuple1.item1.primaryColor!,
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
                          child: Selector<MagicTriangleProvider, int>(
                              selector: (p0, p1) => p1.currentState.answer,
                              builder: (context, answer, child) {
                                return getTextWidget(
                                    Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    answer.toString(),
                                    TextAlign.center,
                                    getPercentSize(mainHeight, 10));
                              }),
                        ),
                      ),
                    ),
                    Container(
                      height: height1,
                      decoration: getCommonDecoration(context),
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Expanded(
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              if (kDebugMode) {
                                print(
                                    "size---${constraints.maxWidth}----${constraints.maxWidth}");
                              }
                              return Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Selector<MagicTriangleProvider, bool>(
                                      selector: (p0, p1) =>
                                          p1.currentState.is3x3,
                                      builder: (context, is3x3, child) {
                                        return is3x3
                                            ? Triangle3x3(
                                                radius: radius,
                                                padding: padding,
                                                triangleHeight:
                                                    getScreenPercentSize(
                                                        context, 58),
                                                // constraints.maxWidth,
                                                triangleWidth:
                                                    constraints.maxWidth,
                                                colorTuple: colorTuple,
                                              )
                                            : Triangle4x4(
                                                radius: radius,
                                                padding: padding,
                                                triangleHeight:
                                                    constraints.maxWidth,
                                                triangleWidth:
                                                    constraints.maxWidth,
                                                colorTuple: colorTuple,
                                              );
                                      }),
                                ],
                              );
                            }),
                          ),
                          SizedBox(
                            height: getPercentSize(height1, 3),
                          ),
                          Selector<MagicTriangleProvider, bool>(
                              selector: (p0, p1) => p1.currentState.is3x3,
                              builder: (context, is3x3, child) {
                                return is3x3
                                    ? TriangleInput3x3(colorTuple: colorTuple)
                                    : TriangleInput4x4(colorTuple: colorTuple);
                              }),
                          SizedBox(
                            height: getPercentSize(height1, 3),
                          ),
                        ],
                      ),
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
