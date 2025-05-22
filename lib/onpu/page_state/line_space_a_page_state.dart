import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import '../widget/line_space_sticker.dart';
import '../setting.dart';

class LineSpaceAPageState {
  final bool isPreStarted;
  final bool isStarted;
  final bool isCompleted;
  final bool isAllCompleted;
  final int level;

  LineSpaceAPageState({
    required this.isPreStarted,
    required this.isStarted,
    required this.isCompleted,
    required this.isAllCompleted,
    required this.level,
  });
}

class LineSpaceAPageStateNotifier extends StateNotifier<LineSpaceAPageState> {
  int _completedCount = 0;
  int _targetCount = 0;
  //List<bool> _isCompleted = List.empty(growable: true);
  final _audioPlayer = AudioPlayer();
  final errorAudioPlayer = AudioPlayer();
  final _completeAudioPlayer = AudioPlayer();
  List<Function> resetFuncs = List.empty(growable: true);

  LineSpaceAPageStateNotifier()
      : super(
          LineSpaceAPageState(
              isPreStarted: false,
              isStarted: false,
              isCompleted: false,
              isAllCompleted: false,
              level: 0),
        );

  void init(bool type) {
    _targetCount = type ? 5 : 4;
    //_isCompleted = List.filled(_targetCount, false);
  }

  void lineSpaceCheck(
      BuildContext context,
      Offset offset,
      StreamController<StickerPosition> details,
      Size stickerSize,
      bool type) async {
    if (_targetCount <= 0) {
      init(type);
    }
    if (state.isCompleted || state.isAllCompleted) {
      return;
    }

    ViewSetting fivelineSetting = getFiveLineAViewSetting(context, type);
    List<Offset> fiveLines = getFiveLineAPosition(context, type);

    if (offset.dx + stickerSize.width / 2 < fivelineSetting.position.dx ||
        offset.dx + stickerSize.width / 2 >
            fivelineSetting.position.dx + fivelineSetting.size.width) {
      // if (_audioPlayer != null) {
      //   await _audioPlayer.stop();
      // }
      errorAudioPlayer.setAsset('assets/sounds/005_e.mp3');
      errorAudioPlayer.play();
      // await Future.delayed(const Duration(seconds: 1));
      return;
    }

    // 線、間のチェック
    double range = fivelineSetting.size.height / 4;
    double ofsY = stickerSize.height / 2;
    bool success = false;
    if (type) {
      // 線の場合
      for (int i = 0; i < _targetCount; i++) {
        /*if (_isCompleted[i]) {
          continue;
        }*/
        if (fiveLines[i].dy - range < offset.dy + ofsY &&
            offset.dy + ofsY < fiveLines[i].dy + range) {
          //_isCompleted[i] = true;
          _completedCount++;
          success = true;

          // if (_audioPlayer != null) {
          //   await _audioPlayer.stop();
          // }

          details.sink.add(StickerPosition(
            left: offset.dx,
            top: fiveLines[i].dy - stickerSize.height / 2,
            target: i.toDouble(),
          ));
          _audioPlayer.setAsset('assets/sounds/002.mp3');
          _audioPlayer.play();
          // if (mounted) {
          //   await _audioPlayer.stop();
          // }
          if (_completedCount >= _targetCount) {
            // if (_audioPlayer != null) {
            //   await _audioPlayer.stop();
            // }

            await Future.delayed(const Duration(milliseconds: 600));
            _completeAudioPlayer.setAsset('assets/sounds/003_g.mp3');
            _completeAudioPlayer.play();
            state = LineSpaceAPageState(
              isPreStarted: true,
              isStarted: false,
              isCompleted: true,
              isAllCompleted: false,
              level: state.level,
            );
            // await Future.delayed(const Duration(seconds: 2));
            // if (mounted) {
            //   await _completeAudioPlayer.stop();
            // }
          }
          break;
        }
      }
    } else {
      // 間の場合
      double space = fivelineSetting.size.height / 2;
      for (int i = 0; i < _targetCount; i++) {
        /*if (_isCompleted[i]) {
          continue;
        }*/
        if (fiveLines[i].dy + space - range < offset.dy + ofsY &&
            offset.dy + ofsY < fiveLines[i].dy + space + range) {
          //_isCompleted[i] = true;
          _completedCount++;
          success = true;
          details.sink.add(StickerPosition(
            left: offset.dx,
            top: fiveLines[i].dy - stickerSize.height / 2 + space,
            target: i + 0.5,
          ));

          // if (_audioPlayer != null) {
          //   await _audioPlayer.stop();
          // }

          _audioPlayer.setAsset('assets/sounds/002.mp3');
          _audioPlayer.play();
          // await Future.delayed(const Duration(seconds: 1));
          // if (mounted) {
          //   await _audioPlayer.stop();
          // }

          if (_completedCount >= _targetCount) {
            // if (_audioPlayer != null) {
            //   await _audioPlayer.stop();
            // }
            await Future.delayed(const Duration(milliseconds: 600));
            _completeAudioPlayer.setAsset('assets/sounds/003_g.mp3');
            _completeAudioPlayer.play();

            state = LineSpaceAPageState(
              isPreStarted: true,
              isStarted: false,
              isCompleted: true,
              isAllCompleted: false,
              level: state.level,
            );
            // await Future.delayed(const Duration(seconds: 2));
            // if (mounted) {
            //   await _completeAudioPlayer.stop();
            // }
          }
          break;
        }
      }
    }

    if (!success) {
      // if (_audioPlayer != null) {
      //   await _audioPlayer.stop();
      // }

      _audioPlayer.setAsset('assets/sounds/005_e.mp3');
      _audioPlayer.play();
      // await Future.delayed(const Duration(seconds: 1));
      // if (mounted) {
      //   await _audioPlayer.stop();
      // }
    }
  }

