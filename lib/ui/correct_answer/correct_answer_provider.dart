import 'dart:async';
import 'package:flutter/cupertino.dart';

import '../../core/app_constants.dart';
import '../../data/models/correct_answer.dart';
import '../app/game_provider.dart';
import '../sound_player/audio_file.dart';

class CorrectAnswerProvider extends GameProvider<CorrectAnswer> {
  int? level;
  BuildContext? context;

  CorrectAnswerProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(gameCategoryType: GameCategoryType.correctAnswer, c: context) {
    startGame(level: level);
  }

  Future<void> checkResult(String answer) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (timerStatus != TimerStatus.pause) {
      result = answer;
      notifyListeners();
      if (int.parse(result) == currentState.answer) {
        audioPlayer.playRightSound();
        rightAnswer();
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
    }
  }
}
