import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_assets.dart';
import '../../core/app_constants.dart';
import '../../utility/constants.dart';
import '../app/game_provider.dart';

class CommonInfoTextView<T extends GameProvider> extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final Color color;
  final String folder;

  Color increaseColorLightness(Color color, double increment) {
    var hslColor = HSLColor.fromColor(color);
    var newValue = min(max(hslColor.lightness + increment, 0.0), 1.0);
    return hslColor.withLightness(newValue).toColor();
  }

  const CommonInfoTextView({
    required this.gameCategoryType,
    required this.color,
    required this.folder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: getScreenPercentSize(context, 1)),
      child: Consumer<T>(builder: (context, provider, child) {
        return getDefaultIconWidget(context,
            icon: AppAssets.infoIcon, folder: folder, function: () {
          provider.showInfoDialog();
        });
      }),
    );
  }
}
