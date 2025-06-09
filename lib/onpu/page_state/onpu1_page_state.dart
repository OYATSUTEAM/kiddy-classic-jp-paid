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
  List<int> soundIndexes = List.generate(8, (index) => index);

  final _audioPlayer = AudioPlayer();
  final _audioPlayer2 = AudioPlayer();
  final _backgroundPlayer = AudioPlayer();
  final _completedAudioPlayer = AudioPlayer();
  final _errorAudioPlayer = AudioPlayer();
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
    print(soundIndexes);
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

    flash('called from start=============');
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

    print('${frashCards[state.index].soundIdx}===============');
    if (frashCards[state.index].soundIdx == soundIndexes[state.level]) {
      if (state.isCompleted) return;
      _audioPlayer.setAsset('assets/sounds/002.mp3');
      _audioPlayer.play();
      state = Onpu1PageState(
          isStarted: true,
          isCompleted: true,
          isAllCompleted: false,
          level: state.level + 1,
          index: 8);
      // state = Onpu1PageState(
      //     isStarted: true,
      //     isCompleted: true,
      //     isAllCompleted: false,
      //     level: state.level + 1,
      //     index: 1);
      // _isPushed = List.filled(flashCardSettings.length, false);
    } else {
      _errorAudioPlayer.setAsset('assets/sounds/OnpuGame1/005_e.mp3');
      _errorAudioPlayer.play();
    }
    if (state.index < 8) _isPushed[state.index] = true;
  }

  bool getPushed(int idx) {
    if (idx >= frashCards.length) {
      return true;
    }
    return _isPushed[idx];
  }

  void next() {
    _audioPlayer.setAsset('assets/sounds/next.mp3');
    _audioPlayer.play();
    if (state.level >= soundIndexes.length) {
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
          level: state.level,
          index: state.index);
      _isTransitioning = false;
      return;
    }
    if (state.isAllCompleted) {
      return;
    }
    if (!state.isCompleted) {
      return;
    }

    _isPushed = List.filled(flashCardSettings.length, false);
    frashCards = [...flashCardSettings];
    frashCards.shuffle();
    _audioPlayer2.setAsset('assets/sounds/OnpuGame1/008.mp3');
    _audioPlayer2.play();

    state = Onpu1PageState(
        isStarted: true,
        isCompleted: false,
        isAllCompleted: false,
        level: state.level,
        index: 0);

    // if (_isTransitioning)
    flash('called from next=============');
  }

  bool isEndFrash() {
    return state.level >= soundIndexes.length;
  }

  void flash(String calledFrom) {
    final int currentGeneration = ++_flashGeneration;
    final int millisec = 1500;
    final int millisec2 = 3000;
    Future.delayed(Duration(milliseconds: _speedType ? millisec : millisec2),
        () {
      if (currentGeneration != _flashGeneration) {
        return;
      }
      if (state.isAllCompleted) {
        _isTransitioning = true;
        return;
      }
      if (state.isCompleted) {
        _isTransitioning = true;
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
      _isTransitioning = false;

      print(calledFrom);
      if (!complete) {
        flash(calledFrom);
      }
    });
  }

  void reset() {
    _flashGeneration++;
    _isPushed = List.empty(growable: true);
    _isPushed.clear();
    print('_backgroundPlayer is stopped');
    _backgroundPlayer.stop();
    print('_audioPlayer  is stopped');
    _audioPlayer.stop();
    print('_audioPlayer2  is stopped');
    _audioPlayer2.stop();
    print('_completedAudioPlayer is stopped');
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
