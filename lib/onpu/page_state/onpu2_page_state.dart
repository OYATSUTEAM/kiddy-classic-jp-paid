import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import '../setting.dart';

class Onpu2PageState {
  final int level;
  final bool isStarted;
  final bool isCompleted;

  Onpu2PageState({
    required this.level,
    required this.isStarted,
    required this.isCompleted,
  });
}

class Onpu2PageStateNotifier extends StateNotifier<Onpu2PageState> {
  int _correctCount = 0;
  int _targetCount = 0;
  int _keyType = -1;
  final _audioPlayer = AudioPlayer();
  List<OnpuQuestionSetting> question = List.empty(growable: true);

  Onpu2PageStateNotifier()
      : super(Onpu2PageState(level: 0, isStarted: false, isCompleted: false));

  void init(int keyType, bool soundType) {
    _correctCount = 0;
    question = (keyType < 2)
        ? (keyType == 0)
            ? [...onpuKenbanQuestions]
            : [...onpuIconQuestions]
        : [...getLineSpaceCQuestions(keyType == 2, soundType)];
    question.shuffle();
    _targetCount = question.length;
    _keyType = keyType;
  }

  void nextLevel() {
    if (state.isCompleted) {
      return;
    }
    if (isCompleted()) {
      return;
    }
    int level = state.level;
    level++;
    state = Onpu2PageState(level: level, isStarted: true, isCompleted: false);
  }

  void start() {
    _audioPlayer.setAsset(_keyType < 2 ? 'assets/sounds/car.mp3' : 'assets/sounds/001.mp3');
    _audioPlayer.play();
    state =
        Onpu2PageState(level: state.level, isStarted: true, isCompleted: false);
  }

  bool isCompleted() {
    return (question.isNotEmpty && state.level >= question.length);
  }

  int getCorrectCount() {
    return _correctCount;
  }

  void checkCorrect(int idx) async {
    if (isCompleted()) {
      return;
    }

    if (question[state.level].correctIdx == idx) {
      // if (_audioPlayer != null) {
      //   await _audioPlayer.stop();
      // }

       _audioPlayer.setAsset('assets/sounds/002.mp3');
       _audioPlayer.play();

      _correctCount++;
      nextLevel();
      // await Future.delayed(const Duration(seconds: 2));
      // if (mounted) {
      //   await _audioPlayer.stop();
      // }
    } else {
      // if (_audioPlayer != null) {
      //   await _audioPlayer.stop();
      // }
       _audioPlayer.setAsset('assets/sounds/005_e.mp3');
       _audioPlayer.play();

      // if (mounted) {
      //   await _audioPlayer.stop();
      // }
    }
  }

  OnpuQuestionSetting getQuestion(int level, int keyType, bool soundType) {
    if (_targetCount <= 0 || _keyType != keyType) {
      init(keyType, soundType);
    }

    if (level >= question.length) {
      return question[question.length - 1];
    }
    return question[level];
  }

  void end() async {
    _audioPlayer.setAsset('assets/sounds/next.mp3');
    _audioPlayer.play();
    state =
        Onpu2PageState(level: state.level, isStarted: true, isCompleted: true);
    // await Future.delayed(const Duration(seconds: 4));
  }

  void reset() {
    _correctCount = 0;
    question = List.empty(growable: true);
    _targetCount = 0;
    _keyType = -1;
    state = Onpu2PageState(level: 0, isStarted: false, isCompleted: false);
  }
}

final onpu2PageNotifierProvider =
    StateNotifierProvider<Onpu2PageStateNotifier, Onpu2PageState>(
  (ref) => Onpu2PageStateNotifier(),
);
