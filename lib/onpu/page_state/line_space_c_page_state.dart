/*import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:onpu/setting.dart';

class LineSpaceCPageState {
  final int level;

  LineSpaceCPageState({
    required this.level,
  });
}

class LineSpaceCPageStateNotifier extends StateNotifier<LineSpaceCPageState> {
  int _correctCount = 0;
  final _audioPlayer = AudioPlayer();

  LineSpaceCPageStateNotifier() : super(LineSpaceCPageState(level: 0));

  void nextLevel() {
    if (isCompleted()) {
      return;
    }
    int level = state.level;
    level++;
    state = LineSpaceCPageState(level: level);
  }

  bool isCompleted() {
    return (state.level >= lineSpaceQuestions.length);
  }

  int getCorrectCount() {
    return _correctCount;
  }

  void checkCorrect(int idx) {
    if (isCompleted()) {
      return;
    }
    if (lineSpaceQuestions[state.level].correctIndex == idx) {
      _audioPlayer.play(AssetSource('assets/sounds/002.mp3'));
      _correctCount++;
    } else {
      _audioPlayer.play(AssetSource('assets/sounds/005_e.mp3'));
    }
    nextLevel();
  }

  void reset() {
    _correctCount = 0;
    state = LineSpaceCPageState(level: 0);
  }
}

final lineSpaceCPageNotifierProvider =
    StateNotifierProvider<LineSpaceCPageStateNotifier, LineSpaceCPageState>(
  (ref) => LineSpaceCPageStateNotifier(),
);
*/