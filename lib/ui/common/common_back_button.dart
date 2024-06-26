import 'package:flutter/material.dart';

import '../../utility/constants.dart';
import '../sound_player/audio_file.dart';
import 'common_tab_animation_view.dart';

class CommonBackButton extends StatelessWidget {
  final Function onTab;
  final double height;
  final double? btnRadius;

  const CommonBackButton({
    super.key,
    required this.onTab,
    this.btnRadius,
    this.height = 112,
  });

  @override
  Widget build(BuildContext context) {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context);

    double radius = btnRadius ?? getCommonCalculatorRadius(context);

    return CommonTabAnimationView(
        onTab: () {
          onTab();
          audioPlayer.playTickSound();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            alignment: Alignment.center,
            // height: height,

            decoration: getDefaultDecoration(
                bgColor: Colors.white,
                radius: radius,
                borderColor: Theme.of(context).textTheme.titleMedium!.color,
                borderWidth: 1.2),
            margin: EdgeInsets.symmetric(
                horizontal: getWidthPercentSize(context, 2), vertical: 2),

            child: Center(
              child: Icon(
                Icons.backspace,
                size: getPercentSize(height, 20),
                color: Colors.black,
              ),
            ),
          ),
        ));
  }
}
