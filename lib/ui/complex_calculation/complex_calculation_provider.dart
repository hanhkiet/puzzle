import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../core/app_constants.dart';
import '../../data/models/complex_model.dart';

import '../app/game_provider.dart';
import '../sound_player/audio_file.dart';

class ComplexCalculationProvider extends GameProvider<ComplexModel> {
  int? level;
  BuildContext? context;

  ComplexCalculationProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(
            gameCategoryType: GameCategoryType.complexCalculation, c: context) {
    startGame(level: level);
  }

  void checkResult(String answer) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);
    if (timerStatus != TimerStatus.pause) {
      notifyListeners();

      if ((answer) == currentState.finalAnswer) {
        audioPlayer.playRightSound();
        rightAnswer();
        if (timerStatus != TimerStatus.pause)
          increase(period: KeyUtil.complexCalculationPlusTime);
        rightCount = rightCount + 1;
      } else {
        wrongCount = wrongCount + 1;
        audioPlayer.playWrongSound();
        wrongAnswer();
      }

      await Future.delayed(const Duration(milliseconds: 300));
      loadNewDataIfRequired(level: level);
      if (timerStatus != TimerStatus.pause) {
        restartTimer();
      }

      notifyListeners();
    }
  }
}
