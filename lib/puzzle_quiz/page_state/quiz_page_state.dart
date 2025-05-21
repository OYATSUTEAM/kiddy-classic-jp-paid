import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import '../setting.dart';

class QuizPageState {
  final bool isPreStarted;
  final bool isStarted;
  final bool isCompleted;
  final int level;
  final int lap;

  QuizPageState({
    required this.isPreStarted,
    required this.isStarted,
    required this.isCompleted,
    required this.level,
    required this.lap,
  });
}

class QuizPageStateNotifier extends StateNotifier<QuizPageState> {
  final _audioPlayer = AudioPlayer();
  final _quizAudioPlayer = AudioPlayer();
  bool isInit = false;
  List<List<int>> correctIndexes = List.empty(growable: true);
  QuizPageStateNotifier()
      : super(QuizPageState(
          isPreStarted: false,
          isStarted: false,
          isCompleted: false,
          level: 0,
          lap: 0,
        ));
  void init() {
    isInit = true;
    for (int i = 0; i < soundSettings.length; i++) {
      List<int> indexes = List.generate(quizNum, (index) => index);
      indexes.shuffle();
      correctIndexes.add(indexes);
    }
  }

  void start() {
    if (!isInit) {
      init();
    }
    int correctIndex = correctIndexes[state.level][state.lap];
    // _quizAudioPlayer
    //     .play(AssetSource(soundSettings[state.level][correctIndex]));
    _quizAudioPlayer.setAsset(soundSettings[state.level][correctIndex]);
    _quizAudioPlayer.play();

    state = QuizPageState(
      isPreStarted: true,
      isStarted: true,
      isCompleted: false,
      level: state.level,
      lap: state.lap,
    );
  }

  bool isCompleted() {
    return (state.level >= soundSettings.length && state.lap >= 2);
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
    int lap = state.lap;
    if (level >= soundSettings.length) {
      lap++;
      if (lap > 2) {
        end();
        return;
      } else {
        level = 0;
      }
    }
    int correctIndex = correctIndexes[level][lap];
    _quizAudioPlayer.setAsset(soundSettings[level][correctIndex]);
    _quizAudioPlayer.play();

    state = QuizPageState(
      isPreStarted: true,
      isStarted: true,
      isCompleted: false,
      level: level,
      lap: lap,
    );
  }

  void checkCorrect(int idx) {
    if (!state.isStarted || isCompleted()) {
      return;
    }

    int correctIndex = correctIndexes[state.level][state.lap];
    if (correctIndex == idx) {
      _audioPlayer.setAsset('assets/sounds/002.mp3');
      _audioPlayer.play();
      state = QuizPageState(
        isPreStarted: true,
        isStarted: false,
        isCompleted: false,
        level: state.level,
        lap: state.lap,
      );
    } else {
      _audioPlayer.setAsset('assets/sounds/005_e.mp3');
      _audioPlayer.play();
    }
  }

  void end() {
    _audioPlayer.setAsset('assets/sounds/next.mp3');
    _audioPlayer.play();
    state = QuizPageState(
      isPreStarted: true,
      isStarted: true,
      isCompleted: true,
      level: state.level,
      lap: state.lap,
    );
  }

  void reset() {
    state = QuizPageState(
      isPreStarted: false,
      isStarted: false,
      isCompleted: false,
      level: 0,
      lap: 0,
    );
  }
}

final quizPageNotifierProvider =
    StateNotifierProvider<QuizPageStateNotifier, QuizPageState>(
        (ref) => QuizPageStateNotifier());
