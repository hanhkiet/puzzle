import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/app_constants.dart';
import '../../data/models/quiz_model.dart';
import '../app/game_provider.dart';
import '../sound_player/audio_file.dart';

class DuelGameProvider extends GameProvider<QuizModel> {
  int? level;
  BuildContext? context;

  DuelGameProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(gameCategoryType: GameCategoryType.dualGame, c: context) {
    startGame(level: level);
  }

  void checkResult2(String answer) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      if (!isSecondClick) {
        isSecondClick = true;
      }
      result = answer;
      notifyListeners();
      if (kDebugMode) {
        print(
            "result====${currentState.answer}===$result===${(result == currentState.answer)}");
      }
      if (result == currentState.answer) {
        score2++;
        audioPlayer.playRightSound();
        await Future.delayed(const Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level);
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
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      if (!isFirstClick) {
        isFirstClick = true;
      }
      result = answer;
      notifyListeners();

      if (kDebugMode) {
        print(
            "result====${currentState.answer}===$result===${(result == currentState.answer)}");
      }
      if (result == currentState.answer) {
        score1++;
        audioPlayer.playRightSound();
        await Future.delayed(const Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level);
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
