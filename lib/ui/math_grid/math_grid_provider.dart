import 'dart:async';
import 'package:flutter/cupertino.dart';

import '../../core/app_constants.dart';
import '../../data/models/math_grid.dart';
import '../app/game_provider.dart';
import '../sound_player/audio_file.dart';

class MathGridProvider extends GameProvider<MathGrid> {
  int answerIndex = 0;
  int? level;
  BuildContext? context;

  MathGridProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(gameCategoryType: GameCategoryType.mathGrid, c: context) {
    startGame(level: level ?? 1);
  }

  void checkResult(int index, MathGridCellModel gridModel) {
    if (timerStatus != TimerStatus.pause) {
      if (gridModel.isActive) {
        gridModel.isActive = false;
        notifyListeners();
      } else {
        gridModel.isActive = true;
        notifyListeners();
      }
      checkForCorrectAnswer();
    }
  }

  Future<void> checkForCorrectAnswer() async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);
    int total = 0;
    var listOfIndex = currentState.listForSquare
        .where((result) => result.isActive == true)
        .toList();

    for (int i = 0; i < listOfIndex.length; i++) {
      total = total + listOfIndex[i].value;
    }

    if (currentState.currentAnswer == total) {
      for (int i = 0; i < listOfIndex.length; i++) {
        listOfIndex[i].isActive = false;
        listOfIndex[i].isRemoved = true;
      }
      answerIndex = answerIndex + 1;
      if (currentState.listForSquare
          .where((element) => !element.isRemoved)
          .isEmpty) {
        await Future.delayed(const Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level ?? 1);
        answerIndex = 0;
        currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);

        addCoin();
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else {
        audioPlayer.playRightSound();
        currentState.currentAnswer = currentState.getNewAnswer();
      }
    }
  }

  clear() {
    notifyListeners();
  }
}
