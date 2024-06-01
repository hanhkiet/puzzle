import 'package:easy_localization/easy_localization.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/game_info_dialog.dart';
import 'package:tuple/tuple.dart';

class DialogInfoUtil {
  static GameInfoDialog getInfoDialogData(GameCategoryType gameCategoryType) {
    var tuple1 = Tuple2(KeyUtil.primaryColor1, KeyUtil.bgColor1);
    var tuple2 = Tuple2(KeyUtil.primaryColor2, KeyUtil.bgColor2);
    var tuple3 = Tuple2(KeyUtil.primaryColor3, KeyUtil.bgColor3);
    switch (gameCategoryType) {
      case GameCategoryType.calculator:
        return GameInfoDialog(
            title: "Calculator".tr(),
            image: "assets/gif/calculator-intro.gif",
            dec: "You need to solve given equation correctly.".tr(),
            correctAnswerScore: KeyUtil.calculatorScore,
            wrongAnswerScore: KeyUtil.calculatorScoreMinus,
            colorTuple: tuple1);
      case GameCategoryType.guessSign:
        return GameInfoDialog(
            title: "Guess The Sign".tr(),
            image: "assets/gif/whats-the-sign-intro.gif",
            dec:
                "You need to find correct sign that finishes the given equation."
                    .tr(),
            correctAnswerScore: KeyUtil.guessSignScore,
            wrongAnswerScore: KeyUtil.guessSignScoreMinus,
            colorTuple: tuple1);
      case GameCategoryType.squareRoot:
        return GameInfoDialog(
            title: "Square Root".tr(),
            image: "assets/gif/sqroot-intro.gif",
            dec: "Square root the given number.".tr(),
            correctAnswerScore: KeyUtil.squareRootScore,
            wrongAnswerScore: KeyUtil.squareRootScoreMinus,
            colorTuple: tuple2);

      case GameCategoryType.findMissing:
        return GameInfoDialog(
            title: "Find Missing".tr(),
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.".tr(),
            correctAnswerScore: KeyUtil.findMissingScore,
            wrongAnswerScore: KeyUtil.findMissingScoreMinus,
            colorTuple: tuple1);
      case GameCategoryType.trueFalse:
        return GameInfoDialog(
            title: "True False".tr(),
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.".tr(),
            correctAnswerScore: KeyUtil.trueFalseScore,
            wrongAnswerScore: KeyUtil.trueFalseScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.dualGame:
        return GameInfoDialog(
            title: "Dual Game".tr(),
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.".tr(),
            correctAnswerScore: KeyUtil.dualScore,
            wrongAnswerScore: KeyUtil.dualScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.complexCalculation:
        return GameInfoDialog(
            title: "Complex Calculation".tr(),
            image: "assets/gif/whats-the-sign-intro.gif",
            dec:
                "You need to find correct sign that finishes the given equation."
                    .tr(),
            correctAnswerScore: KeyUtil.complexCalculationScore,
            wrongAnswerScore: KeyUtil.complexCalculationScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.cubeRoot:
        return GameInfoDialog(
            title: "Cube Root".tr(),
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.".tr(),
            correctAnswerScore: KeyUtil.cubeRootScore,
            wrongAnswerScore: KeyUtil.cubeRootScoreMinus,
            colorTuple: tuple1);

      case GameCategoryType.numericMemory:
        return GameInfoDialog(
            title: "Numeric Memory".tr(),
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.".tr(),
            correctAnswerScore: KeyUtil.numericMemoryScore,
            wrongAnswerScore: KeyUtil.numericMemoryScoreMinus,
            plusSeconds: 2,
            colorTuple: tuple1);
      case GameCategoryType.concentration:
        return GameInfoDialog(
            title: "Concentration".tr(),
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.".tr(),
            correctAnswerScore: KeyUtil.concentrationScore,
            wrongAnswerScore: KeyUtil.concentrationScoreMinus,
            colorTuple: tuple1);
      case GameCategoryType.mathPairs:
        return GameInfoDialog(
            title: "Math Pairs".tr(),
            image: "assets/gif/math-pair-intro.gif",
            dec:
                "Each card contains either equation or an answer. Match the equation with correct answer."
                    .tr(),
            correctAnswerScore: KeyUtil.mathematicalPairsScore,
            wrongAnswerScore: KeyUtil.mathematicalPairsScoreMinus,
            colorTuple: tuple2);
      case GameCategoryType.correctAnswer:
        return GameInfoDialog(
            title: "Correct Answer".tr(),
            image: "assets/gif/correct-answer.gif",
            dec: "Select the correct number to finish the equation.".tr(),
            correctAnswerScore: KeyUtil.correctAnswerScore,
            wrongAnswerScore: KeyUtil.correctAnswerScoreMinus,
            colorTuple: tuple1);
      case GameCategoryType.magicTriangle:
        return GameInfoDialog(
          title: "Magic Triangle".tr(),
          image: "assets/gif/magic-triangle-intro.gif",
          dec:
              "Sum of the each side of triangle should be equal to the given number. To place any number, select triangle circle and press any given number from panel."
                  .tr(),
          correctAnswerScore: KeyUtil.magicTriangleScore,
          colorTuple: tuple3,
          wrongAnswerScore: KeyUtil.magicTriangleScore,
        );
      case GameCategoryType.mentalArithmetic:
        return GameInfoDialog(
          title: "Mental Arithmetic".tr(),
          colorTuple: tuple2,
          image: "assets/gif/mental-arith-intro.gif",
          dec:
              "Number with operator will be shown one by one. You need to remember the number with operator and write final answer(No precedency)."
                  .tr(),
          correctAnswerScore: KeyUtil.mentalArithmeticScore,
          wrongAnswerScore: KeyUtil.mentalArithmeticScoreMinus,
        );
      case GameCategoryType.quickCalculation:
        return GameInfoDialog(
          title: "Quick Calculation".tr(),
          colorTuple: tuple1,
          image: "assets/gif/quick-calculation-intro.gif",
          dec:
              "Solve simple equation one by one. Faster you solve, more time will be given to solve next equation."
                  .tr(),
          correctAnswerScore: KeyUtil.quickCalculationScore,
          plusSeconds: 1,
          wrongAnswerScore: KeyUtil.quickCalculationScoreMinus,
        );
      case GameCategoryType.mathGrid:
        return GameInfoDialog(
          title: "Math Grid".tr(),
          colorTuple: tuple2,
          image: "assets/gif/math-machine-intro.gif",
          dec:
              "Select number from math grid to reach answer shown above. You can select any number to reach above answer."
                  .tr(),
          correctAnswerScore: KeyUtil.mathGridScore,
          wrongAnswerScore: KeyUtil.mathGridScore,
        );
      case GameCategoryType.picturePuzzle:
        return GameInfoDialog(
          title: "Picture Puzzle".tr(),
          colorTuple: tuple3,
          image: "assets/gif/picture-puzzle-intro.gif",
          dec:
              "Each shape represents a number. Find the number of each shape from given equation and solve the last equation."
                  .tr(),
          correctAnswerScore: KeyUtil.picturePuzzleScore,
          wrongAnswerScore: KeyUtil.picturePuzzleScore,
        );
      case GameCategoryType.numberPyramid:
        return GameInfoDialog(
          title: "Number Pyramid".tr(),
          colorTuple: tuple3,
          image: "assets/gif/num-pyramid.gif",
          dec:
              "sum of consecutive cell should be placed on top cell. You need to fill all cell correctly to solve Number pyramid."
                  .tr(),
          correctAnswerScore: KeyUtil.numberPyramidScore,
          wrongAnswerScore: KeyUtil.numberPyramidScore,
        );
    }
  }
}
