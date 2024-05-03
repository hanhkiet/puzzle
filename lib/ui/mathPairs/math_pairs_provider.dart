import 'dart:async';
import 'package:flutter/cupertino.dart';


import '../../core/app_constants.dart';
import '../../data/models/math_pairs.dart';
import '../app/game_provider.dart';
import '../soundPlayer/audio_file.dart';

class MathPairsProvider extends GameProvider<MathPairs> {
  int first = -1;
  int second = -1;
  int? level;
  BuildContext? context;

  MathPairsProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(
            gameCategoryType: GameCategoryType.MATH_PAIRS,
            c: context) {
    startGame(level: level);
  }

  Future<void> checkResult(Pair mathPair, int index) async {
    AudioPlayer audioPlayer = AudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      if (!currentState.list[index].isActive) {
        currentState.list[index].isActive = true;
        notifyListeners();
        if (first != -1) {
          if (currentState.list[first].uid == currentState.list[index].uid) {
            audioPlayer.playRightSound();

            currentState.list[first].isVisible = false;
            currentState.list[index].isVisible = false;
            currentState.availableItem = currentState.availableItem - 2;
            first = -1;
            oldScore = currentScore;
            currentScore = currentScore + KeyUtil.mathematicalPairsScore;
            notifyListeners();
            if (currentState.availableItem == 0) {
              await Future.delayed(const Duration(milliseconds: 300));
              loadNewDataIfRequired(level: level ?? 1);
              currentScore =
                  currentScore + KeyUtil.getScoreUtil(gameCategoryType);

              addCoin();

              if (timerStatus != TimerStatus.pause) {
                restartTimer();
              }
              notifyListeners();
            }
          } else {
            audioPlayer.playWrongSound();
            minusCoin();
            wrongAnswer();
            currentState.list[first].isActive = false;
            currentState.list[index].isActive = false;
            first = -1;
            notifyListeners();
          }
        } else {
          first = index;
        }
      } else {
        first = -1;
        currentState.list[index].isActive = false;
        notifyListeners();
      }
    }
  }
}
