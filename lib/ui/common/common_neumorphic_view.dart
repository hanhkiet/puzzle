import 'package:flutter/material.dart';

import '../../utility/constants.dart';

// Text Form Field hiển thị đáp án
class CommonNeumorphicView extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final bool isLarge;
  final bool isMargin;
  final Color color;

  const CommonNeumorphicView({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.color = Colors.red,
    this.isLarge = false,
    this.isMargin = false,
  });

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double size = getPercentSize(remainHeight, 8.5);
    return Container(
      height: height ?? size,
      width: width ?? (isLarge ? null : size),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: isMargin
              ? getWidthPercentSize(context, 2)
              : (getHorizontalSpace(context) * 2.5)),
      decoration: getDefaultDecoration(
          bgColor: color,
          borderColor: Theme.of(context).textTheme.titleSmall!.color,
          borderWidth: 1.3,
          radius: getPercentSize(height!, 20)),
      child: child,
    );
  }
}
