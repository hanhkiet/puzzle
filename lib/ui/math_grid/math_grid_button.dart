import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:puzzle/core/app_constants.dart';

import 'package:tuple/tuple.dart';

import '../../data/models/math_grid.dart';
import '../../utility/Constants.dart';
import '../app/theme_provider.dart';
import '../sound_player/audio_file.dart';
import 'math_grid_provider.dart';

class MathGridButton extends StatelessWidget {
  final MathGridCellModel gridModel;
  final int index;
  final Tuple2<Color, Color> colorTuple;

  const MathGridButton({
    super.key,
    required this.gridModel,
    required this.index,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    AppAudioPlayer audioPlayer = AppAudioPlayer(context);

    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = screenWidth / 9;
    double fontSize = getPercentSize(width, 40);

    print("screenSize ====$screenWidth-----$screenHeight");
    if (screenHeight < screenWidth) {
      width = getScreenPercentSize(context, 0.3);
      fontSize = getScreenPercentSize(context, 1.7);
      print("width ====$width---${getPercentSize(width, 100)}");
    }

    Color color = "#383838".toColor();

    // if (themeMode == ThemeMode.light) {
    color = colorTuple.item2;
    // }

    return Container(
      decoration: getDefaultDecoration(
          bgColor: gridModel.isRemoved
              ? Colors.transparent
              : gridModel.isActive
                  ? Theme.of(context).scaffoldBackgroundColor
                  : color,
          borderColor: Theme.of(context).textTheme.titleSmall!.color,
          radius: getScreenPercentSize(context, 2)),

      // decoration: BoxDecoration(
      //     border: Border.all(color: Theme.of(context).textTheme.subtitle2!.color!, width:1),
      //     color: gridModel.isRemoved
      //         ? color
      //         : (gridModel.isActive
      //             ? color
      //             : Colors.transparent),
      // ),
      child: Visibility(
        visible: !(gridModel.isRemoved),
        child: InkWell(
          onTap: () {
            audioPlayer.playTickSound();
            context.read<MathGridProvider>().checkResult(index, gridModel);
          },
          child: Center(
            child: getTextWidget(
              Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: gridModel.isActive
                      ? themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white
                      : Colors.black),
              gridModel.value.toString(),
              TextAlign.center,
              fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
