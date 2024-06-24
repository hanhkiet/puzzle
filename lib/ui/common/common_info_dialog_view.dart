import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_constants.dart';
import '../../data/models/game_info_dialog.dart';
import '../../utility/constants.dart';
import '../../utility/dialog_info_util.dart';

class CommonInfoDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final Color color;

  const CommonInfoDialogView({
    required this.gameCategoryType,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GameInfoDialog gameInfoDialog =
        DialogInfoUtil.getInfoDialogData(gameCategoryType);

    String plusSecondString = gameInfoDialog.plusSeconds != null
        ? "and second(s)".tr(args: [gameInfoDialog.plusSeconds.toString()])
        : "";
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getScreenPercentSize(context, 2),
          horizontal: getHorizontalSpace(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getTextWidget(
              Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
              gameInfoDialog.title,
              TextAlign.center,
              getScreenPercentSize(context, 3.5)),
          SizedBox(height: getScreenPercentSize(context, 5)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidthPercentSize(context, 10)),
            child: getTextWidgetWithMaxLine(
                Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w400),
                gameInfoDialog.dec,
                TextAlign.center,
                getScreenPercentSize(context, 2),
                4),
          ),
          SizedBox(height: getScreenPercentSize(context, 4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                      "${gameInfoDialog.correctAnswerScore} ${"point".tr()}$plusSecondString",
                      TextAlign.center,
                      getScreenPercentSize(context, 2)),
                  SizedBox(
                    height: getScreenPercentSize(context, 1.8),
                  ),
                  getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                      "${gameInfoDialog.wrongAnswerScore} ${"point".tr()}",
                      TextAlign.center,
                      getScreenPercentSize(context, 2)),
                ],
              ),
              SizedBox(width: getWidthPercentSize(context, 2)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                      "for correct answer".tr(),
                      TextAlign.center,
                      getScreenPercentSize(context, 2)),
                  SizedBox(
                    height: getScreenPercentSize(context, 1.8),
                  ),
                  getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                      "for wrong answer".tr(),
                      TextAlign.center,
                      getScreenPercentSize(context, 2)),
                ],
              ),
            ],
          ),
          SizedBox(height: getScreenPercentSize(context, 5)),
          Center(
            child: getButtonWidget(context, "Got It !".tr(), color, () {
              Navigator.pop(context);
            }, textColor: Colors.black),
          ),
        ],
      ),
    );
  }
}
