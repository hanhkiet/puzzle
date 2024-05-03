import 'package:flutter/material.dart';
import 'package:puzzle/core/color_scheme.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../model/gradient_model.dart';
import '../soundPlayer/audio_file.dart';
import 'common_tab_animation_view.dart';

class CommonVerticalButton extends StatelessWidget {
  final Function onTab;
  final String text;

  final double totalHeight;
  final double height;
  final double fontSize;
  final bool is4Matrix;
  final bool isDarken;
  final bool isNumber;

  final Tuple2<GradientModel, int> colorTuple;

  const CommonVerticalButton({
    super.key,
    required this.text,
    required this.onTab,
    this.isNumber = false,
    this.is4Matrix = false,
    this.isDarken = true,
    this.fontSize = 24,
    this.height = 24,
    this.totalHeight = 24,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer(context);
    double height1 = getScreenPercentSize(context, 57);
    double height = getScreenPercentSize(context, 57) / 4;

    double radius = getCommonRadius(context);

    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: getPercentSize(height1, 2.5),
            horizontal: (getHorizontalSpace(context))),
        child: CommonTabAnimationView(
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
                    // bgColor: "#FFDB7C".toColor(),
                    bgColor: colorTuple.item1.backgroundColor,
                    radius: radius,
                    borderColor: Theme.of(context).colorScheme.crossColor,
                    borderWidth: 1.2),
                margin: EdgeInsets.symmetric(
                    horizontal: getWidthPercentSize(context, 2), vertical: 2),
                // decoration: getDefaultDecorationWithGradient(radius: radius,bgColor:
                // colorTuple.item1.primaryColor!,isShadow: true,colors: LinearGradient(
                //   colors:
                //   [ colorTuple.item1.primaryColor!,darken(colorTuple.item1.primaryColor!,0.1)],
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                // )),
                child: Center(
                  child: getTextWidget(
                      Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      text,
                      TextAlign.center,
                      // ignore: unnecessary_null_comparison
                      isNumber == null
                          ? getPercentSize(height, 28)
                          : getPercentSize(height, 20)),
                )),
          ),
        ),
      ),
    );
  }
}
