import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../setting.dart';
import '../widget/puzzle_piece.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:just_audio/just_audio.dart';

class PuzzlePageState {
  final bool isStarted;
  final bool isCompleted;
  final bool isAllCompleted;

  PuzzlePageState({
    required this.isStarted,
    required this.isCompleted,
    required this.isAllCompleted,
  });
}

class PieceState {
  int index;
  final int angle;
  final Offset position;

  PieceState({
    required this.index,
    required this.angle,
    required this.position,
  });
}

class PuzzlePageStateNotifier extends StateNotifier<PuzzlePageState> {
  int _completedCount = 0;
  int _targetCount = 0;
  List<bool> _isCompleted = List.empty(growable: true);
  List<PieceState> piecesInit = List.empty(growable: true);
  final _audioPlayer = AudioPlayer();
  final _completeAudioPlayer = AudioPlayer();
  final _bgmAudioPlayer = AudioPlayer();
  List<Function> resetFunctions = List.empty(growable: true);
  bool _isBGMPlaying = false;
  bool _isStart = false;

  PuzzlePageStateNotifier()
      : super(
          PuzzlePageState(
            isStarted: false,
            isCompleted: false,
            isAllCompleted: false,
          ),
        );

  void init(BuildContext context, bool type) {
    _targetCount = pieceNums[type ? 0 : 1];
    _completedCount = 0;
    _isCompleted = List.filled(_targetCount, false);
    //piecesInit.clear();
    List<int> indexes = List.generate(_targetCount, (index) => index);
    indexes.shuffle();
    for (int i = 0; i < _targetCount; i++) {
      ViewSetting viewSetting = getPieceViewSetting(context, i);
      int angle = Random().nextInt(360);
      piecesInit.add(PieceState(
          index: indexes[i], angle: angle, position: viewSetting.position));
    }
    bgmPlay();
  }

  void bgmPlay() {
    if (!_isBGMPlaying) {
      // _bgmAudioPlayer.setReleaseMode(ReleaseMode.loop);
      _bgmAudioPlayer.setAsset('assets/sounds/BGM_01.mp3' );
      _bgmAudioPlayer.play(  );
      _isBGMPlaying = true;
    }
  }

  List<PieceState> getPieceStates(BuildContext context, bool type) {
    if (_targetCount <= 0) {
      init(context, type);
    }
    return piecesInit;
  }

  List<PieceState> getPieceStartStates(BuildContext context, bool type) {
    List<PieceState> pieceStartStates = List.empty(growable: true);
    for (int i = 0; i < pieceNums[type ? 0 : 1]; i++) {
      ViewSetting viewSetting = getPieceViewSetting(context, i);

      pieceStartStates
          .add(PieceState(index: i, angle: 0, position: viewSetting.position));
    }
    return pieceStartStates;
  }

  Offset getCorrectPosition(BuildContext context, int idx) {
    ViewSetting viewSetting = getPieceViewSetting(context, idx);
    return viewSetting.position;
  }

  void reset() {
    _targetCount = 0;
    _completedCount = 0;
    _isCompleted = List.empty(growable: true);
    piecesInit = List.empty(growable: true);
    state = PuzzlePageState(
      isStarted: false,
      isCompleted: false,
      isAllCompleted: false,
    );
  }

  void start(BuildContext context, bool type) {
    if (_isStart) {
      return;
    }
    _isStart = true;

    _audioPlayer.setAsset('assets/sounds/car.mp3');
    _audioPlayer.play();
    init(context, type);

    Future.delayed(Duration(seconds: 3), () {
      state = PuzzlePageState(
        isStarted: true,
        isCompleted: false,
        isAllCompleted: false,
      );
    });
  }

  void pieceCheck(BuildContext context, int idx, Offset offset,
      StreamController<PiecePosition> details) {
    if (idx > _targetCount) {
      return;
    }
    if (state.isCompleted || state.isAllCompleted) {
      return;
    }

    double rangeX = 476 / 4;
    double rangeY = 642 / 4;
    if (_isCompleted[idx]) {
      return;
    }

    ViewSetting viewSetting = getPieceViewSetting(context, idx);
    Offset pos = viewSetting.position;
    if (pos.dx - rangeX < offset.dx &&
        offset.dx < pos.dx + rangeX &&
        pos.dy - rangeY < offset.dy &&
        offset.dy < pos.dy + rangeY) {
      _isCompleted[idx] = true;
      _completedCount++;
      _audioPlayer.setAsset('assets/sounds/success.mp3');
      _audioPlayer.play();
      details.add(PiecePosition(
        angle: 0,
        left: pos.dx,
        top: pos.dy,
      ));
    }

    if (_completedCount >= _targetCount) {
      _completeAudioPlayer.setAsset('assets/sounds/complete.mp3');
      _completeAudioPlayer.play();
      state = PuzzlePageState(
        isStarted: state.isStarted,
        isCompleted: true,
        isAllCompleted: false,
      );
    }
  }

  void next() {
    _targetCount = 0;
    _completedCount = 0;
    _isCompleted = List.empty(growable: true);
    piecesInit = List.empty(growable: true);
    _isStart = false;
    for (int i = 0; i < resetFunctions.length; i++) {
      resetFunctions[i]();
    }
    _audioPlayer.setAsset('assets/sounds/next.mp3');
    _audioPlayer.play();
    _bgmAudioPlayer.stop();
    _isBGMPlaying = false;
    state = PuzzlePageState(
      isStarted: false,
      isCompleted: false,
      isAllCompleted: true,
    );
  }

  void setResetFunction(Function func) {
    resetFunctions.add(func);
  }
}

final puzzlePageNotifierProvider =
    StateNotifierProvider<PuzzlePageStateNotifier, PuzzlePageState>(
  (ref) => PuzzlePageStateNotifier(),
);
