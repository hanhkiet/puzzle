import 'package:flutter/material.dart';
import 'package:puzzle/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../sound_player/audio_file.dart';
import 'common_tab_animation_view.dart';

class CommonDualButton extends StatelessWidget {
  final Function onTab;
  final String text;

  final double totalHeight;
  final double height;
  final double fontSize;
  final bool is4Matrix;
  final bool isDarken;

  final Tuple2<GradientModel, int> colorTuple;

  const CommonDualButton({
    super.key,
    required this.text,
    required this.onTab,
    this.is4Matrix = false,
    this.isDarken = true,
    this.fontSize = 24,
    this.height = 24,
    this.totalHeight = 24,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context);

    double radius = getCommonCalculatorRadius(context);
    // double radius = getCommonRadius(context);

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
                radius: radius,
                borderColor: Theme.of(context).textTheme.titleMedium!.color,
                borderWidth: 1.3,
                bgColor: colorTuple.item1.backgroundColor!),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Transform.translate(
                      offset: Offset(-constraints.maxHeight / 2.1, 15),
                      child: Transform.scale(
                        scale: is4Matrix
                            ? constraints.maxHeight / 5
                            : constraints.maxHeight / 20,
                        alignment: Alignment.topCenter,
                        child: getTextWidget(
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.white.withOpacity(0.1),
                                fontWeight: FontWeight.bold),
                            text,
                            TextAlign.center,
                            is4Matrix
                                ? getPercentSize(height, 2)
                                : getPercentSize(height, 15)),
                      ),
                    );
                  }),
                ),
                Align(
                  alignment: Alignment.center,
                  child: getTextWidget(
                      Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      text,
                      TextAlign.center,
                      getPercentSize(height, 20)),
                ),
              ],
            )),
      ),
    );
  }
}
