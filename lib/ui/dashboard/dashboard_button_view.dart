import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/app_assets.dart';
import '../../data/models/dashboard.dart';
import '../../utility/constants.dart';
import '../app/theme_provider.dart';
import '../common/common_tab_animation_view.dart';

class DashboardButtonView extends StatelessWidget {
  final Function onTab;
  final Animation<Offset> position;
  final Dashboard dashboard;
  final double margin;

  const DashboardButtonView({
    super.key,
    required this.position,
    required this.onTab,
    required this.dashboard,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    // double height = FetchPixels.getPixelWidth( );
    double height = getWidthPercentSize(context, 42);
    double circle = getPercentSize(height, 42);
    double iconSize = getPercentSize(circle, 62);

    if (kDebugMode) {
      print(
          "dashboard-----${AppAssets.assetFolderPath + dashboard.folder + AppAssets.homeIcon}");
    }
    // print(
    //     "themeProvider---${themeProvider.folderName}---${themeMode}");
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return CommonTabAnimationView(
          onTab: onTab,
          isDelayed: true,
          child: SlideTransition(
            position: position,
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: Stack(
                children: [
                  SizedBox(
                    height: height,
                    width: double.infinity,
                    child: SvgPicture.asset(
                      '${getFolderName(context, dashboard.folder)}${AppAssets.homeCellBg}',
                      // '${getCurrentThemePath(value.themeMode)}${dashboard.bgIcon}',
                      height: height,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: getWidthPercentSize(context, 6),
                        ),
                        Container(
                          height: circle,
                          width: circle,
                          decoration: getDefaultDecoration(
                              bgColor: Colors.white,
                              radius: getPercentSize(circle, 24)),
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.assetFolderPath +
                                  dashboard.folder +
                                  AppAssets.homeIcon,
                              width: iconSize,
                              height: iconSize,
                            ),
                          ),
                        ),
                        SizedBox(width: getWidthPercentSize(context, 4.5)),
                        getTextWidget(
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            dashboard.title.tr(),
                            TextAlign.center,
                            getPercentSize(height, 12))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
