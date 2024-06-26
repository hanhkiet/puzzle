import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/app_constants.dart';
import '../../data/models/cube_root.dart';
import '../app/game_provider.dart';
import '../sound_player/audio_file.dart';

class CubeRootProvider extends GameProvider<CubeRoot> {
  int? level;
  BuildContext? context;

  CubeRootProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(gameCategoryType: GameCategoryType.cubeRoot, c: context) {
    startGame(level: level);
  }

  Future<void> checkResult(String answer) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (kDebugMode) {
      print(
          "result===${int.parse(answer) == currentState.answer && timerStatus != TimerStatus.pause}");
    }

    if (int.parse(answer) == currentState.answer &&
        timerStatus != TimerStatus.pause) {
      rightAnswer();
      audioPlayer.playRightSound();
      rightCount = rightCount + 1;
      if (timerStatus != TimerStatus.pause) increase(period: 1);
      addCoin();
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
      minusCoin();
    }
  }
}
