import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/core/color_scheme.dart';
import 'package:puzzle/data/models/number_pyramid.dart';
import 'package:puzzle/ui/number_pyramid/number_pyramid_provider.dart';
import 'package:puzzle/utility/constants.dart';
import 'package:tuple/tuple.dart';

class PyramidNumberButton extends StatelessWidget {
  final NumPyramidCellModel numPyramidCellModel;
  final bool isLeftRadius;
  final bool isRightRadius;
  final double height;
  final double buttonHeight;
  final Tuple2<Color, Color> colorTuple;

  const PyramidNumberButton({
    super.key,
    required this.numPyramidCellModel,
    this.isLeftRadius = false,
    this.isRightRadius = false,
    required this.height,
    required this.buttonHeight,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    final numberProvider = Provider.of<NumberPyramidProvider>(context);

    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = getWidthPercentSize(context, 100) / 8.5;
    double btnHeight = (buttonHeight / 10);
    double fontSize = getPercentSize(btnHeight, 23);

    if (kDebugMode) {
      print("screenSize ====$screenWidth-----$screenHeight--${(btnHeight)}");
    }
    if (screenHeight < screenWidth) {
      fontSize = getPercentSize((btnHeight), 30);
      //   fontSize = getScreenPercentSize(context, 1);
    }

    return InkWell(
      onTap: () {
        numberProvider.pyramidBoxSelection(numPyramidCellModel);
      },
      child: Container(
        height: btnHeight,
        width: width,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          gradient: numPyramidCellModel.isHint
              ? LinearGradient(
                  colors: [
                    colorTuple.item1,
                    colorTuple.item1,
                    // darken(colorTuple.item1,0.1)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: numPyramidCellModel.isHint
              ? null
              : (numPyramidCellModel.isDone
                  ? (numPyramidCellModel.isCorrect
                      ? Colors.transparent
                      : Colors.redAccent)
                  : Colors.transparent),
          shape: SmoothRectangleBorder(
            side: BorderSide(
                color: numPyramidCellModel.isActive
                    ? darken(KeyUtil.backgroundColor3, 0.5)
                    : Theme.of(context).colorScheme.triangleLineColor,
                width: numPyramidCellModel.isActive ? 1.2 : 0.8),
            borderRadius: SmoothBorderRadius(
              cornerRadius: getPercentSize(height, 30),
            ),
          ),
        ),
        child: getTextWidget(
            Theme.of(context).textTheme.titleSmall!.copyWith(
                color: numPyramidCellModel.isHint
                    ? Colors.white
                    : colorTuple.item1)
            //
            ,
            numPyramidCellModel.isHidden
                ? numPyramidCellModel.text
                : numPyramidCellModel.numberOnCell.toString(),
            TextAlign.center,
            fontSize),
      ),
    );
  }
}
