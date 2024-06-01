import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:puzzle/core/app_assets.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/models/score_board.dart';
import 'package:puzzle/ui/app/coin_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/game_category.dart';
import '../../utility/constants.dart';

class DashboardProvider extends CoinProvider {
  int _overallScore = 0;
  // int _coin = 0;
  late List<GameCategory> _list;
  final SharedPreferences preferences;

  int get overallScore => _overallScore;
  // int get coin => _coin;

  List<GameCategory> get list => _list;

  DashboardProvider({required this.preferences}) {
    _overallScore = getOverallScore();
    getCoin();
  }

  List<GameCategory> getGameByPuzzleType(PuzzleType puzzleType) {
    _list = <GameCategory>[];

    switch (puzzleType) {
      case PuzzleType.mathPuzzle:
        list.add(GameCategory(
          1,
          "Calculator".tr(),
          keyCalculator,
          GameCategoryType.calculator,
          KeyUtil.calculator,
          getScoreboard(keyCalculator),
          AppAssets.icCalculator,
        ));
        list.add(GameCategory(
            2,
            "Guess The Sign".tr(),
            keySign,
            GameCategoryType.guessSign,
            KeyUtil.guessSign,
            getScoreboard(keySign),
            AppAssets.icGuessTheSign));
        list.add(GameCategory(
          3,
          "Correct Answer".tr(),
          keyCorrectAnswer,
          GameCategoryType.correctAnswer,
          KeyUtil.correctAnswer,
          getScoreboard(keyCorrectAnswer),
          AppAssets.icCorrectAnswer,
        ));
        list.add(GameCategory(
          4,
          "Quick Calculation".tr(),
          keyQuickCalculation,
          GameCategoryType.quickCalculation,
          KeyUtil.quickCalculation,
          getScoreboard(keyQuickCalculation),
          AppAssets.icQuickCalculation,
        ));
        list.add(GameCategory(
          5,
          "Find Missing".tr(),
          keyFindMissingCalculation,
          GameCategoryType.findMissing,
          KeyUtil.findMissing,
          getScoreboard(keyFindMissingCalculation),
          AppAssets.icFindMissing,
        ));

        list.add(GameCategory(
          6,
          "True False".tr(),
          keyTrueFalseCalculation,
          GameCategoryType.trueFalse,
          KeyUtil.trueFalse,
          getScoreboard(keyTrueFalseCalculation),
          AppAssets.icTrueFalse,
        ));

        list.add(GameCategory(
          7,
          "Complex Calculation".tr(),
          keyComplexGame,
          GameCategoryType.complexCalculation,
          KeyUtil.complexCalculation,
          getScoreboard(keyComplexGame),
          AppAssets.icComplexCalculation,
        ));

        list.add(GameCategory(
          8,
          "Dual Game".tr(),
          keyDualGame,
          GameCategoryType.dualGame,
          KeyUtil.dualGame,
          getScoreboard(keyDualGame),
          AppAssets.icDualGame,
        ));
        break;
      case PuzzleType.memoryPuzzle:
        list.add(GameCategory(
          9,
          "Mental Arithmetic".tr(),
          keyMentalArithmetic,
          GameCategoryType.mentalArithmetic,
          KeyUtil.mentalArithmetic,
          getScoreboard(keyMentalArithmetic),
          AppAssets.icMentalArithmetic,
        ));

        list.add(GameCategory(
          10,
          "Square Root".tr(),
          keySquareRoot,
          GameCategoryType.squareRoot,
          KeyUtil.squareRoot,
          getScoreboard(keySquareRoot),
          AppAssets.icSquareRoot,
        ));
        list.add(GameCategory(
          11,
          "Math Grid".tr(),
          keyMathMachine,
          GameCategoryType.mathGrid,
          KeyUtil.mathGrid,
          getScoreboard(keyMathMachine),
          AppAssets.icMathGrid,
        ));
        list.add(GameCategory(
          12,
          "Mathematical Pairs".tr(),
          keyMathPairs,
          GameCategoryType.mathPairs,
          KeyUtil.mathPairs,
          getScoreboard(keyMathPairs),
          AppAssets.icMathematicalPairs,
        ));

        list.add(GameCategory(
          13,
          "Cube Root".tr(),
          keyCubeRoot,
          GameCategoryType.cubeRoot,
          KeyUtil.cubeRoot,
          getScoreboard(keyCubeRoot),
          AppAssets.icCubeRoot,
        ));

        list.add(GameCategory(
          14,
          "Concentration".tr(),
          keyConcentration,
          GameCategoryType.concentration,
          KeyUtil.concentration,
          getScoreboard(keyConcentration),
          AppAssets.icConcentration,
        ));
        break;
      case PuzzleType.brainPuzzle:
        list.add(GameCategory(
          15,
          "Magic Triangle".tr(),
          keyMagicTriangle,
          GameCategoryType.magicTriangle,
          KeyUtil.magicTriangle,
          getScoreboard(keyMagicTriangle),
          AppAssets.icMagicTriangle,
        ));
        list.add(GameCategory(
          16,
          "Picture Puzzle".tr(),
          keyPicturePuzzle,
          GameCategoryType.picturePuzzle,
          KeyUtil.picturePuzzle,
          getScoreboard(keyPicturePuzzle),
          AppAssets.icPicturePuzzle,
        ));
        list.add(GameCategory(
          17,
          "Number Pyramid".tr(),
          keyNumberPyramid,
          GameCategoryType.numberPyramid,
          KeyUtil.numberPyramid,
          getScoreboard(keyNumberPyramid),
          AppAssets.icNumberPyramid,
        ));

        list.add(GameCategory(
          18,
          "Numeric Memory".tr(),
          keyNumericMemory,
          GameCategoryType.numericMemory,
          KeyUtil.numericMemory,
          getScoreboard(keyNumericMemory),
          AppAssets.icNumericMemory,
        ));
        break;
    }
    return _list;
  }

