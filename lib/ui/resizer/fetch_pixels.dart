import 'package:flutter/material.dart';

class FetchPixels {
  static double pixelRatio = 0;
  static double width = 0;
  static double height = 0;

  FetchPixels(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    pixelRatio = MediaQuery.of(context).devicePixelRatio;
  }

  static double getHeightPercentSize(double percent) {
    return (percent * height) / 100;
  }

  static double getWidthPercentSize(double percent) {
    return (percent * width) / 100;
  }

  static double getPixelWidth(double val) {
    return val / pixelRatio;
  }

  static double getPixelHeight(double val) {
    return val / pixelRatio;
  }

  static double getDefaultHorSpace(BuildContext context) {
    return FetchPixels.getPixelWidth(20);
  }

  static double getTextScale() {
    return 1 / pixelRatio;
  }

  static double getScale() {
    return pixelRatio;
  }
}
