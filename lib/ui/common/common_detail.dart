import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utility/constants.dart';

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
        getTextWidget(
            Theme.of(context).textTheme.titleSmall!,
            "Right:".tr(args: [right.toString()]),
            TextAlign.center,
            getScreenPercentSize(context, 2)),
        SizedBox(
          height: getScreenPercentSize(context, 0.7),
        ),
        getTextWidget(
            Theme.of(context).textTheme.titleSmall!,
            "Wrong:".tr(args: [wrong.toString()]),
            TextAlign.center,
            getScreenPercentSize(context, 2)),
      ],
    );
  }
}
