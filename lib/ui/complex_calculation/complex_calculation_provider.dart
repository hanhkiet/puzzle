import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../core/app_constants.dart';
import '../../data/models/ComplexModel.dart';

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
            gameCategoryType: GameCategoryType.complexCalculation,
            c: context) {
    startGame(level: level);
  }

  void checkResult(String answer) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      result = answer;
      notifyListeners();

      if ((result) == currentState.answer) {
        audioPlayer.playRightSound();
        rightAnswer();

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

      // if (result == currentState.finalAnswer) {
      //   audioPlayer.playRightSound();
      //   await Future.delayed(Duration(milliseconds: 300));
      //   loadNewDataIfRequired(level: level==null?null:level);
      //   if (timerStatus != TimerStatus.pause) {
      //     restartTimer();
      //   }
      //   notifyListeners();
      // } else {
      //   audioPlayer.playWrongSound();
      //   wrongAnswer();
      // }
    }
  }
}
