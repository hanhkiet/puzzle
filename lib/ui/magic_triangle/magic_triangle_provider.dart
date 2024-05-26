import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../core/app_constants.dart';
import '../../data/models/magic_triangle.dart';
import '../app/game_provider.dart';
import '../sound_player/audio_file.dart';

class MagicTriangleProvider extends GameProvider<MagicTriangle> {
  int selectedTriangleIndex = 0;
  int? level;
  BuildContext? context;

  MagicTriangleProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(gameCategoryType: GameCategoryType.MAGIC_TRIANGLE, c: context) {
    startGame(level: level);
  }

  void inputTriangleSelection(int index, MagicTriangleInput input) {
    if (timerStatus != TimerStatus.pause) {
      if (input.value.isEmpty) {
        for (int i = 0; i < currentState.listTriangle.length; i++) {
          currentState.listTriangle[i].isActive = false;
        }
        selectedTriangleIndex = index;
        currentState.listTriangle[index].isActive = true;
        notifyListeners();
      } else {
        int listGridIndex = currentState.listGrid.indexWhere(
            (val) => val.value == input.value && val.isVisible == false);
        currentState.listTriangle[index].isActive = false;
        currentState.listTriangle[index].value = "";
        currentState.availableDigit = currentState.availableDigit + 1;
        currentState.listGrid[listGridIndex].isVisible = true;
        notifyListeners();
      }
    }
  }

  Future<void> checkResult(int index, MagicTriangleGrid digit) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      int activeTriangleIndex =
          currentState.listTriangle.indexWhere((val) => val.isActive == true);
      if (currentState.listTriangle[activeTriangleIndex].value.isNotEmpty) {
        return;
      }
      currentState.listTriangle[selectedTriangleIndex].value = digit.value;
      currentState.listGrid[index].isVisible = false;
      currentState.availableDigit = currentState.availableDigit - 1;

      if (currentState.availableDigit == 0) {
        if (currentState.checkTotal()) {
          audioPlayer.playRightSound();
          await Future.delayed(const Duration(milliseconds: 300));
          loadNewDataIfRequired(level: level);
          selectedTriangleIndex = 0;
          currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);

          addCoin();
          if (timerStatus != TimerStatus.pause) {
            restartTimer();
          }
          notifyListeners();
        } else {
          audioPlayer.playWrongSound();
          print("wrong---tue");
        }
      }
      notifyListeners();
    }
  }
}
