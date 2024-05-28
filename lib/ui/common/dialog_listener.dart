import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/core/color_scheme.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_constants.dart';
import '../../utility/Constants.dart';
import '../app/game_provider.dart';
import '../model/gradient_model.dart';
import '../numeric_memory/numeric_view.dart';
import 'common_alert_dialog.dart';
import 'common_alert_over_dialog.dart';
import 'common_dual_game_over_dialog_view.dart';
import 'common_game_exit_dialog_view.dart';
import 'common_game_over_dialog_view.dart';
import 'common_game_pause_dialog_view.dart';
import 'common_hint_dialog.dart';
import 'common_info_dialog_view.dart';

class DialogListener<T extends GameProvider> extends StatefulWidget {
  final Widget child;
  final Widget appBar;
  final GameCategoryType gameCategoryType;
  final int level;
  final Tuple2<GradientModel, int> colorTuple;
  final Function? nextQuiz;

  const DialogListener({
    super.key,
    required this.appBar,
    required this.child,
    required this.gameCategoryType,
    required this.level,
    required this.colorTuple,
    this.nextQuiz,
  });

  @override
  State<DialogListener<T>> createState() => _DialogListenerState<T>();
}

class _DialogListenerState<T extends GameProvider>
    extends State<DialogListener<T>> {
  late final T provider;
  bool? isDialogOpen = false;

  @override
  void initState() {
    provider = context.read<T>();
    provider.addListener(addListener);
    super.initState();
  }

  void addListener() {
    double radius = getScreenPercentSize(context, 5);
    if (kDebugMode) {
      print(
          "dialog---true---${provider.dialogType}----${context.read<T>().currentScore}");
    }

    if (isDialogOpen != null && !isDialogOpen!) {
      if (provider.dialogType == DialogType.over &&
          provider.gameCategoryType == GameCategoryType.dualGame) {
        isDialogOpen = true;
        showDialog<bool>(
          context: context,
          builder: (newContext) => CommonAlertDialog(
            isGameOver: true,
            child: CommonDualGameOverDialogView(
              gameCategoryType: widget.gameCategoryType,
              score1: context.read<T>().score1.toInt(),
              score2: context.read<T>().score2.toInt(),
              index: context.read<T>().index.toInt(),
              colorTuple: widget.colorTuple,
              totalQuestion: provider.index,
            ),
          ),
          barrierDismissible: false,
        ).then((value) {
          isDialogOpen = false;
          context.read<T>().updateScore();
          if (value != null && value) {
            context.read<T>().startGame(level: widget.level);
          } else {
            Navigator.pop(context);
          }
        });
      } else {
        int level = context.read<T>().levelNo;
        switch (provider.dialogType) {
          case DialogType.over:
            context.read<T>().homeViewModel.getCoin();
            isDialogOpen = true;
            showDialog<bool>(
              context: context,
              builder: (newContext) => CommonAlertOverDialog(
                isGameOver: true,
                child: CommonGameOverDialogView(
                  gameCategoryType: widget.gameCategoryType,
                  score: context.read<T>().currentScore.toInt(),
                  right: context.read<T>().rightCount.toInt(),
                  wrong: context.read<T>().wrongCount.toInt(),
                  level: context.read<T>().levelNo.toInt(),
                  function: (nextLevel) {
                    level = nextLevel;
                  },
                  updateFunction: () {
                    context.read<T>().updateScore();
                  },
                  colorTuple: widget.colorTuple,
                  totalQuestion: provider.index,
                ),
              ),
              barrierDismissible: false,
            ).then((value) {
              if (kDebugMode) {
                print("level===$level");
              }
              isDialogOpen = false;
              context.read<T>().updateScore();
              if (value != null && value) {
                if (widget.gameCategoryType == GameCategoryType.numericMemory) {
                  if (widget.nextQuiz != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NumericMemoryView(
                              colorTuple:
                                  Tuple2(widget.colorTuple.item1, level)),
                        ));
                  }
                } else {
                  context.read<T>().rightCount = 0;
                  context.read<T>().wrongCount = 0;
                  context.read<T>().index = 0;

                  context.read<T>().startGame(
                      level: level, isTimer: context.read<T>().isTimer);
                }
              } else {
                Navigator.pop(context);
              }
            });
            break;
          case DialogType.info:
            isDialogOpen = true;
            showModalBottomSheet(
              context: context,
              builder: (context) => CommonInfoDialogView(
                gameCategoryType: widget.gameCategoryType,
                color: widget.colorTuple.item1.primaryColor!,
              ),
              backgroundColor: Theme.of(context).colorScheme.infoDialogBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius)),
              ),
              isDismissible: false,
              enableDrag: false,
              isScrollControlled: true,
            ).then((value) {
              isDialogOpen = false;
              context.read<T>().gotItFromInfoDialog(widget.level);
            });
            break;
          case DialogType.pause:
            isDialogOpen = true;
            showDialog<bool>(
              context: context,
              builder: (newContext) => CommonAlertDialog(
                child: CommonGamePauseDialogView(
                  gameCategoryType: widget.gameCategoryType,
                  score: context.read<T>().currentScore,
                  colorTuple: widget.colorTuple,
                ),
              ),
              barrierDismissible: false,
            ).then((value) {
              isDialogOpen = false;
              if (value != null) {
                if (value) {
                  context.read<T>().pauseResumeGame();
                } else {
                  context.read<T>().updateScore();
                  context.read<T>().startGame(level: widget.level);
                }
              } else {
                context.read<T>().pauseResumeGame();
              }
            });
            break;
          case DialogType.exit:
            isDialogOpen = true;
            showDialog<bool>(
              context: context,
              builder: (newContext) => CommonAlertDialog(
                child: CommonGameExitDialogView(
                  colorTuple: widget.colorTuple,
                  score: context.read<T>().currentScore,
                ),
              ),
              barrierDismissible: false,
            ).then((value) {
              isDialogOpen = false;
              if (value != null && value) {
                context.read<T>().updateScore();
                Navigator.pop(context);
              } else {
                context.read<T>().pauseResumeGame();
              }
            });
            break;
          case DialogType.hint:
            isDialogOpen = true;
            showModalBottomSheet(
              context: context,
              builder: (c) => CommonHintDialog(
                gameCategoryType: widget.gameCategoryType,
                colorTuple: widget.colorTuple,
                provider: context.read<T>(),
              ),
              backgroundColor: Theme.of(context).colorScheme.infoDialogBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius)),
              ),
              isDismissible: false,
              enableDrag: false,
              isScrollControlled: true,
            ).then((value) {
              isDialogOpen = false;
              context.read<T>().gotItFromInfoDialog(widget.level);
            });
            break;
          case DialogType.non:
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: getNoneAppBar(context),
        body: SafeArea(
          bottom: true,
          child: Column(
            children: [
              widget.appBar,
              Expanded(
                flex: 1,
                child: widget.child,
              )
            ],
          ),
        ),
      ),
      onPopInvoked: (didPop) {
        if (didPop) {
          context.read<T>().showExitDialog();
        }
      },
    );
  }

  @override
  void dispose() {
    provider.removeListener(addListener);
    super.dispose();
  }
}
