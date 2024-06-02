import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/ui/app/language_provider.dart';
import 'package:puzzle/ui/resizer/fetch_pixels.dart';
import 'package:puzzle/ui/resizer/widget_utils.dart';
import 'package:puzzle/utility/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_assets.dart';
import 'app/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingScreen();
  }
}

class _SettingScreen extends State<SettingScreen> {
  void backClicks() {
    if (kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  ValueNotifier soundOn = ValueNotifier(false);
  ValueNotifier darkMode = ValueNotifier(false);
  ValueNotifier vibrateOn = ValueNotifier(false);
  ValueNotifier vietnamese = ValueNotifier(false);
  @override
  void initState() {
    super.initState();

    getSpeakerVol();
  }

  getSpeakerVol() async {
    soundOn.value = await getSound();
    vibrateOn.value = await getVibration();
    Future.delayed(Duration.zero, () {
      darkMode.value = Theme.of(context).brightness != Brightness.light;
    });
    vietnamese.value = appLocale == viLocale;
  }

  double fontTitleSize = 30;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    int selection = 1;

    Widget verSpace = SizedBox(height: FetchPixels.getPixelHeight(35));

    double margin = getHorizontalSpace(context);

    TextStyle theme = Theme.of(context).textTheme.titleSmall!;

    return PopScope(
      child: Scaffold(
        appBar: getNoneAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Column(
              children: [
                SizedBox(
                  height: getScreenPercentSize(context, 2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getDefaultIconWidget(context,
                        icon: AppAssets.backIcon,
                        folder: KeyUtil.themeYellowFolder, function: () {
                      backClicks();
                    }),
                    Expanded(
                        child: Center(
                            child: getCustomFont(
                                'Settings'.tr(), 35, theme.color!, 1,
                                fontWeight: FontWeight.w600))),
                  ],
                ),
                buildExpandedData(
                  selection,
                  verSpace,
                  context,
                )
              ],
            ),
          ),
        ),
      ),
      //TODO
      onPopInvoked: (didPop) {
        if (!didPop) {
          backClicks();
        }
      },
    );
  }

  Expanded buildExpandedData(
    int selection,
    Widget verSpace,
    BuildContext context,
  ) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          primary: true,
          shrinkWrap: true,
          children: [
            SizedBox(
              height: FetchPixels.getPixelHeight(30),
            ),
            verSpace,
            getTitleText("Sound".tr()),
            verSpace,
            SizedBox(
              height: FetchPixels.getPixelHeight(125),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelWidth(30)),
                      decoration: getDefaultDecoration(
                          radius: FetchPixels.getPixelHeight(30),
                          borderColor: Colors.grey,
                          bgColor: null),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: getSubTitleFonts("Sound".tr()),
                          ),
                          ValueListenableBuilder(
                            valueListenable: soundOn,
                            builder: (context, value, child) {
                              return FlutterSwitch(
                                value: soundOn.value,
                                inactiveColor: KeyUtil.backgroundColor2,
                                inactiveToggleColor: Colors.white,
                                activeColor: KeyUtil.primaryColor1,
                                width: FetchPixels.getPixelHeight(130),
                                height: FetchPixels.getPixelHeight(75),
                                onToggle: (val) {
                                  soundOn.value = val;
                                  setSound(val);
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  getHorSpace(FetchPixels.getDefaultHorSpace(context)),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelWidth(30)),
                      decoration: getDefaultDecoration(
                          radius: FetchPixels.getPixelHeight(30),
                          borderColor: Colors.grey,
                          bgColor: null),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: getSubTitleFonts("Vibration".tr()),
                          ),
                          ValueListenableBuilder(
                            valueListenable: vibrateOn,
                            builder: (context, value, child) {
                              return FlutterSwitch(
                                value: vibrateOn.value,
                                inactiveColor: KeyUtil.backgroundColor2,
                                inactiveToggleColor: Colors.white,
                                activeColor: KeyUtil.primaryColor1,
                                width: FetchPixels.getPixelHeight(130),
                                height: FetchPixels.getPixelHeight(75),
                                onToggle: (val) {
                                  vibrateOn.value = val;
                                  setVibration(val);
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verSpace,
            getDivider(),
            verSpace,
            getTitleText("Theme".tr()),
            verSpace,
            SizedBox(
              height: FetchPixels.getPixelHeight(125),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelWidth(30)),
                      decoration: getDefaultDecoration(
                          radius: FetchPixels.getPixelHeight(30),
                          borderColor: Colors.grey,
                          bgColor: null),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: getSubTitleFonts("Dark Mode".tr()),
                          ),
                          ValueListenableBuilder(
                            valueListenable: darkMode,
                            builder: (context, value, child) {
                              return FlutterSwitch(
                                value: darkMode.value,
                                inactiveColor: KeyUtil.backgroundColor2,
                                inactiveToggleColor: Colors.white,
                                activeColor: KeyUtil.primaryColor1,
                                width: FetchPixels.getPixelHeight(130),
                                height: FetchPixels.getPixelHeight(75),
                                onToggle: (val) {
                                  context.read<ThemeProvider>().changeTheme();
                                  darkMode.value = val;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  getHorSpace(FetchPixels.getDefaultHorSpace(context)),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
            verSpace,
            getDivider(),
            verSpace,
            getTitleText("Language".tr()),
            verSpace,
            SizedBox(
              height: FetchPixels.getPixelHeight(125),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelWidth(30)),
                      decoration: getDefaultDecoration(
                          radius: FetchPixels.getPixelHeight(30),
                          borderColor: Colors.grey,
                          bgColor: null),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: getSubTitleFonts("Vietnamese".tr()),
                          ),
                          ValueListenableBuilder(
                            valueListenable: vietnamese,
                            builder: (context, value, child) {
                              return FlutterSwitch(
                                value: vietnamese.value,
                                inactiveColor: KeyUtil.backgroundColor2,
                                inactiveToggleColor: Colors.white,
                                activeColor: KeyUtil.primaryColor1,
                                width: FetchPixels.getPixelHeight(130),
                                height: FetchPixels.getPixelHeight(75),
                                onToggle: (val) {
                                  context
                                      .read<LanguageProvider>()
                                      .changeLocale(context);
                                  vietnamese.value = val;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  getHorSpace(FetchPixels.getDefaultHorSpace(context)),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
            /*verSpace,
            getDivider(),
            getCell(
                string: "Share",
                function: () {
                  share();
                }),
            getDivider(),
            getCell(
                string: "Rate Us",
                function: () {
                  // LaunchReview.launch();

                  GradientModel model = GradientModel();
                  model.primaryColor = KeyUtil.primaryColor1;
                  showDialog<bool>(
                    context: context,
                    builder: (newContext) => CommonAlertDialog(
                      child: RateViewDialog(
                        colorTuple: Tuple2(model, 0),
                      ),
                    ),
                    barrierDismissible: false,
                  );
                }),
            getDivider(),
            getCell(
                string: "Feedback",
                function: () async {
                  GradientModel model = GradientModel();
                  model.primaryColor = KeyUtil.primaryColor1;

                  showDialog<bool>(
                    context: context,
                    builder: (newContext) => CommonAlertDialog(
                      child: RateViewDialog(
                        colorTuple: Tuple2(model, 0),
                      ),
                    ),
                    barrierDismissible: false,
                  );

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen(),));
                  // final Email email = Email(
                  //   body: 'Math Matrix',
                  //   subject: "Feedback",
                  //   recipients: ['demo@gmail.com'],
                  //   isHTML: false,
                  // );
                  // await FlutterEmailSender.send(email);
                }),
            getDivider(),
            getCell(
                string: "Privacy Policy",
                function: () async {
                  _launchURL();
                }),*/
          ],
        ),
      ),
    );
  }

  share() async {
    await FlutterShare.share(
        title: 'Math Puzzle',
        text: getAppLink(),
        linkUrl: '',
        chooserTitle: 'Share'.tr());
  }

  getCell({required String string, required Function function}) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(45)),
        child: Row(
          children: [
            Expanded(
              child: getTitleText(string),
              flex: 1,
            ),
            Icon(Icons.navigate_next,
                color: Theme.of(context).textTheme.titleMedium!.color)
          ],
        ),
      ),
    );
  }

  Widget getDivider() {
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(50)),
      color: Colors.grey.shade300,
      height: 0.5,
    );
  }

  Widget getSubTitleFonts(String titles) {
    TextStyle theme = Theme.of(context).textTheme.titleSmall!;
    return getCustomFont(titles, fontTitleSize, theme.color!, 1,
        fontWeight: FontWeight.w500, textAlign: TextAlign.start);
  }

  getTitleText(String string) {
    TextStyle theme = Theme.of(context).textTheme.titleSmall!;
    return getCustomFont(string, 30, theme.color!, 1,
        fontWeight: FontWeight.w600);
  }
}
