import 'package:flutter/material.dart';
import 'package:puzzle/data/models/dashboard.dart';
import 'package:puzzle/ui/calculator/calculator_view.dart';
import 'package:puzzle/ui/complex_calculation/complex_calculation_view.dart';
import 'package:puzzle/ui/concentration/concentration_view.dart';
import 'package:puzzle/ui/correct_answer/correct_answer_view.dart';
import 'package:puzzle/ui/cube_root/cube_root_view.dart';
import 'package:puzzle/ui/dashboard/dashboard_view.dart';
import 'package:puzzle/ui/duel_game/duel_view.dart';
import 'package:puzzle/ui/find_missing/find_missing_view.dart';
import 'package:puzzle/ui/guess_the_sign/guess_sign_view.dart';
import 'package:puzzle/ui/home/home_view.dart';
import 'package:puzzle/ui/magic_triangle/magic_triangle_view.dart';
import 'package:puzzle/ui/math_grid/math_grid_view.dart';
import 'package:puzzle/ui/math_pairs/math_pairs_view.dart';
import 'package:puzzle/ui/mental_arithmetic/mental_arithmetic_view.dart';
import 'package:puzzle/ui/model/gradient_model.dart';
import 'package:puzzle/ui/number_pyramid/number_pyramid_view.dart';
import 'package:puzzle/ui/numeric_memory/numeric_view.dart';
import 'package:puzzle/ui/picture_puzzle/picture_puzzle_view.dart';
import 'package:puzzle/ui/quick_calculation/quick_calculation_view.dart';
import 'package:puzzle/ui/splash/splash_view.dart';
import 'package:puzzle/ui/square_root/square_root_view.dart';
import 'package:puzzle/ui/true_false_quiz/true_false_view.dart';
import 'package:tuple/tuple.dart';

import '../data/models/game_category.dart';
import '../ui/level/level_view.dart';
import 'app_constants.dart';

var appRoutes = {
  KeyUtil.dashboard: (context) => const DashboardView(),
  KeyUtil.splash: (context) => const SplashView(),
  KeyUtil.home: (context) => HomeView(
      tuple2: ModalRoute.of(context)?.settings.arguments
          as Tuple2<Dashboard, double>),
  KeyUtil.level: (context) => LevelView(
      tuple2: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GameCategory, Dashboard>),
  KeyUtil.calculator: (context) => CalculatorView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.guessSign: (context) => GuessSignView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.trueFalse: (context) => TrueFalseView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.complexCalculation: (context) => ComplexCalculationView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.findMissing: (context) => FindMissingView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.dualGame: (context) => DuelView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.correctAnswer: (context) => CorrectAnswerView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.quickCalculation: (context) => QuickCalculationView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.mentalArithmetic: (context) => MentalArithmeticView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.squareRoot: (context) => SquareRootView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.numericMemory: (context) => NumericMemoryView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.cubeRoot: (context) => CubeRootView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.mathPairs: (context) => MathPairsView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.concentration: (context) => ConcentrationView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.magicTriangle: (context) => MagicTriangleView(
      colorTuple1: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.mathGrid: (context) => MathGridView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.picturePuzzle: (context) => PicturePuzzleView(
      colorTuple: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
  KeyUtil.numberPyramid: (context) => NumberPyramidView(
      colorTuple1: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GradientModel, int>),
};
