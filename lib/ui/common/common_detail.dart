import 'package:flutter/material.dart';

import '../../utility/Constants.dart';

class CommonDetail extends StatelessWidget {
  final int? right;
  final int? wrong;

  const CommonDetail({
    super.key,
    required this.right,
    required this.wrong,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTextWidget(Theme.of(context).textTheme.titleSmall!, 'Right: $right',
            TextAlign.center, getScreenPercentSize(context, 2)),
        SizedBox(
          height: getScreenPercentSize(context, 0.7),
        ),
        getTextWidget(Theme.of(context).textTheme.titleSmall!, 'Wrong: $wrong',
            TextAlign.center, getScreenPercentSize(context, 2)),
      ],
    );
  }
}