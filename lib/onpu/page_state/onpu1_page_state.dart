import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import '../setting.dart';
import 'package:flutter/foundation.dart';

class Onpu1PageState {
  final bool isStarted;
  final bool isCompleted;
  final bool isAllCompleted;
  final int level;
  final int index;

  Onpu1PageState({
    required this.isStarted,
    required this.isCompleted,
    required this.isAllCompleted,
    required this.level,
    required this.index,
  });
}

class Onpu1PageStateNotifier extends StateNotifier<Onpu1PageState> {
  bool _speedType = true;
  List<bool> _isPushed = List.empty(growable: true);
  List<FlashCardSetting> frashCards = List.empty(growable: true);
  List<int> soundIndexes = List.generate(7, (index) => index);
  final _audioPlayer = AudioPlayer();
  final _audioPlayer2 = AudioPlayer();
  final _backgroundPlayer = AudioPlayer();
  final _completedAudioPlayer = AudioPlayer();
  bool _isTransitioning = false;
  int _flashGeneration = 0;

  Onpu1PageStateNotifier()
      : super(Onpu1PageState(
            isStarted: false,
            isCompleted: false,
            isAllCompleted: false,
            level: 0,
            index: 0));

  void init() {
    _isPushed = List.filled(flashCardSettings.length, false);
    frashCards.clear();
    frashCards = [...flashCardSettings];
    frashCards.shuffle();
    soundIndexes.shuffle();
  }

  void start(bool speedType) {
    _speedType = speedType;
    if (frashCards.isEmpty) {
      init();
    }
    _audioPlayer.setAsset(
        speedType ? 'assets/sounds/001.mp3' : 'assets/sounds/car.mp3');
    _audioPlayer.play();
    _backgroundPlayer.setAsset('assets/sounds/back.mp3');
    _backgroundPlayer.play();
    // _audioPlayer2.setAsset('assets/sounds/OnpuGame1/008.mp3');
    // _audioPlayer2.play();
    if (state.index != 7) {
      state = Onpu1PageState(
          isStarted: true,
          isCompleted: false,
          isAllCompleted: false,
          level: state.level,
          index: 0);
    } else {
      state = Onpu1PageState(
          isStarted: true,
          isCompleted: false,
          isAllCompleted: false,
          level: state.level,
          index: state.index);
    }

    flash(generation: _flashGeneration);
  }

  List<FlashCardSetting> getFrashCards() {
    if (frashCards.isEmpty) {
      init();
    }
    return frashCards;
  }

  bool getSpeedType() {
    return _speedType;
  }

  int getSoundNo() {
    if (frashCards.isEmpty) {
      init();
    }
    int level = state.level;
    if (level >= soundIndexes.length) {
      level = soundIndexes.length - 1;
    }
    return soundIndexes[level];
  }

  void push() {
    if (_isPushed[state.index]) {
      return;
    }

    if (state.index >= frashCards.length) {
      return;
    }
    if (frashCards[state.index].soundIdx == soundIndexes[state.level]) {
      if (state.isCompleted) return;
      state = Onpu1PageState(
          isStarted: true,
          // isCompleted: false,
          isCompleted: true,
          isAllCompleted: false,
          // level: state.level,
          level: state.level,
          // index: 7);/
          // index: state.index);
          index: 0);
      _audioPlayer.setAsset('assets/sounds/002.mp3');
      _audioPlayer.play();
    } else {
      _audioPlayer.setAsset('assets/sounds/OnpuGame1/005_e.mp3');
      _audioPlayer.play();
    }
    _isPushed[state.index] = true;
  }

  bool getPushed(int idx) {
    if (idx >= frashCards.length) {
      return true;
    }
    return _isPushed[idx];
  }

  void next() {
    if (_isTransitioning) return;
    _isTransitioning = true;
    int nextLevel = state.level + 1;
    // state = Onpu1PageState(
    //     isStarted: true,
    //     isCompleted: false,
    //     isAllCompleted: false,
    //     level: nextLevel,
    //     index: 0);

    _audioPlayer.setAsset('assets/sounds/next.mp3');
    _audioPlayer.play();
    if (nextLevel >= soundIndexes.length) {
      Future.delayed(Duration(milliseconds: 700), () {
        _completedAudioPlayer.setAsset(_speedType
            ? 'assets/sounds/OnpuGame1/006_dog.mp3'
            : 'assets/sounds/OnpuGame1/005_cat.mp3');
        _completedAudioPlayer.play();
      });
      state = Onpu1PageState(
          isStarted: true,
          isCompleted: true,
          isAllCompleted: true,
          level: nextLevel,
          index: state.index);
      _isTransitioning = false;
      return;
    }
    if (state.isAllCompleted) {
      _isTransitioning = false;
      return;
    }
    state = Onpu1PageState(
        isStarted: true,
        isCompleted: false,
        isAllCompleted: false,
        level: nextLevel,
        index: 0);
    _audioPlayer2.setAsset('assets/sounds/OnpuGame1/008.mp3');
    _audioPlayer2.play();
    _isPushed = List.filled(flashCardSettings.length, false);
    frashCards = [...flashCardSettings];
    frashCards.shuffle();

    if (state.isCompleted) {
      _isTransitioning = false;
      return;
    }
    flash(
        onComplete: () {
          _isTransitioning = false;
        },
        generation: _flashGeneration);
  }

  bool isEndFrash() {
    return state.level >= soundIndexes.length;
  }

  void flash({VoidCallback? onComplete, int? generation}) {
    final int currentGeneration = generation ?? _flashGeneration;
    final int millisec = 1500;
    final int millisec2 = 3000;
    Future.delayed(Duration(milliseconds: _speedType ? millisec : millisec2),
        () {
      if (currentGeneration != _flashGeneration) {
        return;
      }
      if (state.isAllCompleted) {
        if (onComplete != null) onComplete();
        return;
      }
      if (state.isCompleted) {
        if (onComplete != null) onComplete();
        return;
      }
      int index = state.index;
      index++;
      int level = state.level;
      bool complete = false;
      if (index >= frashCards.length) {
        level++;
        complete = true;
      } else {
        _audioPlayer2.setAsset('assets/sounds/OnpuGame1/008.mp3');
        _audioPlayer2.play();
      }

      state = Onpu1PageState(
          isStarted: true,
          isCompleted: complete,
          isAllCompleted: false,
          level: level,
          index: index);
      // index: index);

      if (!complete) {
        flash(onComplete: onComplete, generation: currentGeneration);
      } else {
        if (onComplete != null) onComplete();
      }
    });
  }

  void reset() {
    _flashGeneration++;
    _isPushed = List.empty(growable: true);
    _isPushed.clear();
    _backgroundPlayer.stop();
    _audioPlayer.stop();
    _audioPlayer2.stop();
    _completedAudioPlayer.stop();
    frashCards.clear();
    state = Onpu1PageState(
        isStarted: false,
        isCompleted: false,
        isAllCompleted: false,
        level: 0,
        index: 0);
  }
}

final onpu1PageNotifierProvider =
    StateNotifierProvider<Onpu1PageStateNotifier, Onpu1PageState>(
  (ref) => Onpu1PageStateNotifier(),
);
