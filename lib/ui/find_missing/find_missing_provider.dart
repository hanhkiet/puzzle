import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../core/app_constants.dart';
import '../../data/models/find_missing_model.dart';
import '../app/game_provider.dart';
import '../sound_player/audio_file.dart';

class FindMissingProvider extends GameProvider<FindMissingQuizModel> {
  int? level;
  BuildContext? context;

  FindMissingProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(gameCategoryType: GameCategoryType.findMissing, c: context) {
    startGame(level: level);
  }

  void checkResult(String answer) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      result = answer;
      notifyListeners();
      if ((result) == currentState.answer) {
        audioPlayer.playRightSound();
        rightAnswer();
        rightCount = rightCount + 1;
        if (timerStatus != TimerStatus.pause) {
          increase(period: KeyUtil.findMissingPlusTime);
        }
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
