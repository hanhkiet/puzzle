import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/app_constants.dart';
import '../../data/models/math_pairs.dart';
import '../app/game_provider.dart';
import '../sound_player/audio_file.dart';

class ConcentrationProvider extends GameProvider<MathPairs> {
  int first = -1;
  int second = -1;
  int? level;
  BuildContext? context;
  Function? nextQuiz;

  ConcentrationProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context,
      required Function this.nextQuiz,
      bool? isTimer})
      : super(gameCategoryType: GameCategoryType.concentration, c: context) {
    if (kDebugMode) {
      print("start===true");
    }

    startGame(level: level);
  }

  Future<void> checkResult(Pair mathPair, int index) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    // if (timerStatus != TimerStatus.pause) {
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

          notifyListeners();
          if (currentState.availableItem == 0) {
            print("oldScore===$oldScore====$currentScore");

            print("oldScore===$oldScore====$currentScore");

            await Future.delayed(const Duration(milliseconds: 300));
            loadNewDataIfRequired(level: level ?? 1);
            currentScore =
                currentScore + KeyUtil.getScoreUtil(gameCategoryType);

            addCoin();
            if (nextQuiz != null) {
              nextQuiz!();
            }
            notifyListeners();
          }
        } else {
          audioPlayer.playWrongSound();
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
