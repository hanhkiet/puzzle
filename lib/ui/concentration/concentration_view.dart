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
import 'concentration_button.dart';
import 'concentration_provider.dart';

class ConcentrationView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const ConcentrationView({
    super.key,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    bool isContinue = false;

    double remainHeight = getRemainHeight(context: context);
    double mainHeight = getMainHeight(context);

    int _crossAxisCount = 3;
    double height = getPercentSize(remainHeight, 65) / 5;

    double _crossAxisSpacing = getPercentSize(height, 14);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;

    return StatefulBuilder(builder: (context, snapshot) {
      return MultiProvider(
        providers: [
          const VsyncProvider(),
          ChangeNotifierProvider<ConcentrationProvider>(
              create: (context) => ConcentrationProvider(
                  vsync: VsyncProvider.of(context),
                  level: colorTuple.item2,
                  isTimer: false,
                  nextQuiz: () {
                    print("isContinue====$isContinue");
                    snapshot(() {
                      isContinue = false;
                    });
                  },
                  context: context))
        ],
        child: DialogListener<ConcentrationProvider>(
          colorTuple: colorTuple,
          gameCategoryType: GameCategoryType.concentration,
          level: colorTuple.item2,
          appBar: CommonAppBar<ConcentrationProvider>(
              hint: false,
              infoView: CommonInfoTextView<ConcentrationProvider>(
                  gameCategoryType: GameCategoryType.concentration,
                  folder: colorTuple.item1.folderName!,
                  color: colorTuple.item1.cellColor!),
              gameCategoryType: GameCategoryType.concentration,
              colorTuple: colorTuple,
              context: context,
              isTimer: false),
          // child: getCommonWidget(
          //   context: context,
          //   isTopMargin: false,
          //   child: StatefulBuilder(
          //     builder: (context, setState) {
          //       return Column(
          //         children: <Widget>[
          //           Expanded(
          //             flex: 1,
          //             child: Center(
          //               child: Consumer<ConcentrationProvider>(
          //                   builder: (context, provider, child) {
          //                 return GridView.count(
          //                   crossAxisCount: _crossAxisCount,
          //                   childAspectRatio: _aspectRatio,
          //                   shrinkWrap: true,
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal: getHorizontalSpace(context) / 2,
          //                       vertical: getHorizontalSpace(context)),
          //                   crossAxisSpacing: _crossAxisSpacing,
          //                   mainAxisSpacing: _crossAxisSpacing,
          //                   primary: false,
          //                   children: List.generate(
          //                       provider.currentState.list.length,
          //                       (index) {
          //                     return ConcentrationButton(
          //                       height: height,
          //                       mathPairs:
          //                       provider.currentState.list[index],
          //                       index: index,
          //                       isContinue: isContinue,
          //                       colorTuple: Tuple2(colorTuple.item1.primaryColor!,
          //                           colorTuple.item1.primaryColor!),
          //                     );
          //                   }),
          //                 );
          //               }),
          //             ),
          //           ),
          //           Visibility(
          //             visible: !isContinue,
          //             child: Container(
          //               margin: EdgeInsets.symmetric(
          //                   horizontal: getHorizontalSpace(context)),
          //               child: getButtonWidget(
          //                   context, "Continue", colorTuple.item1.primaryColor, () {
          //
          //                     setState((){
          //                       isContinue = true;
          //
          //                     });
          //
          //               }, textColor: Colors.black),
          //             ),
          //           ),
          //         ],
          //       );
          //     }
          //   ),
          //   subChild:
          //   CommonInfoTextView<ConcentrationProvider>(
          //       folder: colorTuple.item1.folderName!,
          //       gameCategoryType: GameCategoryType.CONCENTRATION,
          //       color: colorTuple.item1.cellColor!),
          // ),

          child: CommonMainWidget<ConcentrationProvider>(
            gameCategoryType: GameCategoryType.concentration,
            color: colorTuple.item1.bgColor!,
            isTimer: false,
            primaryColor: colorTuple.item1.primaryColor!,
            subChild: Container(
              margin: EdgeInsets.only(top: getPercentSize(mainHeight, 80)),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    // decoration: getDecorationWithSide(
                    //   isShadow: true,
                    //   bgColor: getBackGroundColor(context),
                    //   isTopLeft: true,
                    //   isTopRight: true,
                    //   radius: getPercentSize(mainHeight, 12),
                    // ),
                    decoration: getCommonDecoration(context),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Consumer<ConcentrationProvider>(
                                builder: (context, provider, child) {
                              return GridView.count(
                                crossAxisCount: _crossAxisCount,
                                childAspectRatio: _aspectRatio,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: getHorizontalSpace(context),
                                    vertical: getHorizontalSpace(context)),
                                crossAxisSpacing: _crossAxisSpacing,
                                mainAxisSpacing: _crossAxisSpacing,
                                primary: false,
                                children: List.generate(
                                    provider.currentState.list.length, (index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            getHorizontalSpace(context) / 1.5,
                                        vertical:
                                            getHorizontalSpace(context) / 2),
                                    child: ConcentrationButton(
                                      height: height,
                                      mathPairs:
                                          provider.currentState.list[index],
                                      index: index,
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
                        ),
                        Visibility(
                          visible: !isContinue,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: (getHorizontalSpace(context))),
                            child: getButtonWidget(context, "Continue",
                                colorTuple.item1.primaryColor, () {
                              setState(() {
                                isContinue = true;
                              });
                            }, textColor: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            context: context,
            isTopMargin: false,
          ),
        ),
      );
    });
  }
}