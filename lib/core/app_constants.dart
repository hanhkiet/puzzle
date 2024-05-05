import 'package:flutter/material.dart';
import 'package:puzzle/core/app_assets.dart';
import 'package:puzzle/data/models/dashboard.dart';
import 'package:tuple/tuple.dart';

enum GameCategoryType {
  calculator,
  guessSign,
  squareRoot,
  mathPairs,
  correctAnswer,
  magicTriangle,
  mentalArithmetic,
  quickCalculation,
  findMissing,
  trueFalse,
  mathGrid,
  picturePuzzle,
  numberPyramid,
  dualGame,
  complexCalculation,
  cubeRoot,
  concentration,
  numericMemory,
}

enum PuzzleType {
  mathPuzzle,
  memoryPuzzle,
  brainPuzzle,
}

enum TimerStatus {
  restart,
  play,
  pause,
}

enum DialogType {
  non,
  info,
  over,
  pause,
  exit,
  hint,
}

class KeyUtil {
  static const isDarkMode = "isDarkMode";

  static const String splash = 'Splash';
  static const String dashboard = 'Dashboard';
  static const String home = 'Home';
  static const String level = 'Level';
  static const String dual = 'Dual';

  static const String calculator = 'Calculator';
  static const String guessSign = 'GuessSign';
  static const String trueFalse = 'TrueFalse';
  static const String dualGame = 'dualGame';
  static const String complexCalculation = 'complexCalculation';
  static const String correctAnswer = 'CorrectAnswer';
  static const String quickCalculation = 'QuickCalculation';
  static const String findMissing = 'FindMissing';
  static const String mentalArithmetic = 'MentalArithmetic';
  static const String squareRoot = 'SquareRoot';
  static const String mathPairs = 'MathPairs';
  static const String concentration = 'concentration';
  static const String cubeRoot = 'cubeRoot';

  static const String magicTriangle = 'MagicTriangle';
  static const String picturePuzzle = 'PicturePuzzle';
  static const String mathGrid = 'MathGrid';
  static const String numberPyramid = "NumberPyramid";
  static const String numericMemory = "numericMemory";
  static Color primaryColor1 = "#FFCB43".toColor();
  static Color bgColor1 = "#FFF2D5".toColor();
  static Color backgroundColor1 = "#FFDB7C".toColor();
  static Color backgroundColor2 = "#C2ECA3".toColor();
  static Color backgroundColor3 = "#E3D9FF".toColor();
  static Color primaryColor2 = "#AAE37B".toColor();
  static Color bgColor2 = "#EAF9DF".toColor();
  static Color primaryColor3 = "#C3AEFF".toColor();
  static Color bgColor3 = "#EFEBFE".toColor();
  static Color blackTransparentColor = "#BF000000".toColor();
  static String themeYellowFolder = 'imgYellow/';
  static String themeOrangeFolder = 'imgGreen/';
  static String themeBlueFolder = 'imgBlue/';

  static List<Dashboard> dashboardItems = [
    Dashboard(
        puzzleType: PuzzleType.mathPuzzle,
        colorTuple: const Tuple2(Color(0xff4895EF), Color(0xff3f37c9)),
        opacity: 0.07,
        outlineIcon: AppAssets.icMathPuzzleOutline,
        subtitle: "Each game with simple calculation with different approach.",
        title: "Math Puzzle",
        gridColor: bgColor1,
        fillIconColor: const Color(0xff4895ef),
        position: 0,
        outlineIconColor: const Color(0xff436add),
        bgColor: bgColor1,
        backgroundColor: backgroundColor1,
        folder: themeYellowFolder,
        primaryColor: primaryColor1),
    Dashboard(
        position: 1,
        backgroundColor: backgroundColor2,
        puzzleType: PuzzleType.memoryPuzzle,
        colorTuple: const Tuple2(Color(0xff9f2beb), Color(0xff560bad)),
        opacity: 0.07,
        outlineIcon: AppAssets.icMemoryPuzzleOutline,
        gridColor: bgColor2,
        subtitle:
            "Memorise numbers & signs before applying calculation to them.",
        title: "Memory Puzzle",
        fillIconColor: const Color(0xff9f2beb),
        outlineIconColor: const Color(0xff560BAD),
        bgColor: bgColor2,
        folder: themeOrangeFolder,
        primaryColor: primaryColor2),
    Dashboard(
        position: 2,
        gridColor: bgColor3,
        backgroundColor: backgroundColor3,
        puzzleType: PuzzleType.brainPuzzle,
        colorTuple: const Tuple2(Color(0xfff72585), Color(0xffb5179e)),
        opacity: 0.12,
        outlineIcon: AppAssets.icTrainBrainOutline,
        subtitle:
            "Enhance logical thinking, concentration and core cognitive skills.",
        title: "Train Your Brain",
        folder: themeBlueFolder,
        fillIconColor: const Color(0xfff72585),
        outlineIconColor: const Color(0xffB5179E),
        bgColor: bgColor3,
        primaryColor: primaryColor3),
  ];

