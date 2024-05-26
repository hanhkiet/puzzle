import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:puzzle/data/models/quick_calculation.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/ui/app/game_provider.dart';

import '../sound_player/audio_file.dart';

class QuickCalculationProvider extends GameProvider<QuickCalculation> {
  late QuickCalculation nextCurrentState;
  QuickCalculation? previousCurrentState;
  int? level;
  BuildContext? context;

  QuickCalculationProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(
            gameCategoryType: GameCategoryType.quickCalculation, c: context) {
    startGame(level: level);
    nextCurrentState = list[index + 1];
  }

  Future<void> checkResult(String answer) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);
    if (result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      result = result + answer;
      notifyListeners();
      if (int.parse(result) == currentState.answer) {
        audioPlayer.playRightSound();
        await Future.delayed(const Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level);
        previousCurrentState = list[index - 1];
        nextCurrentState = list[index + 1];
        currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);
        addCoin();
        // if (/*time >= 0.0125*/ timerStatus != TimerStatus.pause) increase();
        notifyListeners();
      } else if (result.length == currentState.answer.toString().length) {
        audioPlayer.playWrongSound();
        if (currentScore > 0) {
          wrongAnswer();
        }

        minusCoin();
      }
    }
  }

  clearResult() {
    result = "";
    notifyListeners();
  }

  void backPress() {
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
      notifyListeners();
    }
  }
}
