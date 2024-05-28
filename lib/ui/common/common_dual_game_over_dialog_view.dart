import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../core/app_constants.dart';
import '../../utility/constants.dart';
import '../dashboard/dashboard_view.dart';
import '../model/gradient_model.dart';
import '../sound_player/audio_file.dart';
import 'common_dual_score_widget.dart';

class CommonDualGameOverDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final int score1;
  final int score2;
  final int index;
  final int totalQuestion;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonDualGameOverDialogView({
    required this.gameCategoryType,
    required this.score1,
    required this.score2,
    required this.index,
    required this.totalQuestion,
    required this.colorTuple,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context);

    audioPlayer.playGameOverSound();

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getDefaultIconWidget(context,
            icon: AppAssets.backIcon,
            folder: colorTuple.item1.folderName, function: () {
          Navigator.pop(context);
        }),
        SizedBox(height: getScreenPercentSize(context, 1.8)),
        Center(
          child: getTextWidget(
              Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
              "Game Over!!!",
              TextAlign.center,
              getScreenPercentSize(context, 3)),
        ),
        Expanded(
            child: CommonDualScoreWidget(
          context: context,
          colorTuple: colorTuple,
          totalLevel: defaultLevelSize,
          currentLevel: 1,
          gameCategoryType: gameCategoryType,
          score1: score1,
          score2: score2,
          right: 1,
          totalQuestion: totalQuestion,
          index: index,
          wrong: 1,
          homeClick: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardView(),));
          },
          shareClick: () {
            //share();
          },
        )),
        getButtonWidget(context, "Restart", colorTuple.item1.primaryColor, () {
          Navigator.pop(context, true);
        }, textColor: Colors.black),
      ],
    );
  }
}
