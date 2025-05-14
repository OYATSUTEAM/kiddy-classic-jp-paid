import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../setting.dart';

class LineSpaceBPageState {
  final bool isStarted;
  final bool isCompleted;
  final bool isAllCompleted;
  final int level;

  LineSpaceBPageState({
    required this.isStarted,
    required this.isCompleted,
    required this.isAllCompleted,
    required this.level,
  });
}

class LineSpaceBPageStateNotifier extends StateNotifier<LineSpaceBPageState> {
  int _completedCount = 0;
  int _targetCount = 0;
  int _correctCount = 0;
  List<bool> isPushed = List.empty(growable: true);
  List<LineSpaceButtonSetting> button = List.empty(growable: true);
  final _audioPlayer = AudioPlayer();
  final _completeAudioPlayer = AudioPlayer();
  final _startAudioPlayer = AudioPlayer();

  LineSpaceBPageStateNotifier()
      : super(
          LineSpaceBPageState(
            isStarted: false,
            isCompleted: false,
            isAllCompleted: false,
            level: 0,
          ),
        );

  void init(BuildContext context, bool lineType) {
    button = getLineSpaceBButtonSetting(context, state.level);
    for (int i = 0; i < button.length; i++) {
      if (button[i].type == lineType) {
        _correctCount++;
      }
    }
    _targetCount = button.length;
    isPushed = List.filled(_targetCount, false);
  }

  void push(int idx, BuildContext context, bool lineType) async {
    if (_targetCount <= 0) {
      init(context, lineType);
    }
    if (state.isCompleted) {
      return;
    }

    if (idx >= button.length) {
      return;
    }

    if (button[idx].type == lineType) {
      if (isPushed[idx]) return;
      // 正解
      isPushed[idx] = true;
      _completedCount++;

      // if (_audioPlayer != null) {
      //   await _audioPlayer.stop();
      // }

      await _audioPlayer.setAsset('assets/sounds/002.mp3');
       _audioPlayer.play();

      // await Future.delayed(const Duration(seconds: 2));

      // await _audioPlayer.stop();

      if (_completedCount >= _correctCount) {
        // if (_completeAudioPlayer != null) {
        //   await _completeAudioPlayer.stop();
        // }

        _completeAudioPlayer.setAsset('assets/sounds/003_g.mp3');
        _completeAudioPlayer.play();

        state = LineSpaceBPageState(
          isStarted: true,
          isCompleted: true,
          isAllCompleted: false,
          level: state.level,
        );
        // await Future.delayed(const Duration(seconds: 2));

        // if (context.mounted) {
        //   await _completeAudioPlayer.stop();
        // }
      }
    } else {
      // 不正解
      _audioPlayer.setAsset('assets/sounds/005_e.mp3');
      _audioPlayer.play();
    }
  }

  void start(BuildContext context, bool lineType) async {
    init(context, lineType);
    // if (_startAudioPlayer != null) {
    //   await _startAudioPlayer.stop();
    // }
    _startAudioPlayer.setAsset('assets/sounds/car.mp3');
    _startAudioPlayer.play();

    state = LineSpaceBPageState(
      isStarted: true,
      isCompleted: false,
      isAllCompleted: false,
      level: state.level,
    );
    // await Future.delayed(const Duration(seconds: 4));
    // await _startAudioPlayer.stop();
  }

  void initStart(BuildContext context, bool lineType) {
    init(context, lineType);
    _targetCount = 0;
    _correctCount = 0;
    _completedCount = 0;
    state = LineSpaceBPageState(
      isStarted: false,
      isCompleted: false,
      isAllCompleted: false,
      level: 0,
    );
  }

  void next() {
    int level = state.level + 1;
    if (level >= lineBTypeNum) {
      end();
      return;
    }
    state = LineSpaceBPageState(
      isStarted: false,
      isCompleted: false,
      isAllCompleted: false,
      level: level,
    );
  }

  void end() async {
    await _audioPlayer.setAsset('assets/sounds/next.mp3');
    _audioPlayer.play();
    state = LineSpaceBPageState(
      isStarted: true,
      isCompleted: true,
      isAllCompleted: true,
      level: state.level,
    );
    await Future.delayed(const Duration(seconds: 4));

    if (mounted) {
      await _audioPlayer.stop();
    }
  }

  void reset() {
    _targetCount = 0;
    _correctCount = 0;
    _completedCount = 0;
    isPushed.clear();
    button.clear();
    state = LineSpaceBPageState(
      isStarted: false,
      isCompleted: false,
      isAllCompleted: false,
      level: 0,
    );
  }
}

final lineSpaceBPageNotifierProvider =
    StateNotifierProvider<LineSpaceBPageStateNotifier, LineSpaceBPageState>(
  (ref) => LineSpaceBPageStateNotifier(),
);
