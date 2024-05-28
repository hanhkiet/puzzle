import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../data/models/magic_triangle.dart';
import '../../utility/Constants.dart';
import '../common/common_traingle_view.dart';
import '../sound_player/audio_file.dart';
import 'magic_triangle_provider.dart';

class TriangleInputButton extends StatelessWidget {
  final MagicTriangleInput input;
  final int index;
  final double cellHeight;
  final Tuple2<Color, Color> colorTuple;

  const TriangleInputButton({
    super.key,
    required this.input,
    required this.cellHeight,
    required this.index,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context);
    // double height = remainHeight/10;
    double radius = getPercentSize(cellHeight, 25);

    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      onTap: () {
        audioPlayer.playTickSound();
        context
            .read<MagicTriangleProvider>()
            .inputTriangleSelection(index, input);
      },
      child: CommonTriangleView(
        isMargin: true,
        height: cellHeight,
        width: cellHeight,
        color: Colors.transparent,
        child: Container(
          decoration: input.value.isNotEmpty
              ? getDefaultDecorationWithGradient(
                  radius: radius,
                  colors: LinearGradient(
                    colors: [lighten(colorTuple.item1, 0.05), colorTuple.item1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ))
              : getDefaultDecoration(
                  radius: radius,
                  bgColor: colorTuple.item2,
                  borderColor: input.isActive ? colorTuple.item1 : null),
          alignment: Alignment.center,
          child: getTextWidget(
              Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              input.value.toString(),
              TextAlign.center,
              getPercentSize(cellHeight, 45)),
        ),
      ),
    );
  }
}
