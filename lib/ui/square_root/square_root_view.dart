import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/core/app_assets.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/square_root.dart';
import 'package:puzzle/data/random_find_missing_data.dart';
import 'package:puzzle/ui/common/common_app_bar.dart';
import 'package:puzzle/ui/common/common_info_text_view.dart';
import 'package:puzzle/ui/common/dialog_listener.dart';
import 'package:puzzle/ui/model/gradient_model.dart';
import 'package:puzzle/ui/square_root/square_root_provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../utility/constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';

class SquareRootView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const SquareRootView({
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
        ChangeNotifierProvider<SquareRootProvider>(
            create: (context) => SquareRootProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<SquareRootProvider>(
        colorTuple: colorTuple,
        appBar: CommonAppBar<SquareRootProvider>(
            infoView: CommonInfoTextView<SquareRootProvider>(
                gameCategoryType: GameCategoryType.squareRoot,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.squareRoot,
            colorTuple: colorTuple,
            context: context),
        gameCategoryType: GameCategoryType.squareRoot,
        level: colorTuple.item2,
        child: CommonMainWidget<SquareRootProvider>(
          gameCategoryType: GameCategoryType.squareRoot,
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
                          SvgPicture.asset(
                            AppAssets.icRoot,
                            height: getPercentSize(remainHeight, 6),
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).textTheme.titleSmall!.color!,
                                BlendMode.srcIn),
                          ),
                          Selector<SquareRootProvider, SquareRoot>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, calculatorProvider, child) {
                                return getTextWidget(
                                    Theme.of(context).textTheme.titleSmall!,
                                    calculatorProvider.question,
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
                        return Selector<SquareRootProvider, SquareRoot>(
                            selector: (p0, p1) => p1.currentState,
                            builder: (context, currentState, child) {
                              if (kDebugMode) {
                                print("valueG===true");
                              }

                              final list = [
                                currentState.firstAns,
                                currentState.secondAns,
                                currentState.thirdAns,
                                currentState.fourthAns,
                              ];

                              shuffle(list);

                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: getPercentSize(height1, 10)),
                                child: Column(
                                  children: List.generate(list.length, (index) {
                                    String e = list[index];
                                    return CommonVerticalButton(
                                        text: e,
                                        isNumber: true,
                                        onTab: () {
                                          context
                                              .read<SquareRootProvider>()
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
