import 'package:easy_localization/easy_localization.dart';
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
import 'concentration_button.dart';
import 'concentration_provider.dart';

class ConcentrationView extends StatefulWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const ConcentrationView({
    super.key,
    required this.colorTuple,
  });

  @override
  State<ConcentrationView> createState() => _ConcentrationViewState();
}

class _ConcentrationViewState extends State<ConcentrationView> {
  @override
  Widget build(BuildContext context) {
    bool isContinue = false;

    double remainHeight = getRemainHeight(context: context);
    double mainHeight = getMainHeight(context);

    int crossAxisCount = 3;
    double height = getPercentSize(remainHeight, 65) / 5;

    double crossAxisSpacing = getPercentSize(height, 14);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    double aspectRatio = widthItem / height;

    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<ConcentrationProvider>(
            create: (context) => ConcentrationProvider(
                vsync: VsyncProvider.of(context),
                level: widget.colorTuple.item2,
                nextQuiz: () {
                  if (kDebugMode) {
                    print("isContinue====$isContinue");
                  }
                  setState(() {
                    isContinue = false;
                  });
                },
                context: context))
      ],
      child: DialogListener<ConcentrationProvider>(
        colorTuple: widget.colorTuple,
        gameCategoryType: GameCategoryType.concentration,
        level: widget.colorTuple.item2,
        appBar: CommonAppBar<ConcentrationProvider>(
          hint: false,
          infoView: CommonInfoTextView<ConcentrationProvider>(
              gameCategoryType: GameCategoryType.concentration,
              folder: widget.colorTuple.item1.folderName!,
              color: widget.colorTuple.item1.cellColor!),
          gameCategoryType: GameCategoryType.concentration,
          colorTuple: widget.colorTuple,
          context: context,
        ),
        child: CommonMainWidget<ConcentrationProvider>(
          gameCategoryType: GameCategoryType.concentration,
          color: widget.colorTuple.item1.bgColor!,
          primaryColor: widget.colorTuple.item1.primaryColor!,
          subChild: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                  margin: EdgeInsets.only(top: getPercentSize(mainHeight, 80)),
                  child: Container(
                    decoration: getCommonDecoration(context),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Consumer<ConcentrationProvider>(
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
                                            getHorizontalSpace(context) / 2),
                                    child: ConcentrationButton(
                                      height: height,
                                      mathPairs:
                                          provider.currentState.list[index],
                                      index: index,
                                      isContinue: isContinue,
                                      colorTuple: Tuple2(
                                          widget.colorTuple.item1.primaryColor!,
                                          widget.colorTuple.item1
                                              .backgroundColor!),
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
                            child: getButtonWidget(context, "Continue".tr(),
                                widget.colorTuple.item1.primaryColor, () {
                              setState(() {
                                isContinue = true;
                              });
                            }, textColor: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          ),
          context: context,
          isTopMargin: false,
        ),
      ),
    );
  }
}
