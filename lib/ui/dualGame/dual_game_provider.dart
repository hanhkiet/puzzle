import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../core/app_constants.dart';
import '../../data/models/quiz_model.dart';
import '../app/game_provider.dart';
import '../soundPlayer/audio_file.dart';

class DualGameProvider extends GameProvider<QuizModel> {
  int? level;
  BuildContext? context;

  DualGameProvider(
      {required TickerProvider vsync,
      required int this.level,
      required BuildContext this.context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.DUAL_GAME,
            c: context) {
    startGame(level: level);
  }

  void checkResult2(String answer) async {
    AudioPlayer audioPlayer = AudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      if (!isSecondClick) {
        isSecondClick = true;
      }
      result = answer;
      notifyListeners();
      print(
          "result====${currentState.answer}===$result===${(result == currentState.answer)}");
      if (result == currentState.answer) {
        score2++;
        audioPlayer.playRightSound();
        await Future.delayed(const Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else {
        audioPlayer.playWrongSound();
        wrongDualAnswer(false);
      }
    }
  }

  void checkResult1(String answer) async {
    AudioPlayer audioPlayer = AudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      if (!isFirstClick) {
        isFirstClick = true;
      }
      result = answer;
      notifyListeners();

      print(
          "result====${currentState.answer}===$result===${(result == currentState.answer)}");
      if (result == currentState.answer) {
        score1++;
        audioPlayer.playRightSound();
        await Future.delayed(const Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else {
        audioPlayer.playWrongSound();
        wrongDualAnswer(true);
      }
    }
  }
}
