import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../app/game_provider.dart';

class CommonLinearPercentIndicator<T extends GameProvider>
    extends StatelessWidget {
  final double lineHeight;
  final LinearGradient linearGradient;
  final Color backgroundColor;

  const CommonLinearPercentIndicator({
    this.lineHeight = 5.0,
    required this.linearGradient,
    this.backgroundColor = Colors.black12,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      padding: EdgeInsets.zero,
      lineHeight: lineHeight,
      percent: 1,
      // percent:model.currentTime/model.totalTime,
      animateFromLastPercent: true,
      animation: true,
      linearGradient: linearGradient,
      backgroundColor: backgroundColor,
    );
  }
}
