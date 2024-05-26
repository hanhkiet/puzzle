import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import '../../core/app_constants.dart';
import '../../utility/Constants.dart';
import '../common/common_app_bar.dart';
import '../common/common_info_text_view.dart';
import '../common/common_main_widget.dart';
import '../common/dialog_listener.dart';
import '../model/gradient_model.dart';
import 'math_pairs_button.dart';
import 'math_pairs_provider.dart';

class MathPairsView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const MathPairsView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double mainHeight = getMainHeight(context);

    int _crossAxisCount = 3;
    double height = getPercentSize(remainHeight, 75) / 5;

    double _crossAxisSpacing = getPercentSize(height, 14);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<MathPairsProvider>(
            create: (context) => MathPairsProvider(
                vsync: VsyncProvider.of(context),
                level: colorTuple.item2,
                context: context))
      ],
      child: DialogListener<MathPairsProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.mathPairs,
        level: colorTuple.item2,
        appBar: CommonAppBar<MathPairsProvider>(
            hint: false,
            infoView: CommonInfoTextView<MathPairsProvider>(
                gameCategoryType: GameCategoryType.mathPairs,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.mathPairs,
            colorTuple: colorTuple,
            context: context),

        // child:getCommonWidget(context: context,
        //
        //   child: Column(
        //     children: <Widget>[
        //
        //
        //       Expanded(
        //         flex: 1,
        //         child: Center(
        //           child: Consumer<MathPairsProvider>(
        //               builder: (context, mathPairsProvider, child) {
        //
        //                 return GridView.count(
        //                   crossAxisCount: _crossAxisCount,
        //                   childAspectRatio: _aspectRatio,
        //                   shrinkWrap: true,
        //                   padding: EdgeInsets.symmetric(
        //                       horizontal: getHorizontalSpace(context)/2,
        //                       vertical: getHorizontalSpace(context)),
        //                   crossAxisSpacing: _crossAxisSpacing,
        //                   mainAxisSpacing: _crossAxisSpacing,
        //                   primary: false,
        //                   children:
        //                   List.generate( mathPairsProvider.currentState.list.length, (index) {
        //                     return MathPairsButton(
        //                       height: height,
        //                                 mathPairs: mathPairsProvider
        //                                     .currentState.list[index],
        //                                 index: index,
        //                                 colorTuple: Tuple2(colorTuple.item1.primaryColor!,colorTuple.item1.primaryColor!),
        //                               );
        //                   }),
        //                 );
        //                 // return GridView.builder(
        //                 //     gridDelegate:
        //                 //     SliverGridDelegateWithFixedCrossAxisCount(
        //                 //         crossAxisCount: 3, childAspectRatio: 1.2),
        //                 //     padding:  EdgeInsets.only(bottom: getPercentSize(getRemainHeight(context: context),5)),
        //                 //     shrinkWrap: true,
        //                 //     itemCount:
        //                 //     mathPairsProvider.currentState.list.length,
        //                 //     physics: NeverScrollableScrollPhysics(),
        //                 //     itemBuilder: (BuildContext context, int index) {
        //                 //       return MathPairsButton(
        //                 //         mathPairs: mathPairsProvider
        //                 //             .currentState.list[index],
        //                 //         index: index,
        //                 //         colorTuple: Tuple2(colorTuple.item1.primaryColor!,colorTuple.item1.primaryColor!),
        //                 //       );
        //                 //     });
        //               }),
        //         ),
        //       ),
        //     ],
        //   ), subChild:   CommonInfoTextView<MathPairsProvider>(
        //       folder: colorTuple.item1.folderName!,
        //
        //       gameCategoryType: GameCategoryType.MATH_PAIRS,color: colorTuple.item1.cellColor!),),

        child: CommonMainWidget<MathPairsProvider>(
          gameCategoryType: GameCategoryType.mathPairs,
          color: colorTuple.item1.bgColor!,
          primaryColor: colorTuple.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 80)),
            child: Container(
              decoration: getCommonDecoration(context),
              child: Center(
                child: Consumer<MathPairsProvider>(
                    builder: (context, mathPairsProvider, child) {
                  return GridView.count(
                    crossAxisCount: _crossAxisCount,
                    childAspectRatio: _aspectRatio,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: getHorizontalSpace(context),
                        vertical: (getHorizontalSpace(context) * 2.5)),
                    crossAxisSpacing: _crossAxisSpacing,
                    mainAxisSpacing: _crossAxisSpacing,
                    primary: false,
                    children: List.generate(
                        mathPairsProvider.currentState.list.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: getHorizontalSpace(context) / 1.5,
                            vertical: getHorizontalSpace(context) / 1.3),
                        child: MathPairsButton(
                          height: height,
                          mathPairs: mathPairsProvider.currentState.list[index],
                          index: index,
                          colorTuple: Tuple2(colorTuple.item1.primaryColor!,
                              colorTuple.item1.backgroundColor!),
                        ),
                      );
                    }),
                  );
                  // return GridView.builder(
                  //     gridDelegate:
                  //     SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 3, childAspectRatio: 1.2),
                  //     padding:  EdgeInsets.only(bottom: getPercentSize(getRemainHeight(context: context),5)),
                  //     shrinkWrap: true,
                  //     itemCount:
                  //     mathPairsProvider.currentState.list.length,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return MathPairsButton(
                  //         mathPairs: mathPairsProvider
                  //             .currentState.list[index],
                  //         index: index,
                  //         colorTuple: Tuple2(colorTuple.item1.primaryColor!,colorTuple.item1.primaryColor!),
                  //       );
                  //     });
                }),
              ),
            ),
          ),
          context: context,
          isTopMargin: false,
        ),
      ),
    );
  }
}
