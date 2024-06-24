import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:puzzle/core/app_constants.dart';
import 'package:puzzle/data/repository/calculator_repository.dart';
import 'package:puzzle/data/repository/complex_calculation_repository.dart';
import 'package:puzzle/data/repository/correct_answer_repository.dart';
import 'package:puzzle/data/repository/cube_root_repository.dart';
import 'package:puzzle/data/repository/dual_repository.dart';
import 'package:puzzle/data/repository/find_missing_repository.dart';
import 'package:puzzle/data/repository/magic_triangle_repository.dart';
import 'package:puzzle/data/repository/math_grid_repository.dart';
import 'package:puzzle/data/repository/math_pairs_repository.dart';
import 'package:puzzle/data/repository/mental_arithmetic_repository.dart';
import 'package:puzzle/data/repository/number_pyramid_repository.dart';
import 'package:puzzle/data/repository/picture_puzzle_repository.dart';
import 'package:puzzle/data/repository/quick_calculation_repository.dart';
import 'package:puzzle/data/repository/sign_repository.dart';
import 'package:puzzle/data/repository/square_root_repository.dart';
import 'package:puzzle/data/repository/true_false_repository.dart';
import 'package:puzzle/ui/dashboard/dashboard_provider.dart';

import '../../ads/ads_file.dart';
import '../../data/repository/numeric_memory_repository.dart';
import 'time_provider.dart';

int rightCoin = 10;
int wrongCoin = 5;
int hintCoin = 10;

class GameProvider<T> extends TimeProvider with WidgetsBindingObserver {
  final GameCategoryType gameCategoryType;
  final _homeViewModel = GetIt.I<DashboardProvider>();
  final homeViewModel = GetIt.I<DashboardProvider>();

  late List<T> list;
  late int index;
  late double currentScore;
  late double score1 = 0;
  late double score2 = 0;
  late int rightCount = 0;
  late int wrongCount = 0;
  late double oldScore;
  late T currentState;
  late String result;
  late bool isTimer;
  late bool isRewardedComplete = false;
  late int levelNo;

  late AdsFile adsFile;
  late BuildContext c;

  GameProvider(
      {required super.vsync,
      required this.gameCategoryType,
      required this.c,
      bool? isTimer})
      : super(
          totalTime:
              KeyUtil.getTimeUtil(gameCategoryType), // xác đinh total time
        ) {
    this.isTimer = (isTimer == null) ? true : isTimer;
    adsFile = AdsFile(c);

    adsFile.createRewardedAd();
    if (kDebugMode) {
      print("isTimer12===$isTimer");
    }
  }