  ScoreBoard getScoreboard(String gameCategoryType) {
    return ScoreBoard.fromJson(
        json.decode(preferences.getString(gameCategoryType) ?? "{}"));
  }

  void setScoreboard(String gameCategoryType, ScoreBoard scoreboard) {
    preferences.setString(gameCategoryType, json.encode(scoreboard.toJson()));
  }

  void updateScoreboard(GameCategoryType gameCategoryType, double newScore) {
    for (var gameCategory in list) {
      if (gameCategory.gameCategoryType == gameCategoryType) {
        if (gameCategory.scoreboard.highestScore < newScore.toInt()) {
          setOverallScore(
              gameCategory.scoreboard.highestScore, newScore.toInt());
          gameCategory.scoreboard.highestScore = newScore.toInt();
        }
        setScoreboard(gameCategory.key, gameCategory.scoreboard);
      }
    }
    notifyListeners();
  }

  int getOverallCoin() {
    return preferences.getInt(CoinProvider().keyCoin) ?? 0;
  }

  int getOverallScore() {
    return preferences.getInt("overall_score") ?? 0;
  }

  void setOverallScore(int highestScore, int newScore) {
    _overallScore = getOverallScore() - highestScore + newScore;
    preferences.setInt("overall_score", _overallScore);
  }

  bool isFirstTime(GameCategoryType gameCategoryType) {
    return list
        .where((GameCategory gameCategory) =>
            gameCategory.gameCategoryType == gameCategoryType)
        .first
        .scoreboard
        .firstTime;
  }

  void setFirstTime(GameCategoryType gameCategoryType) {
    for (var gameCategory in list) {
      if (gameCategory.gameCategoryType == gameCategoryType) {
        gameCategory.scoreboard.firstTime = false;
        setScoreboard(gameCategory.key, gameCategory.scoreboard);
      }
    }
  }
}
