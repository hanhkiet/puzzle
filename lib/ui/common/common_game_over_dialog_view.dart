import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:tuple/tuple.dart';
import '../../core/app_constants.dart';
import '../../utility/constants.dart';
import '../dashboard/dashboard_view.dart';
import '../model/gradient_model.dart';
import '../sound_player/audio_file.dart';
import 'common_score_widget.dart';

class CommonGameOverDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final int score;
  final int right;
  final int wrong;
  final int level;
  final int totalQuestion;
  final Tuple2<GradientModel, int> colorTuple;
  final Function function;
  final Function updateFunction;

  const CommonGameOverDialogView({
    required this.gameCategoryType,
    required this.score,
    required this.right,
    required this.wrong,
    required this.level,
    required this.totalQuestion,
    required this.colorTuple,
    required this.function,
    required this.updateFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context);
    //AdsFile? adsFile = AdsFile(context);
    //adsFile.createInterstitialAd();

    audioPlayer.playGameOverSound();

    double percentage = (score * 100) / 20;
    int star = 0;

    if (percentage < 35) {
      star = 1;
    } else if (percentage > 35 && percentage < 75) {
      star = 2;
    } else if (percentage > 75) {
      star = 3;
    }

    if (kDebugMode) {
      print("start---$star");
    }

    return CommonScoreWidget(
      context: context,
      colorTuple: colorTuple,
      totalLevel: defaultLevelSize,
      currentLevel: level,
      gameCategoryType: gameCategoryType,
      score: score,
      right: right,
      totalQuestion: totalQuestion,
      wrong: wrong,
      function: function,
      closeClick: () {
        //updateFunction();
        Navigator.pop(context);
      },
      homeClick: () {
        updateFunction();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardView(),
            ));
      },
      restartClick: () {
        /*showInterstitialAd(adsFile, () {
          disposeInterstitialAd(adsFile);
          Navigator.pop(context, true);
        });*/
        //updateFunction();
        Navigator.pop(context, true);
      },
      nextClick: () {
        if (star >= 2) {
          /*showInterstitialAd(adsFile, () {
            disposeInterstitialAd(adsFile);
            if (colorTuple.item2 < defaultLevelSize) {
              function(colorTuple.item2 + 1);
            }
            Navigator.pop(context, true);
          });*/
          //updateFunction();
          if (colorTuple.item2 < defaultLevelSize) {
            function(colorTuple.item2 + 1);
          }
          Navigator.pop(context, true);
        }
      },
      shareClick: () {
        share();
      },
    );
  }

  share() async {
    await FlutterShare.share(
        title: 'Math Games'.tr(),
        text:
            'Your highest score is'.tr(args: [score.toString(), getAppLink()]),
        linkUrl: '',
        chooserTitle: 'Share'.tr());
  }
}