  void start() async {
    // if (_audioPlayer != null) {
    //   await _audioPlayer.stop();
    // }
    _audioPlayer.setAsset('assets/sounds/car.mp3');
    _audioPlayer.play();

    state = LineSpaceAPageState(
      isPreStarted: true,
      isStarted: true,
      isCompleted: false,
      isAllCompleted: false,
      level: 0,
    );
    // await Future.delayed(const Duration(seconds: 4));
    // if (mounted) {
    //   await _audioPlayer.stop();
    // }
  }

  void next() async {
    _targetCount = 0;
    _completedCount = 0;
    //_isCompleted = List.filled(_targetCount, false);
    int level = state.level;
    level++;
    if (level >= spaceStickerPatternNum) {
      level = state.level;

      end();
      _audioPlayer.setAsset('assets/sounds/next.mp3');
      _audioPlayer.play();
      // await Future.delayed(const Duration(seconds: 1));
      // if (mounted) {
      //   await _audioPlayer.stop();
      // }

      return;
    } else {
      if (resetFuncs.isNotEmpty) {
        for (var element in resetFuncs) {
          element();
        }
      }
    }
    // if (_audioPlayer != null) {
    //   await _audioPlayer.stop();
    // }

    state = LineSpaceAPageState(
      isPreStarted: true,
      isStarted: true,
      isCompleted: false,
      isAllCompleted: false,
      level: level,
    );
    _audioPlayer.setAsset('assets/sounds/next.mp3');
    _audioPlayer.play();
    // await Future.delayed(const Duration(seconds: 1));
    // if (mounted) {
    //   await _audioPlayer.stop();
    // }
  }

  void setResetFunc(Function func) {
    resetFuncs.add(func);
  }

  void end() {
    state = LineSpaceAPageState(
      isPreStarted: true,
      isStarted: true,
      isCompleted: true,
      isAllCompleted: true,
      level: state.level,
    );
  }

  void reset() {
    _completedCount = 0;
    _targetCount = 0;
    //_isCompleted.clear();
    resetFuncs = List.empty(growable: true);
    state = LineSpaceAPageState(
      isPreStarted: false,
      isStarted: false,
      isCompleted: false,
      isAllCompleted: false,
      level: 0,
    );
  }
}

final lineSpaceAPageNotifierProvider =
    StateNotifierProvider<LineSpaceAPageStateNotifier, LineSpaceAPageState>(
  (ref) => LineSpaceAPageStateNotifier(),
);
