import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzle/utility/Constants.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AudioPlayer {
  BuildContext? context;

  AudioCache audioCache = AudioCache();

  bool? _isSound = true;
  bool? _isVibrate = true;

  AudioPlayer(BuildContext this.context) {
    setSound();
  }

  setSound() async {
    _isSound = await getSound();
    _isVibrate = await getVibration();
  }

  void playWrongSound() {
    if (_isVibrate!) {
      Vibrate.vibrate();
    }
  }

  void playGameOverSound() {
    playAudio(gameOverSound);
  }

  void playRightSound() {
    playAudio(rightSound);
  }

  void playTickSound() {
    playAudio(tickSound);
  }

  void playAudio(String s) async {
    if (_isSound!) {
      try {
        await audioCache.play(s);
      } on Exception catch (_) {}
    }
  }

  void stopAudio() async {
    if (_isSound!) {
      await audioCache.clearAll();
    }
  }
}
