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
  List<bool> _isCircle = List<bool>.filled(5, false);
  List<bool> _isHorizontalLine = List<bool>.filled(5, false);
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
    print('this is sound no $soundNo ==============================');
    LineDrawTargetViewSetting viewSetting =
        getDrawViewSetting(context, soundNo);
    targetCount = viewSetting.targets.length;
    print('this is called every time=============');

    if (_completedCount >= targetCount) return;
    if (_points.isEmpty) return;
    int last = _points.length - 1;
    if (_points[last].isEmpty) return;
    double size = getLineDrawTargetSize(context).width;
    for (int i = 0; i < targetCount; i++) {
      if (_isCompleted[i]) continue;
      print('target Count is $targetCount ');
      // Get target center position
      Offset targetPos =
          viewSetting.targets[i].position + Offset(size / 2, size / 2);

      // For do note (soundNo == 0), we need both a circle and a horizontal line
      if (soundNo == 0) {
        // Check if we have enough points for circle detection
        if (_points[last].length < 8) {
          print('Not enough points for circle: ${_points[last].length}');
          continue;
        }

        // Check if this is a circle
        double totalDistance = 0;
        double minDistance = double.infinity;
        double maxDistance = 0;

        for (int j = 0; j < _points[last].length; j++) {
          double dx = _points[last][j].dx;
          double dy = _points[last][j].dy;
          double len = sqrt(((dx - targetPos.dx) * (dx - targetPos.dx)) +
              ((dy - targetPos.dy) * (dy - targetPos.dy)));

          totalDistance += len;
          minDistance = min(minDistance, len);
          maxDistance = max(maxDistance, len);
        }

        double avgDistance = totalDistance / _points[last].length;
        print('size is $size');
        print(
            'Checking target $i at position: ${targetPos.dx}, ${targetPos.dy}');
        print(
            'Circle stats - avg: $avgDistance, min: $minDistance, max: $maxDistance');

        // Check if current line is a circle
        bool isCurrentLineCircle =
            avgDistance > size * 0.1 && // Not too close to center
                avgDistance < size * 0.7 && // Not too far from center
                (maxDistance - minDistance) < size * 0.4 && // Circle is round
                _points[last].length >= 8; // Enough points for circle

        // Check if current line is a horizontal line
        int pointsNearCenter = 0;
        double minX = double.infinity;
        double maxX = 0;

        for (int j = 0; j < _points[last].length; j++) {
          double dy = _points[last][j].dy;
          double dx = _points[last][j].dx;

          // Check if point is near the horizontal center line AND near the target's horizontal position
          if ((dy - targetPos.dy).abs() < size * 0.1 &&
              (dx - targetPos.dx).abs() < size * 0.8) {
            // Check if point is near target's horizontal position
            pointsNearCenter++;
            minX = min(minX, dx);
            maxX = max(maxX, dx);
          }
        }

        // print('$pointsNearCenter================');
        // print('(maxX - minX) > size * 0.4 : ${(maxX - minX) > size * 0.4}');
        // print(
        //     '(minX - targetPos.dx).abs() < size * 0.5 && (maxX - targetPos.dx).abs() <size * 0.5 : ${(minX - targetPos.dx).abs() < size * 0.5 && (maxX - targetPos.dx).abs() < size * 0.5}');
        print(pointsNearCenter);
        bool isCurrentLineHorizontal =
            pointsNearCenter >= 30 && // Need enough points near center
                (maxX - minX) > size * 0.4;

        //  && // Need to span enough width
        // (minX - targetPos.dx).abs() <
        //     size * 0.5 && // Line should start near target
        // (maxX - targetPos.dx).abs() <
        //     size * 0.5; // Line should end near target
        if (isCurrentLineCircle) {
          _isCircle[i] = true;
          print('Target $i: Circle detected================');
        }
        if (isCurrentLineHorizontal) {
          _isHorizontalLine[i] = true;
          print('Target $i: Horizontal line detected==========');
        }

        // Check if both conditions are met for this target
        if (_isCircle[i] && _isHorizontalLine[i]) {
          _completedCount++;
          _isCompleted[i] = true;
          print(_isHorizontalLine[i]);
          print(
              'Target $i: Both circle and horizontal line completed======================');
          if (_completedCount >= targetCount) {
            state = LineDrawPageState(isCompleted: true);
            _audioPlayer.setAsset('assets/sounds/003_g.mp3');
            _audioPlayer.play();
            return;
          }
        }
      } else {
        // For other notes, just check for circle
        if (_points[last].length < 8) {
          print('Not enough points for circle: ${_points[last].length}');
          continue;
        }

        double totalDistance = 0;
        double minDistance = double.infinity;
        double maxDistance = 0;

        for (int j = 0; j < _points[last].length; j++) {
          double dx = _points[last][j].dx;
          double dy = _points[last][j].dy;
          double len = sqrt(((dx - targetPos.dx) * (dx - targetPos.dx)) +
              ((dy - targetPos.dy) * (dy - targetPos.dy)));

          totalDistance += len;
          minDistance = min(minDistance, len);
          maxDistance = max(maxDistance, len);
        }

        double avgDistance = totalDistance / _points[last].length;
        print(
            'Circle stats - avg: $avgDistance, min: $minDistance, max: $maxDistance');

        bool isCircle = avgDistance > size * 0.2 && // Not too close to center
            avgDistance < size * 0.8 && // Not too far from center
            (maxDistance - minDistance) < size * 0.4 && // Circle is round
            _points[last].length >= 8; // Enough points for circle
        print('Is circle: $isCircle');

        if (isCircle) {
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
    for (int i = 0; i < 5; i++) {
      _isCircle[i] = false;
      _isHorizontalLine[i] = false;
    }
    _points.clear();
    state = LineDrawPageState(isCompleted: false);
  }
}

final lineDrawPageStateNotifierProvider =
    StateNotifierProvider<LineDrawPageStateNotifier, LineDrawPageState>(
  (ref) => LineDrawPageStateNotifier(),
);
