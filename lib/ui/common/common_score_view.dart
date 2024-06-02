import 'package:flutter/material.dart';

import '../../utility/constants.dart';

class CommonScoreView extends StatefulWidget {
  final int currentScore;
  final int oldScore;

  const CommonScoreView({
    super.key,
    required this.currentScore,
    required this.oldScore,
  });

  @override
  State<CommonScoreView> createState() => _CommonScoreViewState();
}

class _CommonScoreViewState extends State<CommonScoreView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<Offset> inAnimation;
  late final Animation<Offset> outAnimation;
  late final Animation<double> _opacityAnimationOut;
  late final Animation<double> _opacityAnimationIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    inAnimation = Tween<Offset>(
            begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        1.0,
        curve: Curves.easeIn,
      ),
    ));

    outAnimation = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(0.0, -1.0))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        1.0,
        curve: Curves.easeIn,
      ),
    ));

    _opacityAnimationOut = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.4,
        0.8,
        curve: Curves.easeIn,
      ),
    ));

    _opacityAnimationIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.4,
        0.8,
        curve: Curves.easeOut,
      ),
    ));
  }

  @override
  void didUpdateWidget(CommonScoreView oldWidget) {
    if (oldWidget.currentScore != widget.currentScore) {
      if (oldWidget.currentScore < widget.currentScore) {
        _controller.forward(from: 0.0);
      } else {
        _controller.reverse(from: 1.0);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double height = getScreenPercentSize(context, 6);
    return Stack(
      alignment: Alignment.center,
      children: [
        SlideTransition(
          position: inAnimation,
          child: FadeTransition(
            opacity: _opacityAnimationIn,
            child: getTextWidget(
                Theme.of(context).textTheme.titleSmall!,
                widget.oldScore < widget.currentScore
                    ? widget.currentScore.toString()
                    : widget.oldScore.toString(),
                TextAlign.center,
                getPercentSize(height, 40)),
          ),
        ),
        SlideTransition(
          position: outAnimation,
          child: FadeTransition(
              opacity: _opacityAnimationOut,
              child: getTextWidget(
                  Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                  widget.oldScore > widget.currentScore
                      ? widget.currentScore.toString()
                      : widget.oldScore.toString(),
                  TextAlign.center,
                  getPercentSize(height, 40))),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