  static List<Color> bgColorList = [
    bgColor1,
    bgColor2,
    bgColor3,
  ];

  static int getTimeUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.calculator:
        return calculatorTimeOut;
      case GameCategoryType.guessSign:
        return guessSignTimeOut;
      case GameCategoryType.squareRoot:
        return squareRootTimeOut;
      case GameCategoryType.cubeRoot:
        return cubeRootTimeOut;
      case GameCategoryType.mathPairs:
        return mathematicalPairsTimeOut;
      case GameCategoryType.concentration:
        return concentrationTimeOut;
      case GameCategoryType.correctAnswer:
        return correctAnswerTimeOut;
      case GameCategoryType.magicTriangle:
        return magicTriangleTimeOut;
      case GameCategoryType.mentalArithmetic:
        return mentalArithmeticTimeOut;
      case GameCategoryType.quickCalculation:
        return quickCalculationTimeOut;
      case GameCategoryType.mathGrid:
        return mathGridTimeOut;
      case GameCategoryType.picturePuzzle:
        return picturePuzzleTimeOut;
      case GameCategoryType.numberPyramid:
        return numPyramidTimeOut;
      case GameCategoryType.findMissing:
        return findMissingTimeOut;

      case GameCategoryType.trueFalse:
        return trueFalseTimeOut;

      case GameCategoryType.dualGame:
        return dualTimeOut;
      case GameCategoryType.complexCalculation:
        return complexCalculationTimeOut;

