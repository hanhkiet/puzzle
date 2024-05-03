import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:puzzle/data/models/square_root.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/ui/app/game_provider.dart';

import '../sound_player/audio_file.dart';

class SquareRootProvider extends GameProvider<SquareRoot> {
  int? level;
  BuildContext? context;

  SquareRootProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(gameCategoryType: GameCategoryType.SQUARE_ROOT, c: context) {
    startGame(level: level);
  }

  Future<void> checkResult(String answer) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (int.parse(answer) == currentState.answer &&
        timerStatus != TimerStatus.pause) {
      rightAnswer();
      audioPlayer.playRightSound();
      rightCount = rightCount + 1;
      await Future.delayed(const Duration(milliseconds: 300));
      loadNewDataIfRequired(level: level);
      if (timerStatus != TimerStatus.pause) {
        restartTimer();
      }

      notifyListeners();
    } else {
      wrongCount = wrongCount + 1;
      audioPlayer.playWrongSound();
      wrongAnswer();
    }
    notifyListeners();
  }
}
