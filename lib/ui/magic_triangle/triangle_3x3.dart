import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/ui/magic_triangle/triangle_input_button.dart';
import 'package:tuple/tuple.dart';

import 'magic_triangle_provider.dart';

class Triangle3x3 extends StatelessWidget {
  final double radius;
  final double padding;
  final double triangleHeight;
  final double triangleWidth;
  final Tuple2<Color, Color> colorTuple;

  const Triangle3x3({
    super.key,
    required this.radius,
    required this.padding,
    required this.triangleHeight,
    required this.triangleWidth,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);

    double remainHeight = triangleHeight;
    double height = remainHeight / 14;

    remainHeight = remainHeight - (height * 2.5);

    double cellHeight = remainHeight / 6;

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: TriangleInputButton(
              cellHeight: cellHeight,
              input: magicTriangleProvider.currentState.listTriangle[0],
              index: 0,
              colorTuple: colorTuple,
            ),
          ),
        ),
        Expanded(
            child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: TriangleInputButton(
                input: magicTriangleProvider.currentState.listTriangle[1],
                index: 1,
                colorTuple: colorTuple,
                cellHeight: cellHeight,
              )),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: TriangleInputButton(
                input: magicTriangleProvider.currentState.listTriangle[2],
                index: 2,
                colorTuple: colorTuple,
                cellHeight: cellHeight,
              )),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        )),
        Expanded(
            child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                  child: TriangleInputButton(
                input: magicTriangleProvider.currentState.listTriangle[3],
                index: 3,
                colorTuple: colorTuple,
                cellHeight: cellHeight,
              )),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: TriangleInputButton(
                input: magicTriangleProvider.currentState.listTriangle[4],
                index: 4,
                colorTuple: colorTuple,
                cellHeight: cellHeight,
              )),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: TriangleInputButton(
                input: magicTriangleProvider.currentState.listTriangle[5],
                index: 5,
                colorTuple: colorTuple,
                cellHeight: cellHeight,
              )),
            )
          ],
        )),
      ],
    );
  }
}
