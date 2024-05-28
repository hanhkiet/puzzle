import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/core/color_scheme.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:math' as math;
import '../../utility/Constants.dart';
import '../app/game_provider.dart';

class CommonTimerProgress<T extends GameProvider> extends StatelessWidget {
  const CommonTimerProgress({super.key, required this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<T>(context);
    double appBarHeight = getScreenPercentSize(context, 12);
    var circle = getScreenPercentSize(context, 12);
    var stepSize = getScreenPercentSize(context, 1.3);
    var margin = getWidthPercentSize(context, 2);
    // TODO: implement build
    return SizedBox(
      height: appBarHeight, // TODO
      child: Stack(
        children: [
          Container(
            width: double.infinity,
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 2,
                  color: color,
                  width: getWidthPercentSize(context, 30),
                ),
                SizedBox(
                  width: circle,
                ),
                Container(
                  height: 2,
                  color: color,
                  width: getWidthPercentSize(context, 30),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: (circle),
              height: (circle),
              child: Stack(
                children: [
                  CircularStepProgressIndicator(
                    totalSteps: KeyUtil.getTimeUtil(GameCategoryType.dualGame),
                    currentStep: model.currentTime,
                    stepSize: stepSize,
                    selectedColor: KeyUtil.backgroundColor1,
                    unselectedColor:
                        Theme.of(context).colorScheme.unSelectedProgressColor,
                    padding: 0,
                    width: circle,
                    height: circle,
                    selectedStepSize: stepSize,
                    roundedCap: (_, __) => true,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: math.pi,
                          child: getTextWidget(
                              Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                              secToTime(model.currentTime),
                              TextAlign.center,
                              getPercentSize(circle, 18)),
                        ),
                        Divider(
                          color: Colors.black,
                          height: 1,
                          endIndent: circle * 0.12,
                          indent: circle * 0.12,
                        ),
                        getTextWidget(
                            Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                            secToTime(model.currentTime),
                            TextAlign.center,
                            getPercentSize(circle, 18)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