      case GameCategoryType.numericMemory:
        return numericMemoryTimeOut;
    }
  }

  static double getScoreUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.calculator:
        return calculatorScore;
      case GameCategoryType.guessSign:
        return guessSignScore;
      case GameCategoryType.squareRoot:
        return squareRootScore;

      case GameCategoryType.cubeRoot:
        return cubeRootScore;
      case GameCategoryType.mathPairs:
        return mathGridScore;
      case GameCategoryType.concentration:
        return concentrationScore;
      case GameCategoryType.correctAnswer:
        return correctAnswerScore;
      case GameCategoryType.magicTriangle:
        return magicTriangleScore;
      case GameCategoryType.mentalArithmetic:
        return mentalArithmeticScore;
      case GameCategoryType.quickCalculation:
        return quickCalculationScore;
      case GameCategoryType.mathGrid:
        return mathGridScore;
      case GameCategoryType.picturePuzzle:
        return picturePuzzleScore;
      case GameCategoryType.numberPyramid:
        return numberPyramidScore;
      case GameCategoryType.findMissing:
        return findMissingScore;
      case GameCategoryType.trueFalse:
        return trueFalseScore;
      case GameCategoryType.dualGame:
        return dualScore;
      case GameCategoryType.complexCalculation:
        return complexCalculationScore;

      case GameCategoryType.numericMemory:
        return numericMemoryScore;
    }
  }

  static double getScoreMinusUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.calculator:
        return calculatorScoreMinus;
      case GameCategoryType.guessSign:
        return guessSignScoreMinus;
      case GameCategoryType.squareRoot:
        return squareRootScoreMinus;
      case GameCategoryType.cubeRoot:
        return cubeRootScoreMinus;
      case GameCategoryType.mathPairs:
        return mathematicalPairsScoreMinus;
      case GameCategoryType.concentration:
        return concentrationScoreMinus;
      case GameCategoryType.correctAnswer:
        return correctAnswerScoreMinus;
      case GameCategoryType.magicTriangle:
        return magicTriangleScoreMinus;
      case GameCategoryType.mentalArithmetic:
        return mentalArithmeticScoreMinus;
      case GameCategoryType.quickCalculation:
        return quickCalculationScoreMinus;
      case GameCategoryType.mathGrid:
        return mathGridScoreMinus;
      case GameCategoryType.picturePuzzle:
        return picturePuzzleScoreMinus;
      case GameCategoryType.numberPyramid:
        return numberPyramidScoreMinus;
      case GameCategoryType.findMissing:
        return findMissingScoreMinus;
      case GameCategoryType.trueFalse:
        return trueFalseScoreMinus;
      case GameCategoryType.dualGame:
        return dualScoreMinus;

      case GameCategoryType.complexCalculation:
        return complexCalculationScoreMinus;

      case GameCategoryType.numericMemory:
        return numericMemoryScoreMinus;
    }
  }

  static double getCoinUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.calculator:
        return calculatorCoin;
      case GameCategoryType.guessSign:
        return guessSignCoin;
      case GameCategoryType.squareRoot:
        return squareRootCoin;
      case GameCategoryType.cubeRoot:
        return cubeRootCoin;

      case GameCategoryType.mathPairs:
        return mathematicalPairsCoin;
      case GameCategoryType.concentration:
        return concentrationCoin;
      case GameCategoryType.correctAnswer:
        return correctAnswerCoin;
      case GameCategoryType.magicTriangle:
        return magicTriangleCoin;
      case GameCategoryType.mentalArithmetic:
        return mentalArithmeticCoin;
      case GameCategoryType.quickCalculation:
        return quickCalculationCoin;
      case GameCategoryType.mathGrid:
        return mathGridCoin;
      case GameCategoryType.picturePuzzle:
        return picturePuzzleCoin;
      case GameCategoryType.numberPyramid:
        return numberPyramidCoin;
      case GameCategoryType.findMissing:
        return findMissingCoin;
      case GameCategoryType.trueFalse:
        return truFalseCoin;
      case GameCategoryType.dualGame:
        return dualGameCoin;
      case GameCategoryType.complexCalculation:
        return complexCalculationCoin;
      case GameCategoryType.numericMemory:
        return numericMemoryCoin;
    }
  }

  //Game TimeOut Constant
  static int calculatorTimeOut = 10;
  static int guessSignTimeOut = 10;
  static int correctAnswerTimeOut = 10;
  static int quickCalculationTimeOut = 20;
  static int quickCalculationPlusTime = 1;

  static int findMissingTimeOut = 20;
  static int findMissingTime = 1;

  static int trueFalseTimeOut = 20;
  static int trueFalseTime = 1;

  static int numericMemoryTimeOut = 5;
  static int numericMemoryTime = 1;

  static int complexCalculationTimeOut = 20;
  static int complexCalculationTime = 1;

  static int dualTimeOut = 20;
  static int dualTime = 1;

  static int mentalArithmeticTimeOut = 60;
  static int mentalArithmeticLocalTimeOut = 4;
  static int squareRootTimeOut = 10;
  static int cubeRootTimeOut = 10;
  static int mathGridTimeOut = 120;

  static int mathematicalPairsTimeOut = 60;
  static int concentrationTimeOut = 10;

  static int magicTriangleTimeOut = 60;
  static int picturePuzzleTimeOut = 90;
  static int numPyramidTimeOut = 120;

  //Game Score Constant
  static double calculatorScore = 1;
  static double calculatorScoreMinus = -1;

  static double complexCalculationScore = 1;
  static double complexCalculationScoreMinus = -1;

  static double numericMemoryScore = 1;
  static double numericMemoryScoreMinus = -1;

  static double guessSignScore = 1;
  static double guessSignScoreMinus = -1;

  static double correctAnswerScore = 1;
  static double correctAnswerScoreMinus = -1;

  static double findMissingScore = 1;
  static double findMissingScoreMinus = -1;

  static double dualScore = 1;
  static double dualScoreMinus = -1;

  static double trueFalseScore = 1;
  static double trueFalseScoreMinus = -1;

  static double quickCalculationScore = 1;
  static double quickCalculationScoreMinus = -1;

  static double mentalArithmeticScore = 2;
  static double mentalArithmeticScoreMinus = -1;

  static double squareRootScore = 1;
  static double squareRootScoreMinus = -1;

  static double cubeRootScore = 1;
  static double cubeRootScoreMinus = -1;

  static double mathematicalPairsScore = 5;
  static double mathematicalPairsScoreMinus = -5;

  static double mathGridScore = 5;
  static double mathGridScoreMinus = 0;

  static double concentrationScore = 5;
  static double concentrationScoreMinus = 0;

  static double magicTriangleScore = 5;
  static double magicTriangleScoreMinus = 0;

  static double picturePuzzleScore = 2;
  static double picturePuzzleScoreMinus = -1;

  static double numberPyramidScore = 5;
  static double numberPyramidScoreMinus = 0;

  //Game Coin Constant
  static double calculatorCoin = 0.5;
  static double guessSignCoin = 0.5;
  static double correctAnswerCoin = 0.5;
  static double quickCalculationCoin = 0.5;

  static double mentalArithmeticCoin = 1;
  static double squareRootCoin = 0.5;
  static double cubeRootCoin = 0.5;
  static double mathGridCoin = 3;
  static double mathematicalPairsCoin = 1;
  static double concentrationCoin = 1;

  static double magicTriangleCoin = 3;
  static double picturePuzzleCoin = 1;
  static double numberPyramidCoin = 3;
  static double findMissingCoin = 1;
  static double truFalseCoin = 1;
  static double dualGameCoin = 1;
  static double complexCalculationCoin = 1;
  static double numericMemoryCoin = 1;
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