  @override
  void dispose() {
    disposeRewardedAd(adsFile);
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  void startGame({int? level, bool? isTimer}) async {
    isTimer = (isTimer == null) ? true : isTimer;
    result = "";

    list = [];
    list = getListData(level ?? 1);

    if (kDebugMode) {
      print("list--${list.length}====");
    }
    index = 0;
    currentScore = 0;
    oldScore = 0;
    currentState = list[index];
    // Nếu là lần đầu , hiện info dialog
    if (_homeViewModel.isFirstTime(gameCategoryType)) {
      await Future.delayed(const Duration(milliseconds: 100));
      showInfoDialog();
    } else {
      if (kDebugMode) {
        print("isTimerStart==$isTimer");
      }
      if (isTimer) {
        // Đưa trò chơi đến trạng thái play
        restartTimer();
        notifyListeners();
      }
    }
    getCoin();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        if (isTimer) {
          pauseTimer();
          dialogType = DialogType.pause;
          notifyListeners();
        }
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  void loadNewDataIfRequired({int? level, bool? isScoreAdd}) {
    isFirstClick = false;
    isSecondClick = false;
    if (kDebugMode) {
      print("list12===${list.length}");
    }
    // Nếu đó là câu thứ x < 19 thì load tiếp , không thì kết thúc trò chơi sau khi xong câu hỏi thứ 20
    if (index < 19) {
      if (gameCategoryType == GameCategoryType.quickCalculation &&
          list.length - 2 == index) {
        if (kDebugMode) {
          print("level---${level ?? index ~/ 5 + 1}");
        }
        list.addAll(getListData(level ?? index ~/ 5 + 1));
      } else if (list.length - 1 == index) {
        if (kDebugMode) {
          print("level---${level ?? index ~/ 5 + 1}");
        }
        if (gameCategoryType == GameCategoryType.squareRoot) {
          list.addAll(getListData(level ?? index ~/ 5 + 2));
        } else {
          list.addAll(getListData(level ?? index ~/ 5 + 1));
        }
      }
      if (kDebugMode) {
        print("list1212===${list.length}");
      }
      result = "";
      index = index + 1;

      if (kDebugMode) {
        print("index===$index");
      }
      currentState = list[index];
    } else {
      dialogType = DialogType.over;
      if (isTimer) {
        pauseTimer();
      }
      notifyListeners();
    }
  }

  bool isFirstClick = false;
  bool isSecondClick = false;

  void wrongDualAnswer(bool isFirst) {
    if (isFirst) {
      if (score1 > 0) {
        score1--;
        notifyListeners();
      } else if (score1 == 0 && isSecondClick && score2 <= 0) {
        dialogType = DialogType.over;
        pauseTimer();
        notifyListeners();
      } else {
        notifyListeners();
      }
    } else {}
    if (score2 > 0) {
      score2--;
      notifyListeners();
    } else if (score2 == 0 && isFirstClick && score1 <= 0) {
      dialogType = DialogType.over;

      pauseTimer();
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  void rightAnswer() {
    if (kDebugMode) {
      print("currentScoreRight===$currentScore");
    }
    oldScore = currentScore;
    currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);

    addCoin();

    if (kDebugMode) {
      print("currentScore===12 $currentScore");
    }
    notifyListeners();
  }

  void wrongAnswer() {
    minusCoin();
    if (currentScore > 0) {
      oldScore = currentScore;
      double minusScore = KeyUtil.getScoreMinusUtil(gameCategoryType);
      if (minusScore < 0) {
        minusScore = minusScore.abs();
      }
      currentScore = currentScore - minusScore;
      notifyListeners();
    } else if (currentScore == 0) {
      dialogType = DialogType.over;
      pauseTimer();
      notifyListeners();
    }
  }

  void pauseResumeGame() {
    dialogType = DialogType.non;
    if (isTimer) {
      if (timerStatus == TimerStatus.play) {
        pauseTimer();
        dialogType = DialogType.pause;
        notifyListeners();
      } else {
        resumeTimer();
        dialogType = DialogType.non;
        notifyListeners();
      }
    }

    if (kDebugMode) {
      print("dialogType====$dialogType");
    }
  }

  void showInfoDialog() {
    pauseTimer();
    dialogType = DialogType.info;
    notifyListeners();
  }

  void showExitDialog() {
    if (kDebugMode) {
      print("dialog---true2");
    }
    pauseTimer();
    if (kDebugMode) {
      print("dialog---true3");
    }
    dialogType = DialogType.exit;
    if (kDebugMode) {
      print("dialog---true1");
    }
    notifyListeners();
  }

  void showHintDialog() {
    if (kDebugMode) {
      print("dialog---true2");
    }
    pauseTimer();
    if (kDebugMode) {
      print("dialog---true3");
    }
    dialogType = DialogType.hint;
    if (kDebugMode) {
      print("dialog---true1");
    }
    notifyListeners();
  }

  void updateScore() {
    if (kDebugMode) {
      print("currentScore===$currentScore");
    }
    _homeViewModel.updateScoreboard(gameCategoryType, currentScore);
  }

  void gotItFromInfoDialog(int? level) {
    if (_homeViewModel.isFirstTime(gameCategoryType)) {
      _homeViewModel.setFirstTime(gameCategoryType);
      if (gameCategoryType == GameCategoryType.mentalArithmetic) {
        startGame(level: level);
      }
      if (isTimer) {
        restartTimer();
      }
    } else {
      pauseResumeGame();
    }

    if (kDebugMode) {
      print("home-==${_homeViewModel.isFirstTime(gameCategoryType)}");
    }
  }

  //Lấy dữ liệu list data dựa trên repository của từng trò chơi
  List<T> getListData(int level) {
    this.levelNo = level;

    switch (gameCategoryType) {
      case GameCategoryType.calculator:
        return CalculatorRepository.getCalculatorDataList(level);
      case GameCategoryType.guessSign:
        return SignRepository.getSignDataList(level);
      case GameCategoryType.findMissing:
        return FindMissingRepository.getFindMissingDataList(level);
      case GameCategoryType.trueFalse:
        return TrueFalseRepository.getTrueFalseDataList(level);
      case GameCategoryType.squareRoot:
        return SquareRootRepository.getSquareDataList(level);
      case GameCategoryType.mathPairs:
        return MathPairsRepository.getMathPairsDataList(level);

      case GameCategoryType.concentration:
        return MathPairsRepository.getMathPairsDataList(level);

      case GameCategoryType.numericMemory:
        return NumericMemoryRepository.getNumericMemoryDataList(level);

      case GameCategoryType.correctAnswer:
        return CorrectAnswerRepository.getCorrectAnswerDataList(level);
      case GameCategoryType.magicTriangle:
        if (level > 15) {
          return MagicTriangleRepository.getNextLevelTriangleDataProviderList();
        } else {
          return MagicTriangleRepository.getTriangleDataProviderList();
        }
      case GameCategoryType.mentalArithmetic:
        return MentalArithmeticRepository.getMentalArithmeticDataList(level);
      case GameCategoryType.quickCalculation:
        return QuickCalculationRepository.getQuickCalculationDataList(level, 5);
      case GameCategoryType.mathGrid:
        return MathGridRepository.getMathGridData(level);
      case GameCategoryType.picturePuzzle:
        return PicturePuzzleRepository.getPicturePuzzleDataList(level);
      case GameCategoryType.numberPyramid:
        return NumberPyramidRepository.getPyramidDataList(level);
      case GameCategoryType.dualGame:
        return DualRepository.getDualData(level);
      case GameCategoryType.complexCalculation:
        return ComplexCalculationRepository.getComplexData(level);
      case GameCategoryType.cubeRoot:
        return CubeRootRepository.getCubeDataList(level);
    }
  }
}
