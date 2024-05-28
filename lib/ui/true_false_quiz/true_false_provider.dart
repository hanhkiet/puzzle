import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/true_false_model.dart';
import 'package:puzzle/ui/app/game_provider.dart';

import '../sound_player/audio_file.dart';

class TrueFalseProvider extends GameProvider<TrueFalseModel> {
  int? level;
  BuildContext? context;

  TrueFalseProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(gameCategoryType: GameCategoryType.trueFalse, c: context) {
    startGame(level: level);
  }

  void checkResult(String answer) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      result = answer;
      notifyListeners();

      print("result====$result====${currentState.answer}");

      if ((result) == currentState.answer) {
        audioPlayer.playRightSound();
        rightAnswer();
        rightCount = rightCount + 1;
        if (timerStatus != TimerStatus.pause)
          increase(period: KeyUtil.findMissingPlusTime);
        await Future.delayed(const Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }

        notifyListeners();
      } else {
        wrongCount = wrongCount + 1;
        audioPlayer.playWrongSound();
        wrongAnswer();
      }
    }
  }
}
