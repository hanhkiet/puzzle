import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:puzzle/core/app_assets.dart';

import '../../utility/constants.dart';
import 'fetch_pixels.dart';

void showCustomToast(String texts, BuildContext context) {
  Fluttertoast.showToast(
      msg: texts,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0);
}

Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}

Widget getSvgImageWithSize(
    BuildContext context, String image, double width, double height,
    {Color? color, BoxFit fit = BoxFit.fill}) {
  return SvgPicture.asset(
    AppAssets.assetPath + image,
    colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
    width: width,
    height: height,
    fit: fit,
  );
}

double getEditFontSize() {
  return 35;
}

double getEditHeight() {
  return FetchPixels.getPixelHeight(130);
}

double getEditRadiusSize() {
  return FetchPixels.getPixelHeight(35);
}

Widget getSvgImage(BuildContext context, String image, double size,
    {Color? color}) {
  return SvgPicture.asset(
    AppAssets.assetPath + image,
    colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
    width: FetchPixels.getPixelWidth(size),
    height: FetchPixels.getPixelHeight(size),
    fit: BoxFit.fill,
  );
}

double getEditIconSize() {
  return 55;
}

Widget getDefaultTextFiled(
    BuildContext context,
    String s,
    TextEditingController textEditingController,
    Color fontColor,
    Color selectedTheme,
    {bool withPrefix = false,
    String imgName = "",
    bool minLines = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    TextInputType type = TextInputType.text}) {
  double height = getEditHeight();
  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew = mqData.copyWith(
          textScaler: TextScaler.linear(FetchPixels.getTextScale()));
      return MediaQuery(
        data: mqDataNew,
        child: Container(
          height: (minLines) ? (height * 2.2) : height,
          margin: margin,
          padding: EdgeInsets.symmetric(
              horizontal: FetchPixels.getPixelWidth(18), vertical: 0),
          alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
          decoration: ShapeDecoration(
            color: Colors.transparent,
            shape: SmoothRectangleBorder(
              side: BorderSide(
                  color: isAutoFocus ? selectedTheme : Colors.grey, width: 1),
              borderRadius: SmoothBorderRadius(
                cornerRadius: getEditRadiusSize(),
                cornerSmoothing: 0.8,
              ),
            ),
          ),
          child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    isAutoFocus = true;
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    isAutoFocus = false;
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: SizedBox(
                height: double.infinity,
                child: (minLines)
                    ? TextField(
                        maxLines: (minLines) ? null : 1,
                        controller: textEditingController,
                        autofocus: false,
                        focusNode: myFocusNode,
                        textAlign: TextAlign.start,
                        keyboardType: type,
                        expands: minLines,
                        style: TextStyle(
                            fontFamily: fontFamily,
                            color: fontColor,
                            fontWeight: FontWeight.w500,
                            fontSize: getEditFontSize()),
                        decoration: InputDecoration(
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            prefixIcon: (withPrefix)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right: FetchPixels.getPixelWidth(3)),
                                    child: getSvgImage(
                                        context, imgName, getEditIconSize()),
                                  )
                                : getHorSpace(0),
                            border: InputBorder.none,
                            isDense: true,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: s,
                            // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
                            hintStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getEditFontSize())),
                      )
                    : Center(
                        child: TextField(
                        maxLines: (minLines) ? null : 1,
                        keyboardType: type,
                        controller: textEditingController,
                        autofocus: false,
                        focusNode: myFocusNode,
                        textAlign: TextAlign.start,
                        expands: minLines,
                        style: TextStyle(
                            fontFamily: fontFamily,
                            color: fontColor,
                            fontWeight: FontWeight.w500,
                            fontSize: getEditFontSize()),
                        decoration: InputDecoration(
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            prefixIcon: (withPrefix)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right: FetchPixels.getPixelWidth(3)),
                                    child: getSvgImage(
                                        context, imgName, getEditIconSize()),
                                  )
                                : getHorSpace(0),
                            border: InputBorder.none,
                            isDense: true,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: s,
                            hintStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getEditFontSize())),
                      )),
              )),
        ),
      );
    },
  );
}

Widget getCustomFont(String text, double fontSize, Color fontColor, int maxLine,
    {TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
  );
}

Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}
