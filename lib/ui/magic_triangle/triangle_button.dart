import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../data/models/magic_triangle.dart';
import '../../utility/Constants.dart';
import '../sound_player/audio_file.dart';
import 'magic_triangle_provider.dart';

class TriangleButton extends StatelessWidget {
  final MagicTriangleGrid digit;
  final int index;
  final bool is3x3;
  final Tuple2<Color, Color> colorTuple;

  const TriangleButton({
    super.key,
    required this.colorTuple,
    required this.digit,
    required this.index,
    required this.is3x3,
  });

  @override
  Widget build(BuildContext context) {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context);

    double remainHeight = getRemainHeight(context: context);
    double height = remainHeight / 11;

    if (!is3x3) {
      height = remainHeight / 14;
    }
    double radius = getPercentSize(height, 25);

    return Visibility(
      visible: digit.isVisible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: InkWell(
        onTap: () {
          audioPlayer.playTickSound();
          context.read<MagicTriangleProvider>().checkResult(index, digit);
        },
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: height,
          width: height,
          decoration: getDefaultDecorationWithBorder(
              radius: radius, borderColor: colorTuple.item1),
          alignment: Alignment.center,
          child: getTextWidget(
              Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              digit.value,
              TextAlign.center,
              getPercentSize(height, 40)),
        ),
      ),
    );
  }
}
