import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/numeric_memory_pair.dart';
import 'package:puzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class NumericMemoryProvider extends GameProvider<NumericMemoryPair> {
  int first = -1;
  int second = -1;
  int? level;
  BuildContext? context;
  bool isTimer = true;
  Function? nextQuiz;

  NumericMemoryProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context,
      required Function this.nextQuiz,
      bool? isTimer})
      : super(
            gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
            isTimer: isTimer,
            c: context) {
    this.isTimer = (isTimer == null) ? true : isTimer;

    startGame(level: level, isTimer: isTimer);
  }

  Future<void> checkResult(String mathPair, int index) async {
    AudioPlayer audioPlayer = AudioPlayer(context!);

    print("mathPair===$mathPair===${currentState.answer}");

    if (mathPair == currentState.answer) {
      audioPlayer.playRightSound();
      currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);

      addCoin();
    } else {
      minusCoin();
      wrongAnswer();
      audioPlayer.playWrongSound();
      first = -1;
    }

    await Future.delayed(const Duration(seconds: 1));
    loadNewDataIfRequired(level: level ?? 1, isScoreAdd: false);

    if (nextQuiz != null) {
      nextQuiz!();
    }
    notifyListeners();
  }
}
