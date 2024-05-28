import 'package:flutter/material.dart';
import 'package:puzzle/data/models/quick_calculation.dart';

import '../../utility/Constants.dart';

class QuickCalculationQuestionView extends StatefulWidget {
  final QuickCalculation currentState;
  final QuickCalculation nextCurrentState;
  final QuickCalculation? previousCurrentState;

  const QuickCalculationQuestionView({
    super.key,
    required this.currentState,
    required this.nextCurrentState,
    required this.previousCurrentState,
  });

  @override
  _QuickCalculationQuestionViewState createState() =>
      _QuickCalculationQuestionViewState();
}

class _QuickCalculationQuestionViewState
    extends State<QuickCalculationQuestionView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> alignmentTween;
  late Animation<double> _opacityAnimationOut;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    alignmentTween =
        Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.center)
            .animate(_controller);
    _opacityAnimationOut =
        Tween<double>(begin: 0.8, end: 0).animate(_controller);
  }

  @override
  void didUpdateWidget(QuickCalculationQuestionView oldWidget) {
    if (oldWidget.currentState != widget.currentState) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Align(
              alignment: alignmentTween.value,
              child: getTextWidget(
                  Theme.of(context).textTheme.titleSmall!,
                  widget.currentState.question,
                  TextAlign.center,
                  getPercentSize(getRemainHeight(context: context), 4)),
            );
          },
        ),
        Align(
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: _opacityAnimationOut,
            child: getTextWidget(
                Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
                widget.previousCurrentState?.question ?? "",
                TextAlign.center,
                getPercentSize(getRemainHeight(context: context), 4)),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
