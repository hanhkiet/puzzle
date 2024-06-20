import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/numeric_memory_pair.dart';
import 'package:puzzle/ui/app/game_provider.dart';
import 'package:puzzle/utility/math_util.dart';

import '../sound_player/audio_file.dart';

class NumericMemoryProvider extends GameProvider<NumericMemoryPair> {
  int first = -1;
  int second = -1;
  int? level;
  BuildContext? context;
  Function? nextQuiz;

  NumericMemoryProvider({
    required super.vsync,
    required int this.level,
    required BuildContext this.context,
    required Function this.nextQuiz,
  }) : super(gameCategoryType: GameCategoryType.numericMemory, c: context) {
    startGame(level: level);
  }

  Future<void> checkResult(String mathPair, int index) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (MathUtil.evaluateExpression(mathPair, currentState.question)) {
      audioPlayer.playRightSound();
      currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);
      if (timerStatus != TimerStatus.pause) {
        increase(period: KeyUtil.numericMemoryPlusTime);
      }
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
