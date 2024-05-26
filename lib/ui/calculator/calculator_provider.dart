import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/calculator.dart';
import 'package:puzzle/ui/app/game_provider.dart';
import 'package:puzzle/ui/sound_player/audio_file.dart';

class CalculatorProvider extends GameProvider<Calculator> {
  BuildContext? context;
  int? level;

  CalculatorProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(gameCategoryType: GameCategoryType.calculator, c: context) {
    startGame(level: level);
  }

  bool isClick = false;

  void checkResult(String answer) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      result = result + answer;
      notifyListeners();

      if (int.parse(result) == currentState.answer) {
        notifyListeners();

        audioPlayer.playRightSound();
        isClick = false;

        await Future.delayed(const Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }

        currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);
        addCoin();
        notifyListeners();
      } else if (result.length == currentState.answer.toString().length) {
        minusCoin();
        audioPlayer.playWrongSound();
        wrongAnswer();
      }
    }
  }

  void backPress() {
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
      notifyListeners();
    }
  }

  void clearResult() {
    result = "";
    notifyListeners();
  }
}
