import 'dart:math';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import '../setting.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// かきましょう 画面の状態
///
/// 一旦、書き終わったかどうかのみを管理する
class LineDrawPageState {
  /// 書き終わったかどうか
  final bool isCompleted;

  LineDrawPageState({
    required this.isCompleted,
  });
}

class LineDrawPageStateNotifier extends StateNotifier<LineDrawPageState> {
  int _completedCount = 0;
  int targetCount = 5;
  final List<bool> _isCompleted = [false, false, false, false, false];
  final _audioPlayer = AudioPlayer();
  double oldCorrectPosY = 0;

  final List<List<Offset>> _points =
      List<List<Offset>>.empty(growable: true); // 点のリスト。繋いで線として描画する
  LineDrawPageStateNotifier()
      : super(
          LineDrawPageState(isCompleted: false),
        );

  void init(BuildContext context, int soundNo) {
    LineDrawTargetViewSetting viewSetting =
        getDrawViewSetting(context, soundNo);
    oldCorrectPosY = viewSetting.targets[0].position.dy;
  }

  void addPoints(Offset startPoint) {
    if (_completedCount >= targetCount) return;
    _points.add([startPoint]);
  }

  void updatePoints(Offset nextPoint) {
    if (_completedCount >= targetCount) return;
    List<Offset> offsetList = List<Offset>.of(_points.last)..add(nextPoint);
    _points.last = offsetList;
  }

  // 現在の線の状態をチェックして、ターゲットに重なっているかどうかを判定する
  void checkPoints(BuildContext context, Size screenSize, int soundNo) {
    LineDrawTargetViewSetting viewSetting =
        getDrawViewSetting(context, soundNo);
    targetCount = viewSetting.targets.length;
    if (_completedCount >= targetCount) return;
    if (_points.isEmpty) return;
    int last = _points.length - 1;
    if (_points[last].isEmpty) return;

    double size = getLineDrawTargetSize(context).width;
    for (int i = 0; i < targetCount; i++) {
      if (_isCompleted[i]) continue;
      for (int j = 0; j < _points[last].length; j++) {
        double dx = _points[last][j].dx;
        double dy = _points[last][j].dy;
        Offset targetPos =
            viewSetting.targets[i].position + Offset(size / 2, size / 2);
        double len = sqrt(((dx - targetPos.dx) * (dx - targetPos.dx)) +
            ((dy - targetPos.dy) * (dy - targetPos.dy)));
        if (len < size / 2) {
          _completedCount++;
          _isCompleted[i] = true;
          if (_completedCount >= targetCount) {
            state = LineDrawPageState(isCompleted: true);
            _audioPlayer.setAsset('assets/sounds/003_g.mp3');
            _audioPlayer.play();
            return;
          }
          break;
        }
      }
    }
  }

  List<List<Offset>> getPoints() {
    return _points;
  }

  // 画面サイズが変わった際に、線の位置をターゲット位置に合わせて補正する
  void adjustPosints(BuildContext context, Size oldScreenSize,
      Size currentScreenSize, int soundNo) {
    LineDrawTargetViewSetting viewSetting =
        getDrawViewSetting(context, soundNo);
    double ofsY = viewSetting.targets[0].position.dy - oldCorrectPosY;
    int oldIndex = getScreenSizeIndex(oldScreenSize);
    int currentIndex = getScreenSizeIndex(currentScreenSize);
    for (int i = 0; i < _points.length; i++) {
      for (int j = 0; j < _points[i].length; j++) {
        double dy =
            _points[i][j].dy * currentScreenSize.height / oldScreenSize.height;
        if (currentIndex != oldIndex) {
          dy = _points[i][j].dy + ofsY;
        }
        _points[i][j] = Offset(
          _points[i][j].dx * currentScreenSize.width / oldScreenSize.width,
          dy,
        );
      }
    }
    oldCorrectPosY = viewSetting.targets[0].position.dy;
  }

  void reset() {
    _completedCount = 0;
    for (int i = 0; i < _isCompleted.length; i++) {
      _isCompleted[i] = false;
    }
    _points.clear();
    state = LineDrawPageState(isCompleted: false);
  }
}

final lineDrawPageStateNotifierProvider =
    StateNotifierProvider<LineDrawPageStateNotifier, LineDrawPageState>(
  (ref) => LineDrawPageStateNotifier(),
);
