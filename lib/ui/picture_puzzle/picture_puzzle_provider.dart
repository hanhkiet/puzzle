import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/picture_puzzle.dart';
import 'package:puzzle/ui/app/game_provider.dart';

import '../sound_player/audio_file.dart';

class PicturePuzzleProvider extends GameProvider<PicturePuzzle> {
  int? level;
  BuildContext? context;

  PicturePuzzleProvider(
      {required super.vsync,
      required int this.level,
      required BuildContext this.context})
      : super(gameCategoryType: GameCategoryType.PICTURE_PUZZLE, c: context) {
    startGame(level: level);
  }

  void checkGameResult(String answer) async {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context!);

    if (result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      result = result + answer;
      notifyListeners();
      if (int.parse(result) == currentState.answer) {
        audioPlayer.playRightSound();
        await Future.delayed(const Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level);
        currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);

        addCoin();

        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else if (result.length == currentState.answer.toString().length) {
        audioPlayer.playWrongSound();
        wrongAnswer();
        minusCoin();
      }
    }
  }

  void backPress() {
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
      notifyListeners();
    }
  }

  void clearResult() {
    result = "";
    notifyListeners();
  }
}
