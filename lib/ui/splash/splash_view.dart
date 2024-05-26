import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puzzle/core/app_assets.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/ui/splash/animated_grid_item_view.dart';
import 'package:puzzle/utility/Constants.dart';
import 'package:tuple/tuple.dart';

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
              BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor
                  // gradient: SweepGradient(
                  //   center: Alignment.center,
                  //   startAngle: 0.0,
                  //   endAngle: pi * 2,
                  //   colors: [
                  //     Color(0xff4895EF),
                  //     Color(0xff3F37C9),
                  //   ],
                  //   transform: GradientRotation(pi / 2),
                  // ),
                  ),
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
          // child: ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: horizontalLine,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) => GridItemView(
          //     index: index,
          //     horizontalLine: horizontalLine,
          //     verticalLine: verticalLine,
          //   ),
          // ),
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

class GridItemView extends StatelessWidget {
  final double verticalLine;
  final int index;
  final int horizontalLine;

  const GridItemView({
    super.key,
    required this.index,
    required this.horizontalLine,
    required this.verticalLine,
  });

  @override
  Widget build(BuildContext context) {
    if ((horizontalLine / 2 - 1) <= index && (horizontalLine / 2 + 1) > index) {
      int tempIndex = (horizontalLine / 2 - 1) == index ? 0 : 1;
      return SizedBox(
        height: verticalLine,
        child: Row(
          children: [
            ...list[tempIndex]
                .map((e) => Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24, width: 0.5),
                        ),
                        child: (e == "<" || e == ">")
                            ? Text(
                                e,
                                style: TextStyle(
                                  color: Colors.white24.withOpacity(0.25),
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : Text(
                                e,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 28,
                                  fontFamily: "Poppins",
                                ),
                              ),
                      ),
                    ))

          ],
        ),
      );
    } else {
      int tempIndex = ((horizontalLine / 2 - 1) <= index &&
              (horizontalLine / 2 + 1) > index)
          ? index - 2
          : index;
      return SizedBox(
        height: verticalLine,
        child: Row(
          children: [
            ...list2[tempIndex]
                .map((e) => e.item1 == "."
                    ? Expanded(
                        child: AnimatedGridItemView(
                        duration: e.item2,
                      ))
                    : Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white24, width: 0.1),
                          ),
                          child: Text(
                            e.item1,
                            style: TextStyle(
                              color: Colors.white24.withOpacity(0.5),
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ))

          ],
        ),
      );
    }
  }
}

var list = [
  ["M", "A", "T", "H", "<", ">"],
  ["M", "A", "T", "R", "I", "X"],
];

var list2 = [
  [
    const Tuple2("+", 0),
    const Tuple2("0", 0),
    const Tuple2("8", 0),
    const Tuple2("1", 0),
    const Tuple2("7", 0),
    const Tuple2("*", 0)
  ],
  [
    const Tuple2("3", 0),
    const Tuple2("%", 0),
    const Tuple2("5", 0),
    const Tuple2("0", 0),
    const Tuple2("+", 0),
    const Tuple2("=", 0),
  ],
  [
    const Tuple2("*", 0),
    const Tuple2("3", 400),
    const Tuple2("~", 0),
    const Tuple2("4", 0),
    const Tuple2("-", 0),
    const Tuple2("2", 0),
  ],
  [
    const Tuple2("-", 0),
    const Tuple2("6", 0),
    const Tuple2("=", 0),
    const Tuple2("7", 1600),
    const Tuple2("~", 0),
    const Tuple2("9", 0),
  ],
  [
    const Tuple2("+", 0),
    const Tuple2("~", 0),
    const Tuple2("8", 0),
    const Tuple2("+", 0),
    const Tuple2("4", 0),
    const Tuple2("*", 0),
  ],
  [
    const Tuple2("3", 0),
    const Tuple2("%", 0),
    const Tuple2("5", 0),
    const Tuple2("0", 0),
    const Tuple2("+", 0),
    const Tuple2("=", 0),
  ],
  [
    const Tuple2("*", 0),
    const Tuple2("1", 0),
    const Tuple2("~", 0),
    const Tuple2("4", 0),
    const Tuple2("-", 0),
    const Tuple2("2", 0),
  ],
  [
    const Tuple2("3", 0),
    const Tuple2("%", 0),
    const Tuple2("5", 0),
    const Tuple2("0", 0),
    const Tuple2("+", 0),
    const Tuple2("=", 0),
  ],
  [
    const Tuple2("*", 0),
    const Tuple2("1", 0),
    const Tuple2("~", 0),
    const Tuple2("6", 2600),
    const Tuple2("-", 0),
    const Tuple2("2", 0),
  ],
  [
    const Tuple2("-", 0),
    const Tuple2("6", 0),
    const Tuple2("=", 0),
    const Tuple2("2", 0),
    const Tuple2("~", 0),
    const Tuple2("9", 0),
  ],
  [
    const Tuple2("/", 0),
    const Tuple2("1", 3200),
    const Tuple2("~", 0),
    const Tuple2("4", 0),
    const Tuple2("6", 0),
    const Tuple2("%", 0),
  ],
  [
    const Tuple2("~", 0),
    const Tuple2("2", 0),
    const Tuple2("5", 0),
    const Tuple2("*", 0),
    const Tuple2("+", 0),
    const Tuple2("5", 0),
  ],
  [
    const Tuple2("6", 0),
    const Tuple2("+", 0),
    const Tuple2("7", 0),
    const Tuple2("/", 0),
    const Tuple2("6", 0),
    const Tuple2("-", 0),
  ],
  [
    const Tuple2("3", 0),
    const Tuple2("%", 0),
    const Tuple2("4", 0),
    const Tuple2("~", 0),
    const Tuple2("*", 0),
    const Tuple2("2", 0),
  ],
  [
    const Tuple2("1", 0),
    const Tuple2("/", 0),
    const Tuple2("3", 0),
    const Tuple2("7", 0),
    const Tuple2("-", 0),
    const Tuple2("2", 0),
  ],
  [
    const Tuple2("-", 0),
    const Tuple2("8", 0),
    const Tuple2("=", 0),
    const Tuple2("%", 0),
    const Tuple2("/", 0),
    const Tuple2("7", 0),
  ],
  [
    const Tuple2("9", 0),
    const Tuple2("~", 0),
    const Tuple2("=", 0),
    const Tuple2("2", 0),
    const Tuple2("*", 0),
    const Tuple2("7", 0),
  ],
];
