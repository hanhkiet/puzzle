import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puzzle/core/app_assets.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/utility/Constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushReplacementNamed(context, KeyUtil.dashboard);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration:
              BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.splashIcon,
                height: getScreenPercentSize(context, 16),
              ),
              SizedBox(
                height: getScreenPercentSize(context, 2.3),
              ),
              getTextWidget(
                  Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold, fontFamily: 'Latinotype'),
                  'Maths Puzzle',
                  TextAlign.center,
                  getScreenPercentSize(context, 3.3))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }
}
