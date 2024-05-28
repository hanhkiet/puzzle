import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzle/utility/constants.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AppAudioPlayer {
  BuildContext? context;

  final AudioPlayer _audioPlayer = AudioPlayer();

  bool? _isSound = true;
  bool? _isVibrate = true;

  AppAudioPlayer(BuildContext this.context) {
    setSound();
  }

  setSound() async {
    _isSound = await getSound();
    _isVibrate = await getVibration();
  }

  void playWrongSound() {
    playAudio(wrongSound);
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
        await _audioPlayer.play(AssetSource(s));
      } on Exception catch (_) {}
    }
  }

  void stopAudio() async {
    if (_isSound!) {
      await _audioPlayer.stop();
    }
  }
}
